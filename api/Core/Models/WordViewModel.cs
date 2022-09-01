using Core.Common.Enums;
using System;
using System.Collections.Generic;
using System.Text;

namespace Core.Models
{
    public class WordViewModel
    {
        public string Vocable { get; set; }

        public int Count { get; set; }

        public WordAttribute WordAttribute { get; set; }
    }
}
