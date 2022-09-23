// ignore_for_file: file_names

import 'dart:convert';

import 'package:game/Models/Word.dart';
import 'package:game/Utilities/Enums/Teams.dart';

Game gameFromJson(Map<String, dynamic> json) => Game.fromJson(json);

String gameToJson(Game data) => json.encode(data.toJson());

class Game  {
  final Teams startingTeam;
  final Teams opposingTeam;
  final List<Word> wordList;

  Game({
    required this.startingTeam,
    required this.opposingTeam,
    required this.wordList,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        startingTeam: getTeamWithId(json["startingTeam"]),
        opposingTeam: getTeamWithId(json["opposingTeam"]),
        wordList: wordModelFromJson(json["wordViewModel"]),
      );

  Map<String, dynamic> toJson() => {
        "startingTeam": startingTeam,
        "opposingTeam": opposingTeam,
        "wordViewModel": List<dynamic>.from(wordList.map((x) => x.toJson())),
      };
}
