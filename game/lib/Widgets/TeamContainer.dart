// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Utilities/Enums/Teams.dart';

class TeamContainer extends StatelessWidget {
  final Teams team;

  const TeamContainer({
    Key? key,
    required this.team,
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
      width: MediaQuery.of(context).size.width / 3,
    );
  }
}
