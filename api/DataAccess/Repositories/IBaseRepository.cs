using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;

namespace DataAccess.Repositories
{
    public interface IBaseRepository<T> where T : class
    {
        T FindById(object EntityId);

        IEnumerable<T> Select(Expression<Func<T, bool>> Filter = null);

        T Insert(T EntityToInsert);

        void Update(T EntityToUpdate);

        void Delete(object EntityId);

        void Delete(T EntityToDelete);

        IEnumerable<T> GetSql(string sql, SqlParameter[] parameters);

        int Count(Expression<Func<T, bool>> Filter = null);

        IQueryable<T> GetAll();

        IQueryable<T> GetAll(Expression<Func<T, bool>> predicate);
    }
}
