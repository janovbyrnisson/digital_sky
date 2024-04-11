using DigitalSky.Hubs;
using DigitalSkyServer.Services;
using Microsoft.AspNetCore.Cors.Infrastructure;

const string CORS_POLICY = "SdigitalSky.cors_policy.allowAll";

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<AwsCryptoService>();
builder.Services.AddSingleton<DigitalSkyBrokerService>();

builder.Services.AddCors(options =>
{
    options.AddPolicy(CORS_POLICY,
        policy =>
        {
            policy.WithOrigins("http://localhost:8091", "http://localhost:8092", "https://eroslevente.com", "https://www.eroslevente.com")
                  .AllowAnyHeader()
                  .AllowAnyMethod()
                  .AllowCredentials()
                  .Build();
        });
});

builder.Services.AddSignalR(options =>
    {
        options.EnableDetailedErrors = true;
    });

var app = builder.Build();

app.UseCors(CORS_POLICY);
app.UseAuthorization();

app.MapGet("/", () => "Welcome Player!!!");
app.MapHub<DigitalSkyHub>("/channel");

app.Run();
