using Core.Utilities.Security.Encryption.Cipher;
using Microsoft.AspNetCore.DataProtection;
using System;
using System.Collections.Generic;
using System.Text;

namespace Core.Utilities.Security.Encryption
{
    public class CipherService : ICipherService
    {
        private readonly IDataProtectionProvider _dataProtectionProvider;

        public CipherService(IDataProtectionProvider dataProtectionProvider)
        {
            _dataProtectionProvider = dataProtectionProvider;
        }

        public string Encrypt(string password, string key)
        {
            var protector = _dataProtectionProvider.CreateProtector(key);
            return protector.Protect(password);
        }

        public string Decrypt(string encryptedPassword, string key)
        {
            var protector = _dataProtectionProvider.CreateProtector(key);
            return protector.Unprotect(encryptedPassword);
        }
    }
}
