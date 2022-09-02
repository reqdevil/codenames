// ignore_for_file: file_names

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game/Utilities/Enums/Teams.dart';

List<Word> wordFromJson(Map<String, dynamic> json) =>
    List<Word>.from(json["wordViewModel"].map((x) => Word.fromJson(x)));

List<Word> wordModelFromJson(List<dynamic> json) =>
    List<Word>.from(json.map((x) => Word.fromJson(x)));

String wordToJson(List<Word> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Word {
  Word({
    required this.team,
    required this.vocable,
    this.isOpened = false,
    this.image,
  });

  final Teams team;
  final String vocable;
  bool isOpened;
  ImageProvider<Object>? image;

  factory Word.fromJson(Map<String, dynamic> json) => Word(
      team: getTeamWithId(json["team"]),
      vocable: json["vocable"],
      image: getImage(getTeamWithId(json["team"])));

  Map<String, dynamic> toJson() => {
        "id": team,
        "value": vocable,
      };

  static ImageProvider<Object> getImage(Teams team) {
    Random random = Random();
    int randomNumber = random.nextInt(2) + 1;

    if (team == Teams.blue) {
      return AssetImage("lib/assets/cards/b$randomNumber.png");
    } else if (team == Teams.red) {
      return AssetImage("lib/assets/cards/r$randomNumber.png");
    } else if (team == Teams.black) {
      return const AssetImage("lib/assets/cards/assassin.png");
    }

    return AssetImage("lib/assets/cards/w$randomNumber.png");
  }
}
