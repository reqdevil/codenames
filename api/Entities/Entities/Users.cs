using System;
using System.Collections.Generic;
using System.Text;

namespace Entities
{
    public partial class Users
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public string Email { get; set; }

        public ICollection<UserRooms> UserRooms { get; set; }
        public EncryptionKeys EncryptionKeys { get; set; }
        public Passwords Passwords { get; set; }
    }
}
