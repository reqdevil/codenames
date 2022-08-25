using Core.Common;
using Core.Models;
using Service.Base;

namespace Service.Interfaces
{
    public interface IUserService : IBaseService
    {
        public IslemSonucu Login(User user);

        public IslemSonucu Sign(User user);
    }
}
