// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';

class LogoCircularProgressIndicator extends StatefulWidget {
  const LogoCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  State<LogoCircularProgressIndicator> createState() =>
      _LogoCircularProgressIndicatorState();
}

class _LogoCircularProgressIndicatorState
    extends State<LogoCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      // upperBound: 1.0,
      // lowerBound: 0.0,
      vsync: this,
      reverseDuration: const Duration(milliseconds: 350),
    )..forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        ignoring: true,
        child: Center(
          child: AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {
              double size = animationController.value * 200;
              return SizedBox(
                height: size,
                width: size,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const ClipOval(
                      child: CircleAvatar(
                        backgroundColor: AppColors.grey,
                        radius: 45,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          child: Image(
                            image: AssetImage('lib/assets/logo.png'),
                            height: 300,
                            width: 300,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(0),
                      height: 100,
                      width: 100,
                      child: const CircularProgressIndicator(
                        backgroundColor: AppColors.bgColorDark,
                        strokeWidth: 4,
                        color: AppColors.mainColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
