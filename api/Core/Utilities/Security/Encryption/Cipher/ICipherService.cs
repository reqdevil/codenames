using System;
using System.Collections.Generic;
using System.Text;

namespace Core.Utilities.Security.Encryption.Cipher
{
    public interface ICipherService
    {
        public string Encrypt(string input, string key);

        public string Decrypt(string cipherText, string key);
    }
}
