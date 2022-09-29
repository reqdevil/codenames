using Core.Models;
using Entities;
using Microsoft.AspNet.SignalR.Hubs;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace API.Hubs
{
    public class GameHub: Hub
    {
        public async Task JoinRoom(Users user, string roomName)
        { 
            await Groups.AddToGroupAsync(Context.ConnectionId, roomName);
            await Clients.OthersInGroup(roomName).SendAsync("UserJoined", user);
        }

        public async Task LeaveRoom(Users user, string roomName)
        {
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, roomName);
            await Clients.OthersInGroup(roomName).SendAsync("UserLeft", user);
        }

        public async Task UpdatePlayer(List<Users> userList, string roomName)
        {
            await Clients.OthersInGroup(roomName).SendAsync("PlayerUpdate", userList);
        }

        public async Task StartTeamChoose(List<Users> userList, string roomName)
        {
            await Clients.Group(roomName).SendAsync("StartTeamChoose", userList, true);
        }

        public async Task SendHint(string roomName, int userId, WordViewModel hint)
        {
            await Clients.OthersInGroup(roomName).SendAsync("ReceiveHint", userId, hint);
        }

        public async Task SendAnswer(int userId, WordViewModel hint)
        {
            await Clients.Others.SendAsync("ReceiveAnswer", userId, hint);
        }
    }
}
