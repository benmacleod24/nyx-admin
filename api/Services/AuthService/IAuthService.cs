﻿using api.DTOs.Response;
using api.Models;

namespace api.Services.AuthService
{
    public interface IAuthService
    {
        public Task<UserDTO> VerifyLoginAndCollectUser(string username, string password);
        public Task<string> CreateAuthToken(UserDTO user);
        public Task<string> CreateAuthToken(UserWithPasswordDTO user);
        public string CreateRefreshToken();
        public Task<RefreshToken> GetRefreshToken(string token);
        public Task<RefreshToken> SetRefreshTokenExpired(string token);
        public Task InvalidateAllUserRefreshTokens(int userId);

    }
}
