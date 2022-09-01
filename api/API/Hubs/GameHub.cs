using Core.Models;
using Microsoft.AspNetCore.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.Hubs
{
    public class GameHub: Hub
    {
        public async Task SendHint(int userId, WordViewModel hint)
        {
            await Clients.Others.SendAsync("ReceiveHint", userId, hint);
        }

        public async Task SendAnswer(int userId, WordViewModel hint)
        {
            await Clients.Others.SendAsync("ReceiveAnswer", userId, hint);
        }
    }
}
