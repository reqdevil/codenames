// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Helpers/Helpers.dart';
import 'package:game/Models/User.dart';
import 'package:game/Services/API/Manager/ServerManager.dart';
import 'package:game/Services/ToastService.dart';
import 'package:game/Utilities/Constants.dart';
import 'package:game/Widgets/CustomButton.dart';
import 'package:game/Widgets/CustomTextField.dart';
import 'package:game/Widgets/WidgetSlider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _service = getIt<ServerManager>();

  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  bool isObscure = true;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
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
              const SizedBox(height: 10),
              SlideFadeTransition(
                delayStart: const Duration(milliseconds: 700),
                child: CustomTextField(
                  controller: passwordController,
                  labelText: "Password",
                  textInputType: TextInputType.emailAddress,
                  isPassword: true,
                  isObscure: isObscure,
                  onChanged: (value) {
                    setState(() {});
                  },
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value == "") {
                      return "Please enter your password";
                    }

                    return null;
                  },
                ),
              ),
              SlideFadeTransition(
                delayStart: const Duration(milliseconds: 800),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Remember Me",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                      ),
                    ),
                    Checkbox(
                      value: rememberMe,
                      checkColor: AppColors.mainColor,
                      activeColor: AppColors.black,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SlideFadeTransition(
                delayStart: const Duration(milliseconds: 900),
                child: IgnorePointer(
                  ignoring: usernameController.text == "" ||
                      passwordController.text == "",
                  child: CustomButton(
                    labelText: "Login",
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      User user = User(
                        username: usernameController.text,
                        password: passwordController.text,
                        id: 0,
                        email: 'string',
                        name: 'string',
                        surname: 'string',
                      );

                      try {
                        final response = await _service.loginUser(
                          path: LOGIN,
                          params: user.toJson(),
                        );

                        user = response.data!;
                        user.printUser();

                        // TODO: Navigate Play Page
                      } on Exception catch (e) {
                        ToastService.errorToast(
                          context,
                          "Error Occured",
                          e.toString(),
                          Alignment.bottomCenter,
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
