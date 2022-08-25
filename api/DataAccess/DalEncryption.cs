using DataAccess.Base;
using DataAccess.UnitOfWorks;
using Entities;
using System.Linq;

namespace DataAccess
{
    public class DalEncryption: DalBase
    {
        public void InsertEncryptionKey(ref EncryptionKeys encryptionKeys)
        {
            using UnitOfWork worker = new UnitOfWork();
            encryptionKeys = worker.EncryptionKeyRepository.Insert(encryptionKeys);
            worker.Save();
        }

        public string GetEncryption(int userId)
        {
            using CodenamesEntities context = new CodenamesEntities();
            return (from a in context.EncryptionKeys where a.UserId == userId select a.Value).FirstOrDefault();
        }
    }
}
