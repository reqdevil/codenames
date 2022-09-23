using API.Controllers.Base;
using API.Hubs;
using Core.Models;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNetCore.Mvc;
using Service.Interfaces;

namespace API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RoomController : BaseController
    {
        private readonly IGameHub _gameHub;
        private readonly IRoomService _roomService;

        public RoomController(IRoomService roomService, IGameHub gameHub)
        {
            _roomService = roomService;
            _gameHub = gameHub;
        }


        [HttpGet("CreateRoom")]
        public IActionResult CreateRoom()
        {
            islemSonucu = _roomService.CreateRoom();

            return Ok(islemSonucu);
        }

        [HttpGet("JoinRoom")]
        public IActionResult JoinRoom(int userId, string roomName)
        {
            _gameHub.JoinRoom(roomName);

            //islemSonucu = _roomService.JoinRoom(userId, roomName);

            //return Ok(islemSonucu);
            return Ok();
        }

        [HttpPost("FindRoom")]
        public IActionResult FindRoom(UserViewModel user)
        {
            islemSonucu = _roomService.FindRoom(user.Id);

            return Ok(islemSonucu);
        }
    }
}
