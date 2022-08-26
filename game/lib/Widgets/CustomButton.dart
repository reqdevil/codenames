// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';

class CustomButton extends StatefulWidget {
  final String labelText;
  final bool hasState;
  final void Function()? onPressed;

  const CustomButton({
    Key? key,
    required this.labelText,
    this.hasState = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hasState) {
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
          onPressed: widget.onPressed,
          child: Align(
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
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
