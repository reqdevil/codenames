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
        private readonly IWordService _wordService;

        public WordController(IWordService wordService)
        {
            _wordService = wordService;
        }

        [HttpGet("GetAllWords")]
        public IActionResult GetAllWords()
        {
            islemSonucu = _wordService.GetAllWords();

            return Ok(islemSonucu);
        }

        [HttpGet("GetPlayWords")]
        public IActionResult GePlayWords()
        {
            islemSonucu = _wordService.GetPlayWords();

            return Ok(islemSonucu);
        }
    }
}
