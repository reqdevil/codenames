using Core.Common;
using Service.Base;
using System;
using System.Collections.Generic;
using System.Text;

namespace Service.Interfaces
{
    public interface IWordService: IBaseService
    {
        IslemSonucu GetAllWords();

        IslemSonucu GetPlayWords();

        IslemSonucu GetRoomWords();
    }
}
