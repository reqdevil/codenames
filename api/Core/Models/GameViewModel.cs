using Core.Common.Enums;
using System;
using System.Collections.Generic;
using System.Text;

namespace Core.Models
{
    public class GameViewModel
    {
        public Team StartingTeam { get; set; }

        public Team OpposingTeam { get; set; }

        public List<WordViewModel> WordViewModel { get; set; }
    }
}
