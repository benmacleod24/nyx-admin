using api.Common;
using api.Extentions;
using api.Models;
using api.Models.Game;
using AutoMapper;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddDbContextPool<DatabaseContext>(options =>
    options.UseMySql(
        builder.Configuration.GetConnectionString("DB_Connection"), 
        ServerVersion.AutoDetect(builder.Configuration.GetConnectionString("DB_Connection"))
    )
);

builder.Services.AddDbContextPool<GameDataContext>(options =>
    options.UseMySql(
        builder.Configuration.GetConnectionString("Game_DB_Connection"),
        ServerVersion.AutoDetect(builder.Configuration.GetConnectionString("Game_DB_Connection")),
        options => options
                    .UseNewtonsoftJson(MySqlCommonJsonChangeTrackingOptions.FullHierarchyOptimizedFast)
    )
);

builder.Services.AddAuthorization();

// Setup JWT token authentication.
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateIssuerSigningKey = true,
            ValidateLifetime = true,
            ValidIssuer = builder.Configuration["JwtConfig:Issuer"],
            ValidAudience = builder.Configuration["JwtConfig:Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["JwtConfig:Key"])),
        };
    });

// Add CORS Policy
builder.Services.AddCors(options =>
{
    options.AddPolicy("Policy", policy =>
    {
        policy.WithOrigins("http://localhost:5173");
        policy.AllowAnyHeader();
        policy.AllowAnyMethod();
        policy.AllowCredentials();
    });
});

builder.Services.Configure<RouteOptions>(options =>
{
    options.LowercaseUrls = true;
});

var mapperConfig = new MapperConfiguration(mc => {
    mc.AddProfile(new MappingProfile());
});

IMapper mapper = mapperConfig.CreateMapper();
builder.Services.AddSingleton(mapper);
 
// Add our dependency injection into the app.
builder.Services.AddApplicationServices();

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


var app = builder.Build();

// Seed the database.
using (IServiceScope? scrope = app.Services.CreateScope())
{
    DatabaseContext context = scrope.ServiceProvider.GetRequiredService<DatabaseContext>();
    await DatabaseSeeder.Seed(context);
}

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.UseGlobalExceptionHandler();

// Apply frontend cors policy.
app.UseCors("Policy");

app.Run();
