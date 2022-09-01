using API.Controllers.Base;
using Core.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Service.Interfaces;

namespace API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : BaseController
    {
        private readonly IUserService _userService;

        public UserController(IUserService userService)
        {
            _userService = userService;
        }

        [HttpPost("Login")]
        [AllowAnonymous]
        public IActionResult Login(UserViewModel user)
        {
            islemSonucu = _userService.Login(user);

            return Ok(islemSonucu);
        }

        [HttpPost("Sign")]
        [AllowAnonymous]
        public IActionResult Sign(UserViewModel user)
        {
            islemSonucu = _userService.Sign(user);

            return Ok(islemSonucu);
        }
    }
}
