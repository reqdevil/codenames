using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace Core.Utilities.Security.Encryption
{
    public sealed class PasswordHasher: IPasswordHasher
    {
        private HashingOptions Options { get; }

        private const int saltSize = 16;
        private const int keySize = 32;

        public PasswordHasher(IOptions<HashingOptions> op)
        {
            Options = op.Value;
        }

        public string Hash(string password)
        {
            using var algo = new Rfc2898DeriveBytes(
                password,
                saltSize,
                Options.Iterations,
                HashAlgorithmName.SHA256);
            var key = Convert.ToBase64String(algo.GetBytes(keySize));
            var salt = Convert.ToBase64String(algo.Salt);

            return $"{Options.Iterations}.{salt}.{key}";
        }

        public (bool Verified, bool NeedsUpgrade) Check(string hash, string password)
        {
            var parts = hash.Split(".", 3);

            if (parts.Length != 3)
            {
                throw new FormatException("Beklenmeyen hash formatı. " + "Beklenilen format '{iteration}.{salt}.{hash}'");
            }

            var iterations = Convert.ToInt32(parts[0]);
            var salt = Convert.FromBase64String(parts[1]);
            var key = Convert.FromBase64String(parts[2]);

            var needsUpgrade = iterations != Options.Iterations;

            using var algo = new Rfc2898DeriveBytes(
                password,
                salt,
                iterations,
                HashAlgorithmName.SHA256);
            var keyToCheck = algo.GetBytes(keySize);
            var verified = keyToCheck.SequenceEqual(key);

            return (verified, needsUpgrade);
        }
    }
}
