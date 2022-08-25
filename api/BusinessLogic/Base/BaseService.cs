using Core.Common;
using Core.Common.Enums;
using Microsoft.Win32.SafeHandles;
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace Service.Base
{
    public class BaseService : IBaseService, IDisposable
    {
        public IslemSonucu islemSonucu;

        public BaseService(IslemSonucu _islemSonucu)
        {
            islemSonucu = _islemSonucu;
            islemSonucu.IslemDurumu = IslemDurumu.IslemeHenuzBaslanmadi;
            islemSonucu.Mesajlar = new List<string>();
        }

        #region Dispose
        bool disposed = false;
        readonly SafeHandle handle = new SafeFileHandle(IntPtr.Zero, true);

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (disposed)
                return;

            if (disposing)
            {
                handle.Dispose();
            }

            disposed = true;
        }
        #endregion
    }
}
