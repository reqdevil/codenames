// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Models/Room.dart';
import 'package:game/Models/User.dart';
import 'package:game/Utilities/Enums/Teams.dart';
import 'package:game/Widgets/CustomDrawer.dart';
import 'package:game/Widgets/TeamContainer.dart';

class TeamPage extends StatefulWidget {
  final User user;
  final Room room;

  const TeamPage({
    Key? key,
    required this.room,
    required this.user,
  }) : super(key: key);

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.transparent,
      ),
      drawer: CustomDrawer(user: widget.user),
      body: Container(
        padding: const EdgeInsets.only(top: kToolbarHeight + 50),
        color: AppColors.bgColorDark,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Row(
                children: [
                  const TeamContainer(
                    team: Teams.red,
                  ),
                  Expanded(child: Container()),
                  const TeamContainer(
                    team: Teams.blue,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(50),
                child: Container(
                  color: AppColors.bgColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10),
                      Center(
                        child: Text("Spectators"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
