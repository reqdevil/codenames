using Core.Common;
using Core.Common.Enums;
using Core.Models;
using Entities;
using Service.Base;
using Service.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Service.Services
{
    public class GameService : BaseService, IGameService
    {
        private readonly IWordService _wordService;

        public GameService(IslemSonucu islemSonucu, IWordService wordService) : base(islemSonucu)
        {
            _wordService = wordService;
        }

        public IslemSonucu StartGame()
        {
            GameViewModel model = new GameViewModel();
            Random random = new Random();
            int randomNumber = random.Next(0, 2);
            List<int> indexes = new List<int>();

            // Decide Starting Team
            model.StartingTeam = randomNumber % 2 == 0 ? Team.Red : Team.Blue;
            model.OpposingTeam = randomNumber % 2 == 0 ? Team.Blue : Team.Red;

            // Get 25 Word and Configure Map
            islemSonucu = _wordService.GetPlayWords();
            var list = ((IQueryable<Words>)islemSonucu.Data).Select(w => new WordViewModel
            {
                Vocable = w.Value
            }).ToList();

            #region Deciding Word Team
            // Decide Assassin
            randomNumber = random.Next(0, 25);
            list[randomNumber].Team = Team.Black;
            indexes.Add(randomNumber);

            // Decide Starting Team
            for (int i = 0; i < 9; i++)
            {
                randomNumber = random.Next(0, 25);
                if (indexes.Contains(randomNumber))
                {
                    do
                    {
                        randomNumber = random.Next(0, 25);
                    } while (indexes.Contains(randomNumber));
                }

                list[randomNumber].Team = model.StartingTeam;
                indexes.Add(randomNumber);
            }

            // Decide Opposing Team
            for (int i = 0; i < 8; i++)
            {
                randomNumber = random.Next(0, 25);
                if (indexes.Contains(randomNumber))
                {
                    do
                    {
                        randomNumber = random.Next(0, 25);
                    } while (indexes.Contains(randomNumber));
                }

                list[randomNumber].Team = model.OpposingTeam;
                indexes.Add(randomNumber);
            }
            #endregion

            model.WordViewModel = list;
            islemSonucu.Data = model;
            islemSonucu.IslemDurumu = IslemDurumu.BasariylaTamamlandi;
            return islemSonucu;
        }
    }
}
