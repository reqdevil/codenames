// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Models/User.dart';
import 'package:game/Utilities/Enums/Teams.dart';
import 'package:game/Widgets/CustomButton.dart';

class TeamContainer extends StatelessWidget {
  final Teams team;
  final int? wordCount;
  final bool allowJoin;
  final User? redSpy;
  final void Function()? redSpyPressed;
  final User? redAgent;
  final User? blueSpy;
  final User? blueAgent;

  const TeamContainer({
    Key? key,
    required this.team,
    this.wordCount,
    this.allowJoin = false,
    this.redSpy,
    this.redAgent,
    this.blueSpy,
    this.blueAgent,
    this.redSpyPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: team == Teams.blue ? AppColors.blueBg : AppColors.redBg,
        borderRadius: team == Teams.blue
            ? const BorderRadius.horizontal(
                left: Radius.circular(10),
              )
            : const BorderRadius.horizontal(
                right: Radius.circular(10),
              ),
      ),
      width: MediaQuery.of(context).size.width / 2.8,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 15,
          left: 10,
          right: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Spymaster:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 5),
            if (redSpy != null)
              Text(
                redSpy!.username,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.white,
                ),
              ),
            if (redSpy == null)
              CustomButton(
                labelText: "Join as spymaster",
                color: AppColors.white,
                hasState: false,
                isEnabled: allowJoin,
                onPressed: redSpyPressed,
              ),
            const Expanded(child: SizedBox.shrink()),
            const Text(
              "Agent:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 5),
            if (redAgent != null)
              Text(
                redAgent!.username,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.white,
                ),
              ),
            if (redAgent == null)
              CustomButton(
                labelText: "Join as agent",
                color: AppColors.white,
                hasState: false,
                isEnabled: allowJoin,
                onPressed: () {},
              ),
            const Expanded(child: SizedBox.shrink()),
            if (wordCount != null)
              Center(
                child: Text(
                  wordCount.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
