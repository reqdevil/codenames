// ignore_for_file: file_names

import 'dart:convert';

import 'package:game/Utilities/Enums/IslemSonucu.dart';
import 'package:http/http.dart';

class ListResponse<T> {
  int? statusCode;
  IslemSonucu islemSonucu;
  List<dynamic>? mesajlar;
  List<T>? data;

  ListResponse({
    this.data,
    this.statusCode,
    required this.islemSonucu,
    this.mesajlar,
  });

  factory ListResponse.fromJSON(
    Response response,
    Function create,
  ) {
    Map<String, dynamic> json = jsonDecode(response.body);

    return ListResponse<T>(
      statusCode: response.statusCode,
      islemSonucu: getIslemSonucuWithId(json["islemDurumu"]),
      mesajlar: json["mesajlar"],
      data: create(json["data"]),
    );
  }
}
