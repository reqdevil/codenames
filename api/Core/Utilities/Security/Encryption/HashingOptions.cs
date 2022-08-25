using System;
using System.Collections.Generic;
using System.Text;

namespace Core.Utilities.Security.Encryption
{
    public sealed class HashingOptions
    {
        public int Iterations { get; set; } = 10000;
    }
}
