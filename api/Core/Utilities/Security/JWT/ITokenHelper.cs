using Core.Models;
using NuGet.Protocol.Plugins;
using System;
using System.Collections.Generic;
using System.Text;

namespace Core.Utilities.Security.JWT
{
    public interface ITokenHelper
    {
        AccessToken CreateToken(UserViewModel user/*, List<OperationClaim>? operationClaims*/);
    }
}
