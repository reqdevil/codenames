using Core.Common;
using Core.Common.Enums;
using Core.Models;
using Core.Utilities.Security.JWT;
using DataAccess.Repositories;
using DataAccess.UnitOfWorks;
using Entities;
using Microsoft.Data.SqlClient;
using Service.Base;
using Service.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Service.Services
{
    public class RoomService : BaseService, IRoomService
    {
        private readonly IUnitOfWork _worker;

        private readonly IWordService _wordService;

        private readonly ITokenHelper _tokenHelper;

        private readonly IBaseRepository<Rooms> _roomsRepository;
        private readonly IBaseRepository<Users> _userRepository;
        private readonly IBaseRepository<UserRooms> _userRoomRepository;

        public RoomService(IslemSonucu islemSonucu, IUnitOfWork worker, CodenamesEntities codenamesEntities, IWordService wordService, ITokenHelper tokenHelper) : base(islemSonucu)
        {
            _worker = worker;

            _wordService = wordService;

            _tokenHelper = tokenHelper;

            _roomsRepository = new BaseRepository<Rooms>(codenamesEntities);
            _userRepository = new BaseRepository<Users>(codenamesEntities);
            _userRoomRepository = new BaseRepository<UserRooms>(codenamesEntities);
        }

        public IslemSonucu FindRoomById(int userId, UserViewModel user)
        {
            Rooms room = null;
            List<SqlParameter> parametreList = new List<SqlParameter>();

            try
            {
                parametreList.Add(new SqlParameter("@userId", userId));
                string query = @"select r.Id, r.RoomName, r.IsActive from codenames.Users u
                                    inner join codenames.UserRooms ur on ur.UserId = u.Id
                                    inner join codenames.Rooms r on ur.RoomId = r.Id
                                    where u.Id = @userId and r.IsActive = 1";

                room = _roomsRepository.GetSql(query, parametreList.ToArray()).FirstOrDefault();

                RoomViewModel rmv = new RoomViewModel
                {
                    RoomId = room.Id,
                    RoomName = room.RoomName,
                    UserId = userId,
                };

                islemSonucu.accessToken = _tokenHelper.CreateToken(user);
                islemSonucu.Data = rmv;
                islemSonucu.IslemDurumu = IslemDurumu.BasariylaTamamlandi;
            }
            catch (Exception e)
            {
                islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
                islemSonucu.Mesajlar.Add(e.Message);
            }

            return islemSonucu;
        }

        public IslemSonucu FindRoomByUsername(string username, UserViewModel user)
        {
            throw new NotImplementedException();
        }

        public IslemSonucu CreateRoom()
        {
            islemSonucu = _wordService.GetRoomWords();
            Rooms room = null;

            string roomName = "";
            for (int i = 0; i < 3; i++)
            {
                roomName += (islemSonucu.Data as List<Words>).ElementAt(i).Value;

                if (i != 2)
                {
                    roomName += "-";
                }
            }

            room = _roomsRepository.Select(r => r.RoomName == roomName).FirstOrDefault();

            if (room == null)
            {
                room = new Rooms
                {
                    RoomName = roomName,
                    IsActive = true,
                };

                _roomsRepository.Insert(room);
            }
            else if (!room.IsActive)
            {
                room.IsActive = true;
                _roomsRepository.Update(room);
            }
            else
            {
                islemSonucu = CreateRoom();
                room = islemSonucu.Data as Rooms;
            }

            _worker.Save();

            islemSonucu.Data = room;
            islemSonucu.IslemDurumu = IslemDurumu.BasariylaTamamlandi;
            return islemSonucu;
        }

        public IslemSonucu JoinRoom(int userId, string roomName)
        {
            Rooms room = null;
            Users user = null;

            room = _roomsRepository.Select(r => r.RoomName == roomName).FirstOrDefault();

            if (room == null)
            {
                throw new Exception("Room not found.");
            }

            user = _userRepository.FindById(userId);

            UserRooms userRoom = new UserRooms
            {
                RoomId = room.Id,
                Rooms = room,
                UserId = user.Id,
                Users = user,
            };

            _userRoomRepository.Insert(userRoom);

            islemSonucu.Data = true;
            islemSonucu.IslemDurumu = IslemDurumu.BasariylaTamamlandi;
            return islemSonucu;
        }
    }
}
