using System;
using System.Collections.Generic;
using System.Text;

namespace Entities
{
    public class Rooms
    {
        public int Id { get; set; }
        public string RoomName { get; set; }
        public bool IsActive { get; set; }
        public int? AdminId { get; set; }

        public ICollection<UserRooms> UserRooms { get; set; }
        public ICollection<RoomWords> RoomWords { get; set; }
    }
}
