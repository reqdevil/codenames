using Core.Common;
using System;
using System.Collections.Generic;
using System.Text;

namespace Service.Interfaces
{
    public interface IWordService
    {
        IslemSonucu GetAllWords();

        IslemSonucu GetPlayWords();
    }
}
