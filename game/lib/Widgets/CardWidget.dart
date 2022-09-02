// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';

class CardWidget extends StatefulWidget {
  final String text;
  final double visible;
  Function()? onDoubleTap;

  CardWidget({
    Key? key,
    required this.text,
    required this.visible,
    required this.onDoubleTap,
  }) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: widget.onDoubleTap,
      child: AnimatedOpacity(
        opacity: widget.visible,
        duration: const Duration(milliseconds: 250),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: AppColors.cardBg,
          ),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: AppColors.cardLine,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 1,
                              margin: const EdgeInsets.only(
                                left: 5,
                              ),
                              color: AppColors.cardLine,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 0.8,
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 5,
                                top: 5,
                                right: 5,
                              ),
                              color: AppColors.cardLine,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 1),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: const EdgeInsets.only(
                        left: 5,
                        right: 5,
                        bottom: 5,
                      ),
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(5)),
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            widget.text,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
