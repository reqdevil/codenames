// ignore_for_file: file_names

import 'dart:convert';

import 'package:game/Utilities/Enums/IslemSonucu.dart';
import 'package:http/http.dart';

class BasicResponse<T> {
  int? statusCode;
  IslemSonucu? islemSonucu;
  List<dynamic>? mesajlar;
  T? data;

  BasicResponse({
    this.data,
    this.statusCode,
    this.islemSonucu,
    this.mesajlar,
  });

  factory BasicResponse.fromJSON(
    Response response,
  ) {
    Map<String, dynamic> json = jsonDecode(response.body);

    return BasicResponse<T>(
      statusCode: response.statusCode,
      islemSonucu: getIslemSonucuWithId(json["islemDurumu"]),
      mesajlar: json["mesajlar"],
      data: json["data"],
    );
  }
}
