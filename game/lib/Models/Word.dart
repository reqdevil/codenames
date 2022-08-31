// ignore_for_file: file_names

import 'dart:convert';

List<Word> wordFromJson(List<dynamic> json) =>
    List<Word>.from(json.map((x) => Word.fromJson(x)));

String wordToJson(List<Word> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Word {
  Word({
    required this.id,
    required this.value,
    this.roomWords,
  });

  final int id;
  final String value;
  final dynamic roomWords;

  factory Word.fromJson(Map<String, dynamic> json) => Word(
        id: json["id"],
        value: json["value"],
        roomWords: json["roomWords"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "roomWords": roomWords,
      };
}
