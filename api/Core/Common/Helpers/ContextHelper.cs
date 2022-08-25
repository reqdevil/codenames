using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Text;

namespace Core.Common.Helpers
{
    public static class ContextHelper
    {
        private static IHttpContextAccessor httpContextAccessor;
        public static void SetHttpContextAccessor(IHttpContextAccessor accessor)
        {
            httpContextAccessor = accessor;
        }

        public static string GetCurrentUserIp()
        {
            string result = "IP:";
            try
            {
                var HttpContext = httpContextAccessor.HttpContext;
                result += HttpContext.Request.Headers["X-FORMARDED-FOR"];
                result += "!";
            }
            catch (Exception exp)
            {
                System.IO.File.WriteAllText(@"C:\error.txt", exp.Message);
            }
            return result;
        }

        public static HttpContext GetHttpContext()
        {
            var httpContext = httpContextAccessor.HttpContext;

            return httpContext;
        }
    }
}
