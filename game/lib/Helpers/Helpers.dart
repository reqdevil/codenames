// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Services/API/Manager/ServerManager.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class BasicHelpers {
  void dissmissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void setupGetIt() {
    getIt.registerLazySingleton(() => ServerManager());
    // getIt.registerLazySingleton(() => HiveService());
  }
}
