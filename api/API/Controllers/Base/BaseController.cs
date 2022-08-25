using Core.Common;
using Core.Common.Enums;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace API.Controllers.Base
{
    public class BaseController: ControllerBase
    {
        public IslemSonucu islemSonucu = new IslemSonucu() { IslemDurumu = IslemDurumu.IslemeHenuzBaslanmadi, Mesajlar = new List<string>() };

        [ApiExplorerSettings(IgnoreApi = true)]
        public bool IsModelValid(object model)
        {
            if (!ModelState.IsValid)
            {
                foreach (var item in ModelState.Values)
                {
                    foreach (var err in item.Errors)
                    {
                        islemSonucu.Mesajlar.Add(string.Format("{0} - {1}", err.ErrorMessage, err.Exception != null ? err.Exception.ToString() : ""));
                    }
                }
                islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
                return false;
            }

            return true;
        }

        [ApiExplorerSettings(IgnoreApi = true)]
        public IslemSonucu ValidateModel(object model)
        {
            if (!ModelState.IsValid)
            {
                foreach (var item in ModelState.Values)
                {
                    foreach (var err in item.Errors)
                    {
                        islemSonucu.Mesajlar.Add(err.ErrorMessage);
                    }
                }

                return islemSonucu;
            }

            return null;
        }
    }
}
