using api.Services.AuthService;
using api.Services.CharacterService;
using api.Services.LogService;
using api.Services.PasswordHasher;
using api.Services.PermissionService;
using api.Services.RoleService;
using api.Services.TableColumnsService;
using api.Services.UserService;

namespace api.Extentions
{
    public static class ServiceCollectionExtentions
    {

        public static IServiceCollection AddApplicationServices(this IServiceCollection services)
        {
            services.AddScoped<IUserService, UserService>();
            services.AddScoped<IPasswordHasher, PasswordHasher>();
            services.AddScoped<IAuthService, AuthService>();
            services.AddScoped<IRoleService, RoleService>();
            services.AddScoped<IPermissionService, PermissionService>();
            services.AddScoped<ILogService, LogService>();
            services.AddScoped<IPlayerService, PlayerService>();
            services.AddScoped<ITableColumnsService, TableColumnService>();

            return services;
        }

    }
}
