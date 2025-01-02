﻿using api.DTOs.Request;
using api.DTOs.Response;

namespace api.Services.UserService
{
    public interface IUserService
    {
        public Task<UserWithPasswordDTO> CreateUser(CreateUserDTO userData);
        public Task<UserWithPasswordDTO?> GetUserWithPassword(int userId);
        public Task<UserWithPasswordDTO?> GetUserWithPasswordFromUsername(string username);
        public Task<UserDTO?> GetUser(int userId);
        public Task<bool> DoesUsernameExist(string userName);
        public string GenerateRandomPassword();
    }
}