// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Widgets/CustomButton.dart';
import 'package:game/Widgets/CustomTextField.dart';
import 'package:game/Widgets/WidgetSlider.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscure = false;
  bool rememberMe = false;

  @override
  void dispose() {
    super.dispose();
  }

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
            const SizedBox(height: 10),
            SlideFadeTransition(
              delayStart: const Duration(milliseconds: 600),
              child: CustomTextField(
                controller: emailController,
                labelText: 'Email',
                onChanged: (value) {
                  setState(() {});
                },
                validator: (String? value) {
                  if (value == null || value == "") {
                    return "Please enter your email";
                  }

                  if (!value.contains('@') || value.endsWith('@')) {
                    return "Please check your email";
                  }

                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            SlideFadeTransition(
              delayStart: const Duration(milliseconds: 600),
              child: CustomTextField(
                controller: nameController,
                labelText: 'Name',
                onChanged: (value) {
                  setState(() {});
                },
                validator: (String? value) {
                  if (value == null || value == "") {
                    return "Please enter your name";
                  }

                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            SlideFadeTransition(
              delayStart: const Duration(milliseconds: 600),
              child: CustomTextField(
                controller: usernameController,
                labelText: 'Surname',
                onChanged: (value) {
                  setState(() {});
                },
                validator: (String? value) {
                  if (value == null || value == "") {
                    return "Please enter your surname";
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

                  if (value.length < 8) {
                    return "Password must be at least 8 characters";
                  }

                  return null;
                },
              ),
            ),
            const SizedBox(height: 30),
            SlideFadeTransition(
              delayStart: const Duration(milliseconds: 800),
              child: IgnorePointer(
                ignoring: usernameController.text == "" ||
                    emailController.text == "" ||
                    nameController.text == "" ||
                    surnameController.text == "" ||
                    passwordController.text == "",
                child: CustomButton(
                  hasState: true,
                  labelText: "Giriş Yap",
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
