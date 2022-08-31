// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Helpers/Helpers.dart';
import 'package:game/Utilities/Enums/ButtonState.dart';

class CustomButton extends StatefulWidget {
  final String labelText;
  final void Function()? onPressed;

  const CustomButton({
    Key? key,
    required this.labelText,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  ButtonState state = ButtonState.init;
  bool isWorking = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: RawMaterialButton(
        elevation: 0,
        highlightElevation: 0,
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () async {
          setState(() {
            state = ButtonState.submitting;
          });

          await process();

          if (!mounted) return;
          await Future.delayed(const Duration(seconds: 1));
          if (mounted) {
            setState(() {
              state = ButtonState.completed;

              if (state == ButtonState.completed) {
                isWorking = false;
              }

              state = ButtonState.init;
            });
          }
        },
        child: !isWorking
            ? Align(
                alignment: Alignment.center,
                child: Text(
                  widget.labelText,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 17,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Processing...",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 17,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    height: 20,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: AppColors.black,
                        strokeWidth: 2.5,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<bool> process() async {
    bool hasSuccess = false;
    try {
      BasicHelpers().dissmissKeyboard(context);

      if (state == ButtonState.submitting) {
        widget.onPressed!.call();
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          setState(() {
            isWorking = true;
          });
        }
      }

      hasSuccess = true;
    } on Exception {
      hasSuccess = false;
    }

    return hasSuccess;
  }
}
