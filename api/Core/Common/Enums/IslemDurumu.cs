using System;
using System.Collections.Generic;
using System.Text;

namespace Core.Common.Enums
{
    public enum IslemDurumu
    {
        BasariylaTamamlandi = 1,
        KayitBulunamadi = 3,
        HataNedeniyleTamamlanamadi = 0,
        BasariylaTamamlandiUyariMesajiVar = 4,
        IslemYapmayaYetkiYok = 6,

        // Hata durumu olmayıp, kontroller sonucu reddedilen tüm işlemler için aşağıdaki yapı kullanılacaktır.
        IslemeHenuzBaslanmadi = -1,
        UyarilarNedeniyleDurduruldu = -2,
        KullaniciBilgisiAlinamadi = -4,
    }
}
