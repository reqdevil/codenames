// ignore_for_file: file_names, constant_identifier_names

enum IslemSonucu {
  IslemeHenuzBaslanmadi, // -1
  UyarilarNedeniyleDurduruldu, // -2
  SessionViolation, // -3
  KullaniciBilgisiAlinamadi, // -4
  HataNedeniyleTamamlanamadi, // 0
  BasariylaTamamlandi, // 1
  SorgulamaIslemiBasariylaTamamlandi, // 2
  KayitBulunamadi, // 3
  BasariylaTamamlandiUyariMesajiVar, // 4
  EklenecekDataMevcutIslemTamamlanamadi, // 5
  IslemYapmayaYetkiYok, // 6
}

IslemSonucu getIslemSonucuWithId(int id) {
  switch (id) {
    case -1:
      return IslemSonucu.IslemeHenuzBaslanmadi;
    case -2:
      return IslemSonucu.UyarilarNedeniyleDurduruldu;
    case -3:
      return IslemSonucu.SessionViolation;
    case -4:
      return IslemSonucu.KullaniciBilgisiAlinamadi;
    case 1:
      return IslemSonucu.BasariylaTamamlandi;
    case 2:
      return IslemSonucu.SorgulamaIslemiBasariylaTamamlandi;
    case 3:
      return IslemSonucu.KayitBulunamadi;
    case 4:
      return IslemSonucu.BasariylaTamamlandiUyariMesajiVar;
    case 5:
      return IslemSonucu.EklenecekDataMevcutIslemTamamlanamadi;
    case 6:
      return IslemSonucu.IslemYapmayaYetkiYok;
    default: // case 0
      return IslemSonucu.HataNedeniyleTamamlanamadi;
  }
}

int getIdWithIslemSonucu(IslemSonucu islemSonucu) {
  switch (islemSonucu) {
    case IslemSonucu.IslemeHenuzBaslanmadi:
      return -1;
    case IslemSonucu.UyarilarNedeniyleDurduruldu:
      return -2;
    case IslemSonucu.SessionViolation:
      return -3;
    case IslemSonucu.KullaniciBilgisiAlinamadi:
      return -4;
    case IslemSonucu.BasariylaTamamlandi:
      return 1;
    case IslemSonucu.SorgulamaIslemiBasariylaTamamlandi:
      return 2;
    case IslemSonucu.KayitBulunamadi:
      return 3;
    case IslemSonucu.BasariylaTamamlandiUyariMesajiVar:
      return 4;
    case IslemSonucu.EklenecekDataMevcutIslemTamamlanamadi:
      return 5;
    case IslemSonucu.IslemYapmayaYetkiYok:
      return 6;
    default: // case IslemSonucu.HataNedeniyleTamamlanamadi
      return 0;
  }
}
