using System;
using System.Collections.Generic;
using System.Text;

namespace Entities
{
    public partial class EncryptionKeys
    {
        public int Id { get; set; }
        public string Value { get; set; }

        public int UserId { get; set; }
        public Users User { get; set; }
    }
}
