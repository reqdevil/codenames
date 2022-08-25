using System;
using System.Collections.Generic;
using System.Text;

namespace Entities
{
    public class UserRooms
    {
        public int UserId { get; set; }
        public Users Users { get; set; }

        public int RoomId { get; set; }
        public Rooms Rooms { get; set; }
    }
}
