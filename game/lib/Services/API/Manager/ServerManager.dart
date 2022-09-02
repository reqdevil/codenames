// ignore_for_file: file_names

import 'dart:convert';

import 'package:game/Models/Game.dart';
import 'package:game/Utilities/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:game/Models/User.dart';
import 'package:game/Models/Word.dart';
import 'package:game/Services/API/Manager/BaseServerManager.dart';
import 'package:game/Services/API/Response/BasicResponse.dart';
import 'package:game/Services/API/Response/DataResponse.dart';
import 'package:game/Services/API/Response/ListResponse.dart';

class ServerManager<T> implements BaseServerManager {
  final url = "http://10.0.2.2:25528/api/";
  final headers = {
    "Content-Type": "application/json",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000",
  };

  Future<DataResponse<User>> signUser({
    required String path,
    required Map<String, dynamic> params,
    required Function parseFunction,
  }) async {
    try {
      final uri = Uri.parse(url + path);

      final serverResponse = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(params),
      );

      if (serverResponse.statusCode != 200) {
        throw Exception("Something went wrong");
      }

      final response = BasicResponse.fromJSON(serverResponse);

      if (!response.data) {
        throw Exception("Something went wrong");
      }

      return loginUser(
        path: LOGIN,
        params: params,
        parseFunction: parseFunction,
      );
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<DataResponse<User>> loginUser({
    required String path,
    required Map<String, dynamic> params,
    required Function parseFunction,
  }) async {
    try {
      final uri = Uri.parse(url + path);

      final serverResponse = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(params),
      );

      if (serverResponse.statusCode != 200) {
        throw Exception("Something went wrong");
      }

      final response = DataResponse<User>.fromJSON(
        serverResponse,
        parseFunction,
      );

      return response;
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ListResponse<Word>> getWords({
    required String path,
  }) async {
    try {
      final uri = Uri.parse(url + path);

      final serverResponse = await http.get(uri);

      final response = ListResponse<Word>.fromJSON(
        serverResponse,
        (data) => wordFromJson(data),
      );

      return response;
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<DataResponse<Game>> startGame({
    required String path,
  }) async {
    try {
      final uri = Uri.parse(url + path);

      final serverResponse = await http.get(uri);

      final response = DataResponse<Game>.fromJSON(
        serverResponse,
        (data) => gameFromJson(data),
      );

      return response;
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }
}
