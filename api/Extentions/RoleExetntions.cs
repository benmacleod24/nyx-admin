using api.DTOs.Response;
using api.Models;

namespace api.Extentions 
{
    public static class RoleExtentions 
    {
        public static RoleDTO ToDTO(this Role role)
        {
            return new RoleDTO
            {
                Id = role.Id,
                Key = role.Key,
                OrderLevel = role.OrderLevel,
                FriendlyName = role.FriendlyName
            };
        }
    }
}