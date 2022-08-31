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
    public class WordController : BaseController
    {
        private readonly ILogger<WordController> _logger;

        private readonly IWordService _wordService;

        public WordController(ILogger<WordController> logger, IWordService wordService)
        {
            _logger = logger;
            _wordService = wordService;
        }

        [HttpGet("GetAllWords")]
        public IActionResult GetAllWords()
        {
            islemSonucu = _wordService.GetAllWords();

            return Ok(islemSonucu);
        }
    }
}
