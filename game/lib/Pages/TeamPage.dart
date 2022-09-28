// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Models/Room.dart';
import 'package:game/Models/User.dart';
import 'package:game/Services/Provider/HubConnection.dart';
import 'package:game/Utilities/Enums/Teams.dart';
import 'package:game/Widgets/CustomDrawer.dart';
import 'package:game/Widgets/TeamContainer.dart';
import 'package:provider/provider.dart';
import 'package:signalr_netcore/hub_connection.dart';

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
  late HubConnection hubConnection;

  List<User>? userList;

  @override
  void initState() {
    super.initState();

    hubConnection = Provider.of<HubConnectionProvider>(context).hubConnection!;

    joinRoom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "${widget.room.id} - ${widget.room.roomName}",
          ),
        ),
      ),
      drawer: CustomDrawer(user: widget.user),
      body: Container(
        padding: const EdgeInsets.only(top: kToolbarHeight + 50),
        color: AppColors.bgColorDark,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: AppColors.bgColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          "Spectator(s)",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.user.username,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.user.username,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.user.username,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.user.username,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "You need to have 4 people in order to choose team!!!",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
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

  void joinRoom() {
    hubConnection.invoke("JoinRoom", args: [widget.room.roomName]);

    hubConnection.on("UserJoined", userJoin);
    hubConnection.on("TeamJoined", teamJoin);
  }

  void userJoin(List<Object>? args) {
    if (args != null) {
      print(args);
    }
  }

  void teamJoin(List<Object>? args) {
    if (args != null) {
      print(args);
    }
  }
}
