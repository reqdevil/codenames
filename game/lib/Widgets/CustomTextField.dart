// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Helpers/Helpers.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final bool isPassword;
  final bool isObscure;
  final void Function()? onPressed;
  final TextInputType? textInputType;
  final String? Function(String?) validator;
  final void Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.isPassword = false,
    this.isObscure = false,
    this.onPressed,
    this.textInputType,
    required this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  FocusNode focusNode = FocusNode();
  bool isEmpty = true;
  var fieldKey = GlobalKey<FormFieldState>();
  @override
  void initState() {
    super.initState();

    widget.controller?.addListener(() {
      if (!mounted) return;
      setState(() {
        isEmpty = widget.controller!.text.isNotEmpty ? false : true;
      });
    });

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        fieldKey.currentState!.validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
        key: fieldKey,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Theme.of(context).errorColor,
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          labelText: widget.labelText,
          hintText: widget.hintText,
          labelStyle: const TextStyle(
            color: AppColors.black,
            fontFamily: 'Roboto',
            fontSize: 17.0,
            fontWeight: FontWeight.w400,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    widget.isObscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.black,
                    size: 20,
                  ),
                  onPressed: widget.onPressed,
                )
              : null,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColors.black),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: AppColors.black),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
        style: const TextStyle(
          color: AppColors.black,
          fontFamily: 'Roboto',
          fontSize: 20.0,
          fontWeight: FontWeight.w400,
        ),
        minLines: 1,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        validator: widget.validator,
        obscureText: widget.isObscure,
        onEditingComplete: () {
          BasicHelpers().dissmissKeyboard(context);
          fieldKey.currentState!.validate();
        },
        onChanged: widget.onChanged,
      ),
    );
  }
}
