using Core.Common;
using Core.Models;
using Service.Base;
using System;
using System.Collections.Generic;
using System.Text;

namespace Service.Interfaces
{
    public interface IRoomService: IBaseService
    {
        IslemSonucu FindRoomById(int userId, UserViewModel user);

        IslemSonucu FindRoomByUsername(string username, UserViewModel user);

        IslemSonucu CreateRoom();

        IslemSonucu JoinRoom(int userId, string roomName);
    }
}
