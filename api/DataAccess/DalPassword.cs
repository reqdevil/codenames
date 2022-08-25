using DataAccess.Base;
using DataAccess.UnitOfWorks;
using Entities;
using System.Linq;

namespace DataAccess
{
    public class DalPassword: DalBase
    {
        public void InsertPassword(ref Passwords passwords)
        {
            using UnitOfWork worker = new UnitOfWork();
            passwords = worker.PasswordRepository.Insert(passwords);
            worker.Save();
        }

        public string GetPassword(int userId)
        {
            using CodenamesEntities context = new CodenamesEntities();
            return (from a in context.Passwords where a.UserId == userId select a.Value).FirstOrDefault();
        }
    }
}
