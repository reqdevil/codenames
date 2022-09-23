using Core.Models;
using Microsoft.AspNet.SignalR.Hubs;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using System;
using System.Collections.Concurrent;
using System.Threading.Tasks;

namespace API.Hubs
{
    public class GameHub: Hub, IGameHub
    {
        public async Task JoinRoom(string roomName)
        { 
            await Groups.AddToGroupAsync(Context.ConnectionId, roomName);
            await Clients.Group(roomName).SendAsync("UserJoined", Context.User.Identity.Name + " joined.");
        }

        public async Task LeaveRoom(string roomName)
        {
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, roomName);
            await Clients.Group(roomName).SendAsync(Context.User.Identity.Name + " left.");
        }

        public async Task SendHint(string roomName, int userId, WordViewModel hint)
        {
            await Clients.OthersInGroup(roomName).SendAsync("ReceiveHint", userId, hint);
        }

        public async Task SendAnswer(int userId, WordViewModel hint)
        {
            await Clients.Others.SendAsync("ReceiveAnswer", userId, hint);
        }

        public Task OnConnected()
        {
            throw new System.NotImplementedException();
        }

        public Task OnReconnected()
        {
            throw new System.NotImplementedException();
        }

        public Task OnDisconnected(bool stopCalled)
        {
            throw new System.NotImplementedException();
        }
    }
}
