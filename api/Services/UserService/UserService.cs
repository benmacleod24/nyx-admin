using api.DTOs.Request;
using api.DTOs.Response;
using api.Extentions;
using api.Models;
using api.Services.PasswordHasher;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;

namespace api.Services.UserService
{
    public class UserService : IUserService
    {
        private readonly DatabaseContext dbContext;
        private readonly IPasswordHasher passwordHasher;
        private readonly IMapper _mapper;

        public UserService(DatabaseContext dbContext, IPasswordHasher passwordHasher, IMapper mapper)
        {
            this.dbContext = dbContext;
            this.passwordHasher = passwordHasher;
            _mapper = mapper;
        }

        public async Task<UserWithPasswordDTO> CreateUser(CreateUserDTO userData)
        {
            if (await DoesUsernameExist(userData.UserName))
            {
                throw new Exception("User with given username already exists.");
            }

            string? password = userData.Password;
            string? plainTextPassword = password;

            // Generate a random password if there is not a set password.
            if (password == null || password == string.Empty)
            {
                plainTextPassword = GenerateRandomPassword();
                password = plainTextPassword;
            }

            string hashedPassword = passwordHasher.HashPassword(password);

            User user = new User
            {
                Username = userData.UserName.ToLower().Trim(),
                Password = hashedPassword,
            };

            // Save user to the database.
            dbContext.Users.Add(user);
            await dbContext.SaveChangesAsync();

            return user.ToPasswordDTO(plainTextPassword);
        }

        public async Task<bool> DoesUsernameExist(string userName)
        {
            int userWithUsername = await dbContext.Users.Where(v => v.Username == userName.ToLower().Trim()).CountAsync();
            return userWithUsername > 0;
        }

        public string GenerateRandomPassword()
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*";
            char[] password = new char[10];

            using (var rng = RandomNumberGenerator.Create())
            {
                byte[] randomBytes = new byte[10];
                rng.GetBytes(randomBytes);

                for (int i = 0; i < 10; i++)
                {
                    password[i] = chars[randomBytes[i] % chars.Length];
                }
            }

            return new string(password);
        }

        public async Task<UserWithPasswordDTO?> GetUserWithPassword(int userId)
        {
            User? user = await dbContext.Users
                .Where(v => v.Id.Equals(userId))
                .SingleOrDefaultAsync();

            return user == null ? null : user.ToPasswordDTO(user.Password);
        }

        public async Task<UserWithPasswordDTO?> GetUserWithPasswordFromUsername(string username)
        {
            User? user = await dbContext.Users
                .Where(v => v.Username.Equals(username))
                .SingleOrDefaultAsync();

            return user == null ? null : user.ToPasswordDTO(user.Password);
        }

        public async Task<UserDTO?> GetUser(int userId)
        {
            User? user = await dbContext.Users
                .Where(v => v.Id.Equals(userId))
                .Include(r => r.Role)
                .SingleOrDefaultAsync();

            return user == null ? null : user.ToDTO();
        }

        public async Task<RoleDTO?> GetUserRoleById(int userId)
        {
            RoleDTO? role = await dbContext.Users
                .Where(u => u.Id.Equals(userId))
                .Select(u => u.Role)
                .ProjectTo<RoleDTO>(_mapper.ConfigurationProvider)
                .FirstOrDefaultAsync();

            return role;
        }
    }
}
