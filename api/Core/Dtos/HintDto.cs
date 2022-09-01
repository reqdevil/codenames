using Core.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Core.Dtos
{
    public class HintDto
    {
        public int UserId { get; set; }

        public WordViewModel Word { get; set; }
    }
}
