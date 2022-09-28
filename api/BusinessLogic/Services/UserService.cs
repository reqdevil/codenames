using Core.Common;
using Core.Common.Enums;
using Core.Models;
using Core.Utilities.Security.Encryption;
using Core.Utilities.Security.Encryption.Cipher;
using Core.Utilities.Security.JWT;
using DataAccess;
using DataAccess.Repositories;
using DataAccess.UnitOfWorks;
using Entities;
using Service.Base;
using Service.Interfaces;
using System;
using System.Linq;

namespace Service.Services
{
    public class UserService : BaseService, IUserService
    {
        private readonly IUnitOfWork _worker;

        private readonly IPasswordHasher _passwordHasher;
        private readonly ITokenHelper _tokenHelper;
        private readonly ICipherService _cipherService;

        private readonly IBaseRepository<Users> _userRepository;
        private readonly IBaseRepository<Passwords> _passwordRepository;
        private readonly IBaseRepository<EncryptionKeys> _keyRepository;

        public UserService(IslemSonucu _islemSonucu, IUnitOfWork worker, ITokenHelper tokenHelper, IPasswordHasher passwordHasher, ICipherService cipherService, IBaseRepository<Users> userRepository, IBaseRepository<Passwords> passwordRepository, IBaseRepository<EncryptionKeys> keyRepository) : base(_islemSonucu)
        {
            _worker = worker;

            _tokenHelper = tokenHelper;
            _passwordHasher = passwordHasher;
            _cipherService = cipherService;

            _userRepository = userRepository;
            _passwordRepository = passwordRepository;
            _keyRepository = keyRepository;
        }

        public IslemSonucu Login(UserViewModel user)
        {
            try
            {
                user.Id = _userRepository.Select(u => u.Username == user.Username).FirstOrDefault().Id;

                if (user.Id == 0)
                {
                    islemSonucu.Data = null;
                    islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
                    islemSonucu.Mesajlar.Add("Kullanıcı Adınız ile üyelik bulunamadı.");
                    return islemSonucu;
                }

                var pwd = _passwordRepository.Select(p => p.UserId == user.Id).FirstOrDefault().Value;
                var key = _keyRepository.Select(k => k.UserId == user.Id).FirstOrDefault().Value;
                var decyrpted = _cipherService.Decrypt(pwd, key);

                if (user.Password == decyrpted)
                {
                    Users u = _userRepository.Select(u => u.Username == user.Username).FirstOrDefault();
                    user = new UserViewModel
                    {
                        Username = u.Username,
                        Id = u.Id,
                        Email = u.Email,
                        Name = u.Name,
                        Surname = u.Surname,
                        Password = pwd,
                    };
                    islemSonucu.AccessToken = _tokenHelper.CreateToken(user);
                } else
                {
                    islemSonucu.Data = null;
                    islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
                    islemSonucu.Mesajlar.Add("Kullanıcı Adı ile Şifreniz eşleşmemekte.");
                    return islemSonucu;
                }

                islemSonucu.Data = user;
                islemSonucu.IslemDurumu = IslemDurumu.BasariylaTamamlandi;
                return islemSonucu;
            }
            catch (Exception e)
            {
                islemSonucu.Data = null;
                islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
                islemSonucu.Mesajlar.Add(e.Message);
                return islemSonucu;
            }
        }

        public IslemSonucu Sign(UserViewModel user)
        {
            try
            {
                var newUser = new Users
                {
                    Username = user.Username,
                    Name = user.Name,
                    Surname = user.Surname,
                    Email = user.Email,
                };

                newUser = _userRepository.Insert(newUser);
                _worker.Save();

                EncryptionKeys encryption = new EncryptionKeys { Value = _passwordHasher.Hash(user.Password) };
                encryption.UserId = newUser.Id;
                encryption = _keyRepository.Insert(encryption);

                Passwords password = new Passwords { Value = _cipherService.Encrypt(user.Password, encryption.Value) };
                password.UserId = newUser.Id;
                _passwordRepository.Insert(password);

                _worker.Save();

                islemSonucu.Data = true;
                islemSonucu.IslemDurumu = IslemDurumu.BasariylaTamamlandi;
                return islemSonucu;
            }
            catch (Exception e)
            {
                islemSonucu.Data = null;
                islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
                islemSonucu.Mesajlar.Add(e.Message);
                return islemSonucu;
            }
        }
    }
}
