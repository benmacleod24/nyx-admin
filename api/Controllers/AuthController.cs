using api.DTOs.Request;
using api.DTOs.Response;
using api.Models;
using api.Services.AuthService;
using api.Services.UserService;
using api.Services.PasswordHasher;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly IUserService userService;
        private readonly IAuthService authService;
        private readonly IPasswordHasher passwordHasher;
        private readonly DatabaseContext dbContext;

        public AuthController(IUserService userService, IAuthService authService, IPasswordHasher passwordHasher, DatabaseContext dbContext)
        {
            this.userService = userService;
            this.authService = authService;
            this.passwordHasher = passwordHasher;
            this.dbContext = dbContext;
        }

        [HttpPost("register")]
        public async Task<ActionResult> RegisterUser(CreateUserDTO userData)
        {
            UserWithPasswordDTO createdUser = await userService.CreateUser(userData);
            return Ok(createdUser);
        }

        [HttpPost("login")]
        public async Task<ActionResult> Login(LoginBodyDTO loginData)
        {
            // Verify the login information and collect the user.
            UserDTO verifiedUser = await authService.VerifyLoginAndCollectUser(loginData.Username, loginData.Password);

            // Create Refresh & Auth Tokens
            string authToken = await authService.CreateAuthToken(verifiedUser);
            string refreshToken = authService.CreateRefreshToken();

            // With new refresh token we want to invalidate all other tokens.
            await authService.InvalidateAllUserRefreshTokens(verifiedUser.Id);

            // Set refresh token in DB and cookie.
            await SetRefreshToken(verifiedUser.Id, refreshToken);

            return Ok(new
            {
                authToken = authToken,
                data = verifiedUser
            });
        }

        [HttpGet("refresh")]
        public async Task<ActionResult> RefreshAuth()
        {
            string? refreshToken = Request.Cookies["X-Refresh-Token"];

            // Refresh token not found.
            if (string.IsNullOrEmpty(refreshToken))
            {
                return Unauthorized("Refresh token not found.");
            }

            Console.WriteLine("=======START TOKEN========");
            Console.WriteLine(refreshToken);

            RefreshToken refreshTokenData = await authService.GetRefreshToken(refreshToken);

            // Refresh token data not found.
            if (refreshTokenData == null)
            {
                throw new Exception("Refresh token data not found.");
            }

            // Refresh token is expired.
            if (refreshTokenData.ExpiresAt < DateTime.UtcNow)
            {
                throw new Exception("Refresh token is expired.");
            };

            UserDTO? userData = await userService.GetUser(refreshTokenData.UserId);

            if (userData == null)
            {
                throw new Exception("User not found.");
            }

            // Generate new refresh & auth tokens.
            string newRefreshToken = authService.CreateRefreshToken();
            string newAuthToken = await authService.CreateAuthToken(userData);

            // Invalidate all other tokens.
            //await authService.InvalidateAllUserRefreshTokens(refreshTokenData.UserId);

            // Set new token in DB and Cookies.
            await SetRefreshToken(refreshTokenData.UserId, newRefreshToken);

            return Ok(new
            {
                authToken = newAuthToken,
                data = userData
            });

        }

        [HttpDelete("logout")]
        public async Task<ActionResult> Logout()
        {
            string? refreshToken = Request.Cookies["X-Refresh-Token"];

            // Refresh token not found.
            if (string.IsNullOrEmpty(refreshToken))
            {
                return Unauthorized("Refresh token not found.");
            }

            // Get the refresh token data.
            RefreshToken refreshTokenData = await authService.GetRefreshToken(refreshToken);

            // Invalidate all user tokens.
            await authService.InvalidateAllUserRefreshTokens(refreshTokenData.UserId);

            // Delete cookie from response
            Response.Cookies.Delete("X-Refresh-Token");

            return Ok();
        }


        private async Task SetRefreshToken(int userId, string refreshToken)
        {
            // Set cookie to expire in 30 days.
            DateTime expiresIn = DateTime.UtcNow.AddDays(30);

            RefreshToken _refreshToken = new RefreshToken
            {
                UserId = userId,
                ExpiresAt = expiresIn,
                Token = refreshToken
            };

            // Save new refresh token record.
            dbContext.RefreshTokens.Add(_refreshToken);
            await dbContext.SaveChangesAsync();

            // Push token to a cookie.
            Response.Cookies.Append("X-Refresh-Token", refreshToken, new CookieOptions
            {
                Expires = expiresIn,
                HttpOnly = true,
                Secure = true,
                IsEssential = true,
                SameSite = SameSiteMode.None
            });
        }

    }
}
