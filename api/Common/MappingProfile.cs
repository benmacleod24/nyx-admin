using api.DTOs.Response;
using api.Models;
using AutoMapper;

namespace api.Common
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Role, RoleDTO>();
            CreateMap<Permission, PermissionDTO>();
        }
    }
}