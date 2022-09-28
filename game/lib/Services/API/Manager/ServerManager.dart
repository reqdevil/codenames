// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:game/Services/SharedPreference.dart';
import 'package:game/Utilities/Constants.dart';
import 'package:game/Utilities/Enums/IslemSonucu.dart';
import 'package:http/http.dart' as http;
import 'package:game/Models/User.dart';
import 'package:game/Services/API/Manager/BaseServerManager.dart';
import 'package:game/Services/API/Response/BasicResponse.dart';
import 'package:game/Services/API/Response/DataResponse.dart';
import 'package:game/Services/API/Response/ListResponse.dart';

class ServerManager<T> implements BaseServerManager {
  final url = "http://10.0.2.2:25528/api/";
  var headers = {
    "Content-Type": "application/json",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000",
  };

  Future<DataResponse<User>> signUser({
    required String path,
    required User user,
    required Function parseFunction,
  }) async {
    try {
      final uri = Uri.parse(url + path);

      final serverResponse = await http.post(
        uri,
        headers: headers,
        body: userToJson(user),
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
        user: user,
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<DataResponse<User>> loginUser({
    required String path,
    required User user,
  }) async {
    try {
      final uri = Uri.parse(url + path);

      final serverResponse = await http.post(
        uri,
        headers: headers,
        body: userToJson(user),
      );

      if (serverResponse.statusCode != 200) {
        throw Exception("Something went wrong");
      }

      final response = DataResponse<User>.fromJSON(
        serverResponse,
        (data) => userFromJson(data),
      );

      SharedPreference.saveValue("accessToken", response.accessToken!.token);

      headers.addAll({
        "Authorization": "Bearer ${response.accessToken!.token}",
      });

      return response;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<ListResponse<T>> postList({
    required String path,
    required User user,
    Map<String, dynamic>? params,
    required Function(dynamic) parseFunction,
  }) async {
    try {
      Uri uri;
      if (params != null) {
        final query = Uri(queryParameters: params).query;
        uri = Uri.parse("$url$path?$query");
      } else {
        uri = Uri.parse(url + path);
      }

      final serverResponse = await http.get(uri);

      final response = ListResponse<T>.fromJSON(
        serverResponse,
        (data) => parseFunction(data),
      );

      return response;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<DataResponse<T>> postData({
    required String path,
    required User user,
    Map<String, dynamic>? params,
    required Function(dynamic) parseFunction,
  }) async {
    try {
      Uri uri;
      if (params != null) {
        final query = Uri(queryParameters: params).toString();
        uri = Uri.parse("$url$path$query");
      } else {
        uri = Uri.parse(url + path);
      }

      final serverResponse = await http.post(
        uri,
        headers: headers,
        body: userToJson(user),
      );

      if (getIslemSonucuWithId(
              jsonDecode(serverResponse.body)["islemDurumu"]) ==
          IslemSonucu.HataNedeniyleTamamlanamadi) {
        throw Exception(
          "Error occured. Please try again later. If this error continues, please contact us.",
        );
      }

      final response = DataResponse<T>.fromJSON(
        serverResponse,
        (data) => parseFunction(data),
      );

      headers.update(
        "Authorization",
        (value) => "Bearer ${response.accessToken!.token}",
      );

      return response;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
