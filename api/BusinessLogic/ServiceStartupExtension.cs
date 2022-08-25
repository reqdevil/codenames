using Core.Utilities.Security.Encryption;
using Core.Utilities.Security.Encryption.Cipher;
using Core.Utilities.Security.JWT;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Service.Interfaces;
using Service.Services;

namespace Service
{
    public static class ServiceStartupExtension
    {
        public static void AddServices(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddScoped<IUserService, UserService>();
            services.AddScoped<IWordService, WordService>();

            services.AddScoped<ITokenHelper, TokenHelper>();
            services.AddScoped<IPasswordHasher, PasswordHasher>();
            services.AddScoped<ICipherService, CipherService>();
        }
    }
}
