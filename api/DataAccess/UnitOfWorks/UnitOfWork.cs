using DataAccess.Repositories;
using Entities;
using System;
using System.Transactions;

namespace DataAccess.UnitOfWorks
{
    public sealed class UnitOfWork : IUnitOfWork
    {
        private CodenamesEntities _codenamesEntities;

        #region Repositories
        private BaseRepository<Users> _userRepository;
        private BaseRepository<Rooms> _roomRepository;
        private BaseRepository<Passwords> _passwordRepository;
        private BaseRepository<EncryptionKeys> _encryptionKeyRepository;
        private BaseRepository<RoomWords> _roomWordRepository;
        private BaseRepository<UserRooms> _userRoomRepository;
        private BaseRepository<Words> _wordRepository;

        public BaseRepository<Users> UserRepository
        {
            get
            {
                if (_userRepository == null)
                {
                    _userRepository = new BaseRepository<Users>(_codenamesEntities);
                }

                return _userRepository;
            }
        }

        public BaseRepository<Rooms> RoomRepository
        {
            get
            {
                if (_roomRepository == null)
                {
                    _roomRepository = new BaseRepository<Rooms>(_codenamesEntities);
                }

                return _roomRepository;
            }
        }

        public BaseRepository<Passwords> PasswordRepository
        {
            get
            {
                if (_passwordRepository == null)
                {
                    _passwordRepository = new BaseRepository<Passwords>(_codenamesEntities);
                }

                return _passwordRepository;
            }
        }

        public BaseRepository<EncryptionKeys> EncryptionKeyRepository
        {
            get
            {
                if (_encryptionKeyRepository == null)
                {
                    _encryptionKeyRepository = new BaseRepository<EncryptionKeys>(_codenamesEntities);
                }

                return _encryptionKeyRepository;
            }
        }

        public BaseRepository<RoomWords> RoomWordRepository
        {
            get
            {
                if (_roomWordRepository == null)
                {
                    _roomWordRepository = new BaseRepository<RoomWords>(_codenamesEntities);
                }

                return _roomWordRepository;
            }
        }

        public BaseRepository<UserRooms> UserRoomRepository
        {
            get
            {
                if (_userRoomRepository == null)
                {
                    _userRoomRepository = new BaseRepository<UserRooms>(_codenamesEntities);
                }

                return _userRoomRepository;
            }
        }

        public BaseRepository<Words> WordRepository
        {
            get
            {
                if (_wordRepository == null)
                {
                    _wordRepository = new BaseRepository<Words>(_codenamesEntities);
                }

                return _wordRepository;
            }
        }
        #endregion

        public UnitOfWork()
        {
            _codenamesEntities = new CodenamesEntities();
        }

        public UnitOfWork(CodenamesEntities codenamesEntities)
        {
            _codenamesEntities = codenamesEntities;
        }

        public IBaseRepository<T> GetRepository<T>() where T : class
        {
            return new BaseRepository<T>(_codenamesEntities);
        }

        public void Save()
        {
            using TransactionScope scope = new TransactionScope(TransactionScopeOption.Suppress, new System.TimeSpan(0, 1, 0));
            _codenamesEntities.SaveChanges();
            scope.Complete();
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        private void Dispose(bool disposing)
        {
            if (disposing)
            {
                if (_codenamesEntities != null)
                {
                    _codenamesEntities.Dispose();
                    _codenamesEntities = null;
                }
            }
        }
    }
}
