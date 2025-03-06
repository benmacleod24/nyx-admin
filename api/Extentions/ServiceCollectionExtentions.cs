using api.Services.AuthService;
using api.Services.BackgroundServices;
using api.Services.CharacterService;
using api.Services.LogService;
using api.Services.PasswordHasher;
using api.Services.PermissionService;
using api.Services.RoleService;
using api.Services.TableColumnsService;
using api.Services.UserService;
using Quartz;

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

            services.AddQuartz(configure => 
            {
                    var jobKey = new JobKey(nameof(PlayerBackgroundService));

                    configure
                        .AddJob<PlayerBackgroundService>(jobKey)
                        .AddTrigger(
                            trigger => trigger.ForJob(jobKey).WithSimpleSchedule(
                                schedule => schedule.WithIntervalInSeconds(30).RepeatForever()));
            });

            // Setup Quartz services.
            services.AddQuartzHostedService(options => 
            {
                options.WaitForJobsToComplete = true;
            });

            return services;
        }

    }
}
