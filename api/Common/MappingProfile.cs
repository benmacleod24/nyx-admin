using api.DTOs.Response;
using api.Models;
using api.Models.Game;
using AutoMapper;
using System.Text.Json;

namespace api.Common
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Role, RoleDTO>();
            CreateMap<Permission, PermissionDTO>();
            CreateMap<Player, PlayerDTO>();
            CreateMap<User, UserDTO>();
            CreateMap<Log, LogDTO>()
                .ForMember(dest => dest.Metadata, opt => opt.MapFrom(src => src.Metadata));
            CreateMap<IEnumerable<LogMetadataEntry>, Dictionary<string, object>>()
                .ConvertUsing<MetaDataToDictionaryConverter>();
        }
    }

    public class MetaDataToDictionaryConverter : ITypeConverter<IEnumerable<LogMetadataEntry>, Dictionary<string, object>>
    {
        public Dictionary<string, object> Convert(IEnumerable<LogMetadataEntry> source, Dictionary<string, object> destination, ResolutionContext context)
        {
            return source.ToDictionary(entry => entry.Key, entry => JsonSerializer.Deserialize<object>(entry.Value));
        }
    }
}