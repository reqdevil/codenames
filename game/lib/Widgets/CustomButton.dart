// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Helpers/Helpers.dart';
import 'package:game/Utilities/Enums/ButtonState.dart';

class CustomButton extends StatefulWidget {
  final String labelText;
  final void Function()? onPressed;
  final Color color;
  final bool hasState;
  final bool isEnabled;

  const CustomButton({
    Key? key,
    required this.labelText,
    required this.onPressed,
    this.color = AppColors.black,
    this.hasState = true,
    this.isEnabled = true,
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
        border: Border.all(color: widget.color),
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
        onPressed: widget.isEnabled
            ? widget.hasState
                ? () async {
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
                  }
                : widget.onPressed
            : null,
        child: !isWorking
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.labelText,
                    style: TextStyle(
                      color: widget.color,
                      fontSize: 17,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Processing...",
                      style: TextStyle(
                        color: widget.color,
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      height: 20,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.transparent,
                          color: widget.color,
                          strokeWidth: 2.5,
                        ),
                      ),
                    ),
                  ],
                ),
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
