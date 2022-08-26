using Core.Common.Enums;
using Core.Utilities.Security.JWT;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Core.Common
{
    public class IslemSonucu
    {
        private List<string> _mesajlar;
        private IslemDurumu _islemDurumu;
        private readonly Func<IslemDurumu, ActionResult> _resultNotifier;
        public object Data { get; set; }
        public AccessToken accessToken { get; set; }

        public IslemSonucu()
        {
            Initialize();
        }

        private void Initialize()
        {
            if (this._mesajlar == null)
            {
                this._mesajlar = new List<string>();
            }

            Mesajlar = this._mesajlar;
        }

        public IslemSonucu(Func<IslemDurumu, ActionResult> resultNotifier)
        {
            _resultNotifier = resultNotifier;
            Initialize();
        }

        public IslemDurumu IslemDurumu
        {
            get
            {
                return _islemDurumu;
            }

            set
            {
                _resultNotifier?.Invoke(_islemDurumu);

                _islemDurumu = value;
            }
        }

        public List<string> Mesajlar
        {
            get
            {
                if (this._mesajlar == null)
                {
                    this._mesajlar = new List<string>();
                }

                return _mesajlar;
            }

            set
            {
                _mesajlar = value;
            }
        }

        public override string ToString()
        {
            return JsonConvert.SerializeObject(this);
        }
    }
}
