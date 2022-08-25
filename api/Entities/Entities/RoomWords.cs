using System;
using System.Collections.Generic;
using System.Text;

namespace Entities
{
    public class RoomWords
    {
        public int RoomId { get; set; }
        public Rooms Rooms { get; set; }

        public int WordId { get; set; }
        public Words Words { get; set; }
    }
}
