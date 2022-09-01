using Core.Common;
using Core.Models;
using Service.Base;

namespace Service.Interfaces
{
    public interface IUserService : IBaseService
    {
        IslemSonucu Login(UserViewModel user);

        IslemSonucu Sign(UserViewModel user);
    }
}
