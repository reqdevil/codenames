using API.Controllers.Base;
using API.Hubs;
using Core.Common;
using Core.Dtos;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Service.Interfaces;

namespace API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GameController : BaseController
    {
        private readonly IHubContext<GameHub> _hubContext;

        private readonly IWordService _wordService;

        public GameController(IHubContext<GameHub> hubContext, IWordService wordService)
        {
            _hubContext = hubContext;

            _wordService = wordService;
        }

        [HttpPost("SendHint")]
        public IActionResult SendHint(HintDto hint)
        {
            _hubContext.Clients.All.SendAsync("ReceiveHint", hint.UserId, hint.Word);
            
            return Ok();
        }

        [HttpPost("SendAnswer")]
        public IActionResult SendAnswer(HintDto hint)
        {
            _hubContext.Clients.All.SendAsync("ReceiveHint", hint.UserId, hint.Word);

            return Ok();
        }

        [HttpGet("StartGame")]
        public IActionResult StartGame(int roomId)
        {
            islemSonucu = _wordService.GetPlayWords();

            return Ok(islemSonucu);
        }
    }
}
