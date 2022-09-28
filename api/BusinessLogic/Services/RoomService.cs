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

        public IslemSonucu FindRoom(UserViewModel user)
        {
            List<SqlParameter> parametreList = new List<SqlParameter>();

            try
            {
                RoomViewModel rmv = null;
                parametreList.Add(new SqlParameter("@userId", user.Id));
                string query = @"select r.Id, r.RoomName, r.IsActive from codenames.Users u
                                    inner join codenames.UserRooms ur on ur.UserId = u.Id
                                    inner join codenames.Rooms r on ur.RoomId = r.Id
                                    where u.Id = @userId and r.IsActive = 1";

                Rooms room = _roomsRepository.GetSql(query, parametreList.ToArray()).FirstOrDefault();

                if (room != null)
                {
                    rmv = new RoomViewModel
                    {
                        RoomId = room.Id,
                        RoomName = room.RoomName,
                        UserId = user.Id,
                    };
                }

                islemSonucu.AccessToken = _tokenHelper.CreateToken(user);
                islemSonucu.Data = rmv;
                islemSonucu.IslemDurumu = IslemDurumu.BasariylaTamamlandi;
                return islemSonucu;
            }
            catch (Exception e)
            {
                islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
                islemSonucu.Mesajlar.Add(e.Message);
                return islemSonucu;
            }
        }

        public IslemSonucu CreateRoom(UserViewModel user)
        {
            bool activeRoomName = false;
            Rooms room = null;

            try
            {
                RoomViewModel rmv;
                islemSonucu = DeleteRoom(user);

                do
                {
                    islemSonucu = _wordService.GetRoomWords();
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

                    if (room != null)
                    {
                        if (room.IsActive)
                        {
                            activeRoomName = true;
                        }
                        else
                        {
                            UserRooms ur = _userRoomRepository.Select(ur => ur.RoomId == room.Id).FirstOrDefault();
                            ur.UserId = user.Id;
                            _userRoomRepository.Update(ur);
                            room = _roomsRepository.Select(r => r.RoomName == roomName).FirstOrDefault();
                            activeRoomName = false;
                        }
                    }
                    else
                    {
                        room = new Rooms
                        {
                            RoomName = roomName,
                            IsActive = true,
                        };

                        _roomsRepository.Insert(room);
                        _worker.Save();

                        UserRooms ur = new UserRooms
                        {
                            RoomId = room.Id,
                            UserId = user.Id,
                        };
                        _userRoomRepository.Insert(ur);
                    }
                } while (activeRoomName);

                _worker.Save();

                rmv = new RoomViewModel
                {
                    RoomId = room.Id,
                    RoomName = room.RoomName,
                    UserId = user.Id,
                };

                islemSonucu.Data = rmv;
                islemSonucu.AccessToken = _tokenHelper.CreateToken(user);
                islemSonucu.IslemDurumu = IslemDurumu.BasariylaTamamlandi;
                return islemSonucu;
            }
            catch (Exception e)
            {
                islemSonucu.Mesajlar.Add(e.Message);
                islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
                return islemSonucu;
            }
        }

        public IslemSonucu JoinRoom(int roomId, UserViewModel user)
        {
            try
            {
                Rooms room = _roomsRepository.Select(r => r.Id == roomId).FirstOrDefault();

                if (room == null)
                {
                    islemSonucu.Mesajlar.Add("Room not found");
                    islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
                    return islemSonucu;
                }

                UserRooms u = _userRoomRepository.Select(u => u.UserId == user.Id).FirstOrDefault();
                if (u == null)
                {
                    UserRooms ur = new UserRooms
                    {
                        RoomId = room.Id,
                        UserId = user.Id,
                    };

                    _userRoomRepository.Insert(ur);
                }

                RoomViewModel rmv = new RoomViewModel
                {
                    RoomId = room.Id,
                    RoomName = room.RoomName,
                    UserId = user.Id,
                };

                _worker.Save();

                islemSonucu.Data = rmv;
                islemSonucu.AccessToken = _tokenHelper.CreateToken(user);
                islemSonucu.IslemDurumu = IslemDurumu.BasariylaTamamlandi;
                return islemSonucu;
            }
            catch (Exception e)
            {
                islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
                islemSonucu.Mesajlar.Add(e.Message);
                return islemSonucu;
            }
        }

        public IslemSonucu DeleteRoom(UserViewModel user)
        {
            List<SqlParameter> parametreList = new List<SqlParameter>();

            try
            {
                parametreList.Add(new SqlParameter("@userId", user.Id));
                string query = @"select r.Id, r.RoomName, r.IsActive from codenames.Users u
                                    inner join codenames.UserRooms ur on ur.UserId = u.Id
                                    inner join codenames.Rooms r on ur.RoomId = r.Id
                                    where u.Id = @userId and r.IsActive = 1";

                Rooms room = _roomsRepository.GetSql(query, parametreList.ToArray()).FirstOrDefault();

                if (room != null)
                {
                    room.IsActive = false;
                    _roomsRepository.Update(room);

                    IEnumerable<UserRooms> ur = _userRoomRepository.Select(ur => ur.RoomId == room.Id);
                    foreach (var u in ur)
                    {
                        _userRoomRepository.Delete(u);
                    }

                    _worker.Save();
                }

                islemSonucu.Data = room;
                islemSonucu.AccessToken = _tokenHelper.CreateToken(user);
                islemSonucu.IslemDurumu = IslemDurumu.BasariylaTamamlandi;
                return islemSonucu;
            }
            catch (Exception e)
            {
                islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
                islemSonucu.Mesajlar.Add(e.Message);
                return islemSonucu;
            }
        }
    }
}
