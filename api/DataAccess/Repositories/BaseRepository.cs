using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;

namespace DataAccess.Repositories
{
    public class BaseRepository<T> : IBaseRepository<T> where T : class
    {
        protected readonly CodenamesEntities _codenamesEntities;
        private DbSet<T> _dbSet;

        public BaseRepository(CodenamesEntities context)
        {
            _codenamesEntities = context;
            _dbSet = _codenamesEntities.Set<T>();
        }

        public T FindById(object EntityId)
        {
            return _dbSet.Find(EntityId);
        }

        public IEnumerable<T> Select(Expression<Func<T, bool>> Filter = null)
        {
            if (Filter != null)
            {
                return _dbSet.Where(Filter);
            }
            return _dbSet;
        }

        public T Insert(T EntityToInsert)
        {
            _dbSet.Add(EntityToInsert);
            return EntityToInsert;
        }

        public void Update(T EntityToUpdate)
        {
            _dbSet.Attach(EntityToUpdate);
            _codenamesEntities.Entry(EntityToUpdate).State = EntityState.Modified;
        }

        public void Delete(object EntityId)
        {
            T EntityToDelete = _dbSet.Find(EntityId);
            Delete(EntityToDelete);
        }

        public void Delete(T EntityToDelete)
        {
            if (_codenamesEntities.Entry(EntityToDelete).State == EntityState.Detached)
            {
                _dbSet.Attach(EntityToDelete);
                _codenamesEntities.Entry(EntityToDelete).State = EntityState.Deleted;
            }
            _dbSet.Remove(EntityToDelete);
        }

        public int Count(Expression<Func<T, bool>> Filter = null)
        {
            if (Filter != null)
            {
                return _dbSet.Count(Filter);
            }
            return _dbSet.Count();
        }

        public IQueryable<T> GetAll()
        {
            return _dbSet;
        }

        public IQueryable<T> GetAll(Expression<Func<T, bool>> predicate)
        {
            return _dbSet.Where(predicate);
        }

        public IEnumerable<T> GetSql(string sql, SqlParameter[] parameters)
        {
            return Entities.FromSqlRaw(sql, parameters).AsNoTracking();
        }

        protected virtual DbSet<T> Entities => _dbSet ??= _codenamesEntities.Set<T>();
    }
}
