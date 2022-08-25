using System;
using System.Collections.Generic;
using System.Text;

namespace Entities
{
    public partial class Passwords
    {
        public int Id { get; set; }
        public string Value { get; set; }

        public int UserId { get; set; }
        public Users Users { get; set; }
    }
}
