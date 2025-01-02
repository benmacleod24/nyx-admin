using api.DTOs.Response;
using api.Extentions;
using api.Models;
using api.Services.PasswordHasher;
using api.Services.UserService;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace api.Services.AuthService
{
    public class AuthService : IAuthService
    {
        private readonly DatabaseContext dbContext;
        private readonly IConfiguration _configuration;
        private readonly IPasswordHasher _passwordHasher;
        private readonly IUserService _userService;

        public AuthService(DatabaseContext dbContext, IConfiguration configuration, IPasswordHasher passwordHasher, IUserService userService)
        {
            this.dbContext = dbContext;
            _configuration = configuration;
            _passwordHasher = passwordHasher;
            _userService = userService;
        }

        public async Task<UserDTO> VerifyLoginAndCollectUser(string username, string password)
        {
            User? user = await dbContext.Users
                .Where(u => u.Username.Equals(username))
                .Include(u => u.Role)
                .FirstOrDefaultAsync();

            // User with given username not found.
            if (user == null || user.Password == null)
            {
                throw new Exception("Invalid Username/Password");
            }

            bool isValidPassword = _passwordHasher.VerifyPassword(password, user.Password);

            // Password was invalid.
            if (!isValidPassword)
            {
                throw new Exception("Invalid Username/Password");
            }

            return user.ToDTO();
        }

        public async Task<string> CreateAuthToken(UserDTO user)
        {
            string TokenIssuer = _configuration["JwtConfig:Issuer"];
            string TokenAudience = _configuration["JwtConfig:Audience"];
            string TokenKey = _configuration["JwtConfig:Key"];

            RoleDTO userRole = await _userService.GetUserRoleById(user.Id);

            if (userRole == null) 
            {
                throw new Exception("User role has not been assigned.");
            }

            SecurityTokenDescriptor tokenDescriptor = new SecurityTokenDescriptor
            {
                Issuer = TokenIssuer,
                Audience = TokenAudience,
                Expires = DateTime.UtcNow.AddMinutes(15),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(Encoding.ASCII.GetBytes(TokenKey)), SecurityAlgorithms.HmacSha256Signature),
                Subject = new ClaimsIdentity(new[]
                {
                    new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                    new Claim(ClaimTypes.Role, userRole.Key)
                })
            };

            JwtSecurityTokenHandler tokenHandler = new JwtSecurityTokenHandler();
            SecurityToken token = tokenHandler.CreateToken(tokenDescriptor);
            string authToken = tokenHandler.WriteToken(token);

            return authToken;
        }

        public async Task<string> CreateAuthToken(UserWithPasswordDTO user)
        {
            return await CreateAuthToken(new UserDTO
            {
                UserName = user.UserName,
                Email = user.Email,
                Id = user.Id,
            });
        }

        public string CreateRefreshToken()
        {
            return Convert.ToBase64String(RandomNumberGenerator.GetBytes(64));
        }

        public async Task<RefreshToken?> GetRefreshToken(string token)
        {
            RefreshToken? refreshToken = await dbContext.RefreshTokens
                .Where(v => v.Token.Equals(token) && v.IsExpired == false)
                .FirstOrDefaultAsync();

            return refreshToken;
        }

        public async Task<RefreshToken> SetRefreshTokenExpired(string token)
        {
            RefreshToken? refreshToken = await GetRefreshToken(token);

            if (refreshToken == null)
            {
                throw new Exception("Refresh token not found.");
            }

            refreshToken.IsExpired = true;

            try
            {
                await dbContext.SaveChangesAsync();
                return refreshToken;
            }
            catch (DbUpdateConcurrencyException)
            {
                throw;
            }
        }

        /**
         * This function is used to invalidate all refresh tokens for a user.
         * Used in the case when a user logs in we will invalidate any tokens not taken care of during the logout process.
         */
        public async Task InvalidateAllUserRefreshTokens(int userId)
        {
            await dbContext.RefreshTokens
                .Where(v => v.UserId.Equals(userId) && !v.IsExpired)
                .ExecuteUpdateAsync(s => s.SetProperty(v => v.IsExpired, v => true));
        }
    }
}
