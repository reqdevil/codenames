// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Utilities/Constants.dart';

class ToastCircularProgressIndicator extends StatefulWidget {
  final Duration duration;
  AnimationController? animationController;

  ToastCircularProgressIndicator({
    Key? key,
    required this.duration,
    this.animationController,
  }) : super(key: key);

  @override
  ToastCircularProgressIndicatorState createState() =>
      ToastCircularProgressIndicatorState();
}

class ToastCircularProgressIndicatorState
    extends State<ToastCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: widget.duration);
    widget.animationController = controller;

    controller.addListener(() {
      if (controller.value == 1.0) {
        dismissAllToast(showAnim: true);

        if (!visible.value) {
          visible.value = true;
        }
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.removeListener(() {});
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Transform(
        transform: Matrix4.diagonal3Values(-1.0, 1.0, 1.0),
        alignment: Alignment.center,
        child: SizedBox(
          height: 25,
          width: 25,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                strokeWidth: 2,
                value: controller.value,
                color: AppColors.white,
                backgroundColor: Colors.white24,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  dismissAllToast(showAnim: true);

                  if (!visible.value) {
                    visible.value = true;
                  }
                },
                style: ElevatedButton.styleFrom(
                  maximumSize: const Size(20, 20),
                  fixedSize: const Size(25, 25),
                  elevation: 0,
                  minimumSize: const Size(20, 20),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(0),
                  primary: Colors.white.withOpacity(0.3),
                  onPrimary: AppColors.splashGrey,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
