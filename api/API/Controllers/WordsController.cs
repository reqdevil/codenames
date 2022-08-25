using API.Controllers.Base;
using DataAccess.Repositories;
using Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Service.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class WordsController : BaseController
    {
        private readonly ILogger<WordsController> _logger;

        private readonly IWordService _wordService;

        public WordsController(ILogger<WordsController> logger, IWordService wordService)
        {
            _logger = logger;
            _wordService = wordService;
        }

        [HttpPost("GetAllWords")]
        public IActionResult GetAllWords()
        {
            islemSonucu = _wordService.GetAllWords();

            return Ok(islemSonucu);
        }
    }
}
