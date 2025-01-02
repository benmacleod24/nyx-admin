using api.Services.AuthService;
using api.Services.PasswordHasher;
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

            return services;
        }

    }
}
