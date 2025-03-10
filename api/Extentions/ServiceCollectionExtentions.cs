﻿using api.Services.AuthService;
using api.Services.BackgroundServices;
using api.Services.CitizenService;
using api.Services.LogService;
using api.Services.PasswordHasher;
using api.Services.PermissionService;
using api.Services.RemarksService;
using api.Services.Reports.EconomyReportsService;
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
            services.AddScoped<ICitizenService, CitizenService>();
            services.AddScoped<ITableColumnsService, TableColumnService>();
            services.AddScoped<IRemarksService, RemarksService>();
            services.AddScoped<IEconomyReportsService, EconomyReportsService>();

            services.AddQuartz(configure => 
            {
                    var economyJobKey = new JobKey(nameof(EconomyBackgroundService));

                    configure
                        .AddJob<EconomyBackgroundService>(economyJobKey)
                        .AddTrigger(
                            trigger => trigger.ForJob(economyJobKey).StartAt(DateBuilder.FutureDate(30, IntervalUnit.Minute)).WithSimpleSchedule(
                                schedule => schedule.WithIntervalInMinutes(30).RepeatForever().WithMisfireHandlingInstructionIgnoreMisfires()));
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
