import 'package:flutter/material.dart';
import 'package:game/Helpers/Helpers.dart';
import 'package:game/Pages/Login/LoginTab.dart';
import 'package:game/Services/Provider/HubConnection.dart';
import 'package:provider/provider.dart';

void main() {
  BasicHelpers().setupGetIt();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HubConnectionProvider>(
          create: (_) => HubConnectionProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
