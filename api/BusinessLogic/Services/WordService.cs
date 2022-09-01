using Core.Common;
using Core.Common.Enums;
using DataAccess;
using DataAccess.Repositories;
using DataAccess.UnitOfWorks;
using Entities;
using Service.Base;
using Service.Interfaces;
using System;
using System.Linq;

namespace Service.Services
{
    public class WordService : BaseService, IWordService
    {
        private readonly CodenamesEntities _codenamesEntities;

        private readonly IBaseRepository<Words> _wordsRepository;

        public WordService(IslemSonucu _islemSonucu, CodenamesEntities codenamesEntities) : base(_islemSonucu)
        {
            _codenamesEntities = codenamesEntities;

            _wordsRepository = new BaseRepository<Words>(_codenamesEntities);
        }

        public IslemSonucu GetAllWords()
        {
            var list = _wordsRepository.GetAll();

            islemSonucu.Data = list;
            islemSonucu.IslemDurumu = IslemDurumu.BasariylaTamamlandi;
            return islemSonucu;
        }

        public IslemSonucu GetPlayWords()
        {
            Random random = new Random();

            var list =_wordsRepository.GetAll().OrderBy(_ => Guid.NewGuid()).Take(25);

            islemSonucu.Data = list;
            islemSonucu.IslemDurumu = IslemDurumu.BasariylaTamamlandi;
            return islemSonucu;
        }
    }
}
