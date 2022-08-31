import 'package:flutter/material.dart';
import 'package:game/Helpers/Helpers.dart';
import 'package:game/Pages/Login/LoginTab.dart';

void main() {
  BasicHelpers().setupGetIt();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginTab(),
    );
  }
}
