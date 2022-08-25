using System;
using System.Collections.Generic;
using System.Text;

namespace Entities
{
    public partial class Words
    {
        public int Id { get; set; }
        public string Value { get; set; }

        public ICollection<RoomWords> RoomWords { get; set; }
    }
}
