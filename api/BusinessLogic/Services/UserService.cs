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

namespace Service.Services
{
    public class UserService : BaseService, IUserService
    {
        private readonly IUnitOfWork _worker;

        private readonly IPasswordHasher _passwordHasher;
        private readonly ITokenHelper _tokenHelper;
        private readonly ICipherService _cipherService;

        public UserService(IslemSonucu _islemSonucu, IUnitOfWork worker, ITokenHelper tokenHelper, IPasswordHasher passwordHasher, ICipherService cipherService) : base(_islemSonucu)
        {
            _worker = worker;

            _tokenHelper = tokenHelper;
            _passwordHasher = passwordHasher;
            _cipherService = cipherService;
        }

        public IslemSonucu Login(User user)
        {
            try
            {
                using DalUser dalUser = new DalUser();
                using DalPassword dalPassword = new DalPassword();
                using DalEncryption dalEncryption = new DalEncryption();

                user.Id = dalUser.GetUserIdWithUsername(user.Username);

                if (user.Id == 0)
                {
                    islemSonucu.Data = null;
                    islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
                    islemSonucu.Mesajlar.Add("Kullanıcı Adınız ile üyelik bulunamadı.");
                    return islemSonucu;
                }

                var decyrpted = _cipherService.Decrypt(dalPassword.GetPassword(user.Id), dalEncryption.GetEncryption(user.Id));

                if (user.Password == decyrpted)
                {
                    dalUser.GetUser(user.Username, ref user);
                    islemSonucu.accessToken = _tokenHelper.CreateToken(user);
                } else
                {
                    islemSonucu.Data = null;
                    islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
                    islemSonucu.Mesajlar.Add("Kullanıcı Adı ile Şifreniz eşleşmemekte.");
                    return islemSonucu;
                }
            }
            catch (Exception e)
            {
                islemSonucu.Data = null;
                islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
                islemSonucu.Mesajlar.Add(e.Message);
                return islemSonucu;
            }

            islemSonucu.Data = user;
            islemSonucu.IslemDurumu = IslemDurumu.BasariylaTamamlandi;
            return islemSonucu;
        }

        public IslemSonucu Sign(User user)
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

                using (DalUser dalUser = new DalUser())
                {
                    dalUser.SignUser(ref newUser);
                }

                EncryptionKeys encryption = new EncryptionKeys { Value = _passwordHasher.Hash(user.Password) };
                using (DalEncryption dalEncryption = new DalEncryption())
                {
                    encryption.UserId = newUser.Id;
                    dalEncryption.InsertEncryptionKey(ref encryption);
                }

                using (DalPassword dalPassword = new DalPassword())
                {
                    Passwords password = new Passwords { Value = _cipherService.Encrypt(user.Password, encryption.Value) };
                    password.UserId = newUser.Id;
                    dalPassword.InsertPassword(ref password);
                }

                _worker.Save();
            }
            catch (Exception e)
            {
                islemSonucu.Data = null;
                islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
                islemSonucu.Mesajlar.Add(e.Message);
                return islemSonucu;
            }

            islemSonucu.Data = true;
            islemSonucu.IslemDurumu = IslemDurumu.BasariylaTamamlandi;
            return islemSonucu;
        }
    }
}
