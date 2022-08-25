using Core.Models;
using DataAccess.Base;
using DataAccess.UnitOfWorks;
using Entities;
using System.Linq;

namespace DataAccess
{
    public class DalUser : DalBase
    {
        public void SignUser(ref Users user)
        {
            using UnitOfWork worker = new UnitOfWork();
            user = worker.UserRepository.Insert(user);
            worker.Save();
        }

        public int GetUserIdWithUsername(string username)
        {
            using CodenamesEntities context = new CodenamesEntities();
            return (from a in context.Users where a.Username == username select a.Id).FirstOrDefault();
        }

        public void GetUser(string username, ref User user)
        {
            using CodenamesEntities context = new CodenamesEntities();
            Users dalUser = (from a in context.Users where a.Username == username select a).FirstOrDefault();

            User du = new User
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
