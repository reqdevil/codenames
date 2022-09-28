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
        private readonly IRoomService _roomService;

        public RoomController(IRoomService roomService)
        {
            _roomService = roomService;
        }

        [HttpPost("FindRoom")]
        public IActionResult FindRoom(UserViewModel user)
        {
            islemSonucu = _roomService.FindRoom(user);

            return Ok(islemSonucu);
        }

        [HttpPost("CreateRoom")]
        public IActionResult CreateRoom(UserViewModel user)
        {
            islemSonucu = _roomService.CreateRoom(user);

            return Ok(islemSonucu);
        }

        [HttpPost("JoinRoom")]
        public IActionResult JoinRoom(int roomId, UserViewModel user)
        {
            islemSonucu = _roomService.JoinRoom(roomId, user);

            return Ok(islemSonucu);
        }

        [HttpPost("DeleteRoom")]
        public IActionResult DeleteRoom(UserViewModel user)
        {
            islemSonucu = _roomService.DeleteRoom(user);

            return Ok(islemSonucu);
        }
    }
}
