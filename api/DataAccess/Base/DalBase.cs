using System;
using System.Collections.Generic;
using System.Text;

namespace DataAccess.Base
{
    public class DalBase: IDisposable
    {
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {

                }

                disposedValue = true;
            }
        }
        public void Dispose()
        {
            Dispose(true);
        }
    }
}
