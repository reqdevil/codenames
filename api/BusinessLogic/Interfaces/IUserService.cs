using Core.Common;
using Core.Models;
using Service.Base;

namespace Service.Interfaces
{
    public interface IUserService : IBaseService
    {
        IslemSonucu Login(User user);

        IslemSonucu Sign(User user);
    }
}
