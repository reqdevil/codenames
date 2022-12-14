// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/Helpers.dart';
import 'package:game/Models/Word.dart';
import 'package:game/Services/API/Manager/ServerManager.dart';
import 'package:game/Utilities/Constants.dart';
import 'package:game/Widgets/CustomButton.dart';
import 'package:game/Widgets/CustomTextField.dart';
import 'package:game/Widgets/WidgetSlider.dart';

class AnonymousPage extends StatefulWidget {
  const AnonymousPage({Key? key}) : super(key: key);

  @override
  State<AnonymousPage> createState() => _AnonymousPageState();
}

class _AnonymousPageState extends State<AnonymousPage> {
  final _service = getIt<ServerManager>();

  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 25),
            SlideFadeTransition(
              delayStart: const Duration(milliseconds: 600),
              child: CustomTextField(
                controller: usernameController,
                labelText: 'Username',
                onChanged: (value) {
                  setState(() {});
                },
                validator: (String? value) {
                  if (value == null || value == "") {
                    return "Please enter your username";
                  }

                  if (value.length < 5) {
                    return "Username must be at least 6 characters";
                  }

                  return null;
                },
              ),
            ),
            const SizedBox(height: 30),
            SlideFadeTransition(
              delayStart: const Duration(milliseconds: 800),
              child: IgnorePointer(
                ignoring: usernameController.text == "",
                child: CustomButton(
                  labelText: "Giri?? Yap",
                  onPressed: () {
                    try {
                      _service.getAllWords(
                        path: GET_ALL_WORD,
                        parseFunction: (data) => wordFromJson(data),
                      );
                    } on Exception catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
