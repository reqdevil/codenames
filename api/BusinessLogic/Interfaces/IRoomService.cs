using Core.Common;
using Core.Models;
using Service.Base;
using System;
using System.Collections.Generic;
using System.Text;

namespace Service.Interfaces
{
    public interface IRoomService : IBaseService
    {
        IslemSonucu FindRoom(UserViewModel user);

        IslemSonucu CreateRoom(UserViewModel user);

        IslemSonucu JoinRoom(int roomId, UserViewModel user);

        IslemSonucu DeleteRoom(UserViewModel user);

        IslemSonucu FindRoomAdmin(int roomId, UserViewModel user);
    }
}
