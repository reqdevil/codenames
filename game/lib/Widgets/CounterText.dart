// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:game/Helpers/AppColors.dart';

class CounterText extends StatefulWidget {
  final int count;

  const CounterText({
    Key? key,
    required this.count,
  }) : super(key: key);

  @override
  CounterTextState createState() => CounterTextState();
}

class CounterTextState extends State<CounterText> {
  late Timer _timer;
  int timerCount = 60;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "$timerCount sn. ",
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 14,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        letterSpacing: 0.18,
      ),
      textAlign: TextAlign.center,
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerCount == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            timerCount--;
          });
        }
      },
    );
  }
}
