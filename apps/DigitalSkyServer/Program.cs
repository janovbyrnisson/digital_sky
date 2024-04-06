using DigitalSky.Hubs;
using Microsoft.AspNetCore.Cors.Infrastructure;

const string CORS_POLICY = "SdigitalSky.cors_policy.allowAll";

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddCors(options =>
{
    options.AddPolicy(CORS_POLICY,
        policy =>
        {
            policy.WithOrigins("http://localhost:60321", "http://localhost:60416", "http://eroslevente.com")
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
