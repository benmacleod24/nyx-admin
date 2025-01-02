using api.DTOs.Response;
using api.Models;

namespace api.Extentions
{
    public static class UserExtentions
    {
        public static UserDTO ToDTO(this User user)
        {
            return new UserDTO
            {
                Id = user.Id,
                UserName = user.Username,
                Email = user.Email,
                Role = user.Role != null ? user.Role.ToDTO() : null
            };
        }

        public static UserWithPasswordDTO ToPasswordDTO(this User user, string plaintextPassword)
        {
            return new UserWithPasswordDTO
            {
                Id = user.Id,
                UserName = user.Username,
                Email = user.Email,
                Password = plaintextPassword
            };
        }
    }
}
