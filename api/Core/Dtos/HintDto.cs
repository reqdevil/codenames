using Core.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Core.Dtos
{
    public class HintDto
    {
        public int UserId { get; set; }

        public Word Word { get; set; }
    }
}
