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
        private readonly IGameService _gameService;

        public GameController(IHubContext<GameHub> hubContext, IWordService wordService, IGameService gameService)
        {
            _hubContext = hubContext;

            _wordService = wordService;
            _gameService = gameService;
        }

        [HttpPost("SendHint")]
        public IActionResult SendHint(HintDto hint)
        {
            _hubContext.Clients.All.SendAsync("ReceiveHint", hint.Word, hint.Count);

            return Ok();
        }

        [HttpPost("SendAnswer")]
        public IActionResult SendAnswer(HintDto hint)
        {
            _hubContext.Clients.All.SendAsync("ReceiveHint", hint.Word, hint.Count);

            return Ok();
        }

        [HttpGet("StartGame")]
        public IActionResult StartGame(int roomId)
        {
            islemSonucu = _gameService.StartGame();

            return Ok(islemSonucu);
        }
    }
}
