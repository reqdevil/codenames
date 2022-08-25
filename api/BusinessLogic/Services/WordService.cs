using Core.Common;
using Core.Common.Enums;
using DataAccess.Repositories;
using DataAccess.UnitOfWorks;
using Entities;
using Service.Base;
using Service.Interfaces;

namespace Service.Services
{
    public class WordService : BaseService, IWordService
    {
        private readonly CodenamesEntities _codenamesEntities;
        private readonly IUnitOfWork _worker;

        private readonly IBaseRepository<Words> _wordsRepository;

        public WordService(IslemSonucu _islemSonucu, CodenamesEntities codenamesEntities, IUnitOfWork worker) : base(_islemSonucu)
        {
            _codenamesEntities = codenamesEntities;
            _worker = worker;

            _wordsRepository = new BaseRepository<Words>(_codenamesEntities);
        }

        public IslemSonucu GetAllWords()
        {
            var list = _wordsRepository.GetAll();

            islemSonucu.Data = list;
            islemSonucu.IslemDurumu = IslemDurumu.BasariylaTamamlandi;
            return islemSonucu;
        }
    }
}
