using DataAccess.Base;
using DataAccess.UnitOfWorks;
using Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess
{
    public class DalWord : DalBase
    {
        public IQueryable<Words> GetPlayWords()
        {
            IQueryable<Words> list;

            using (UnitOfWork worker = new UnitOfWork())
            {
                list = worker.WordRepository.GetAll();
            }

            return list;
        }
    }
}
