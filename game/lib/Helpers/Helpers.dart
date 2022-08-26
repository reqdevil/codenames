// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BasicHelpers {
  void dissmissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
