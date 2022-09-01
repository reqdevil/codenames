using Core.Models;
using DataAccess.Base;
using DataAccess.UnitOfWorks;
using Entities;
using System;
using System.Linq;

namespace DataAccess
{
    public class DalUser : DalBase
    {
        public void SignUser(ref Users user)
        {
            try
            {
                using UnitOfWork worker = new UnitOfWork();
                user = worker.UserRepository.Insert(user);
                worker.Save();
            }
            catch (Exception e)
            {
                if (e.InnerException.Message.Contains("IX_Users_Email"))
                {
                    throw new Exception("This email address is registered in our system");
                }

                if (e.InnerException.Message.Contains("IX_Users_Username"))
                {
                    throw new Exception("This username is taken");
                }

                throw e;
            }
        }

        public int GetUserIdWithUsername(string username)
        {
            using CodenamesEntities context = new CodenamesEntities();
            return (from a in context.Users where a.Username == username select a.Id).FirstOrDefault();
        }

        public void GetUser(string username, ref UserViewModel user)
        {
            using CodenamesEntities context = new CodenamesEntities();
            Users dalUser = (from a in context.Users where a.Username == username select a).FirstOrDefault();

            UserViewModel du = new UserViewModel
            {
                Id = dalUser.Id,
                Email = dalUser.Email,
                Username = dalUser.Username,
                Name = dalUser.Name,
                Surname = dalUser.Surname
            };

            user = du;
        }
    }
}
