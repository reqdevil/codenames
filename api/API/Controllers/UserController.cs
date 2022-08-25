using API.Controllers.Base;
using Core.Models;
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
    public class UserController : BaseController
    {
        private readonly ILogger<UserController> _logger;

        private readonly IUserService _userService;

        public UserController(ILogger<UserController> logger, IUserService userService)
        {
            _logger = logger;
            _userService = userService;
        }

        [HttpPost("Login")]
        [AllowAnonymous]
        public IActionResult Login(User user)
        {
            islemSonucu = _userService.Login(user);

            return Ok(islemSonucu);
        }

        [HttpPost("Sign")]
        [AllowAnonymous]
        public IActionResult Sign(User user)
        {
            var valid = IsModelValid(user);

            islemSonucu = _userService.Sign(user);

            return Ok(islemSonucu);
        }
    }
}
