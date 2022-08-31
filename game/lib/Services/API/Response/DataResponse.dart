// ignore_for_file: file_names

import 'dart:convert';

import 'package:game/Utilities/Enums/IslemSonucu.dart';
import 'package:http/http.dart';

class DataResponse<T> {
  int? statusCode;
  IslemSonucu? islemSonucu;
  List<dynamic>? mesajlar;
  T? data;

  DataResponse({
    this.data,
    this.statusCode,
    this.islemSonucu,
    this.mesajlar,
  });

  factory DataResponse.fromJSON(
    Response response,
    Function create,
  ) {
    Map<String, dynamic> json = jsonDecode(response.body);

    return DataResponse<T>(
      statusCode: response.statusCode,
      islemSonucu: getIslemSonucuWithId(json["islemDurumu"]),
      mesajlar: json["mesajlar"],
      data: create(json["data"]),
    );
  }
}
