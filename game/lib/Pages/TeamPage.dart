// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Helpers/Helpers.dart';
import 'package:game/Models/Room.dart';
import 'package:game/Models/User.dart';
import 'package:game/Services/API/Manager/ServerManager.dart';
import 'package:game/Services/Provider/HubConnection.dart';
import 'package:game/Services/ToastService.dart';
import 'package:game/Utilities/Constants.dart';
import 'package:game/Utilities/Enums/Teams.dart';
import 'package:game/Widgets/CustomButton.dart';
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
  final service = getIt<ServerManager>();
  late HubConnection hubConnection;

  List<User> userList = [];
  bool allowJoin = false;
  bool? isRoomAdmin;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userList.add(widget.user);

    hubConnection = Provider.of<HubConnectionProvider>(context).hubConnection!;

    if (hubConnection.state != HubConnectionState.Connected) {
      hubConnection.start();
    }

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
        actions: [
          GestureDetector(
            child: const Icon(Icons.arrow_back),
            onTap: () {
              hubConnection.invoke(
                "LeaveRoom",
                args: [
                  widget.user,
                  widget.room.roomName,
                ],
              );

              Navigator.pop(context);
            },
          )
        ],
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
                  TeamContainer(
                    team: Teams.red,
                    allowJoin: allowJoin,
                    redSpyPressed: () {
                      print("object");
                    },
                  ),
                  Expanded(child: Container()),
                  TeamContainer(
                    team: Teams.blue,
                    allowJoin: allowJoin,
                  )
                ],
              ),
            ),
            if (hubConnection.state == HubConnectionState.Connected)
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
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: userList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Text(
                                    userList[index].username,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                ],
                              );
                            },
                          ),
                        ),
                        if (userList.length != 4)
                          const Text(
                            "You need to have 4 people in order to choose team!!!",
                            textAlign: TextAlign.center,
                          ),
                        if (userList.length != 4) const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            if (hubConnection.state != HubConnectionState.Connected)
              Container(
                margin: const EdgeInsets.all(50),
                child: Container(
                  padding: const EdgeInsets.all(50),
                  color: AppColors.bgColor,
                  child: CustomButton(
                    labelText: "Connect Server",
                    onPressed: () {
                      setState(() {
                        hubConnection.start();
                        joinRoom();
                      });
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void joinRoom() async {
    if (isRoomAdmin == null) {
      try {
        final response = await service.postData(
          path: FIND_ROOM_ADMIN,
          user: widget.user,
          params: {
            "roomId": widget.room.id.toString(),
          },
          parseFunction: (data) => userFromJson(data),
        );

        if ((response.data as User).id == widget.user.id) {
          isRoomAdmin = true;
        } else {
          isRoomAdmin = false;
        }
      } on Exception catch (e) {
        ToastService.errorToast(
          context,
          "Error Occured",
          e.toString(),
          Alignment.bottomCenter,
        );
      }
    }

    hubConnection.invoke(
      "JoinRoom",
      args: [
        widget.user,
        widget.room.roomName,
      ],
    );

    hubConnection.on("UserJoined", userJoin);
    hubConnection.on("UserLeft", userLeft);
    hubConnection.on("PlayerUpdate", playerUpdate);
    hubConnection.on("StartTeamChoose", startTeamChoose);
  }

  void userJoin(List<Object>? args) {
    if (args != null && isRoomAdmin != null && isRoomAdmin!) {
      User user = User.fromJson(args[0] as Map<String, dynamic>);

      if (user.username != widget.user.username) {
        bool contains = false;
        for (var u in userList) {
          if (u.id == user.id) {
            contains = true;
          }
        }
        if (!contains) {
          userList.add(user);
        }

        if (userList.length == 4) {
          Future.delayed(const Duration(milliseconds: 500), () {
            hubConnection.invoke(
              "StartTeamChoose",
              args: [
                userList,
                widget.room.roomName,
              ],
            );
          });
        }

        setState(() {});
      }

      hubConnection.invoke(
        "UpdatePlayer",
        args: [
          userList,
          widget.room.roomName,
        ],
      );
    }
  }

  void userLeft(List<Object>? args) {
    if (args != null && isRoomAdmin != null && isRoomAdmin!) {
      User user = User.fromJson(args[0] as Map<String, dynamic>);

      if (user.username != widget.user.username) {
        for (int i = 0; i < userList.length; i++) {
          if (userList[i].id == user.id) {
            userList.removeAt(i);
          }
        }

        hubConnection.invoke(
          "UpdatePlayer",
          args: [
            userList,
            widget.room.roomName,
          ],
        );

        setState(() {});
      }
    }
  }

  void playerUpdate(List<Object>? args) {
    if (args != null && isRoomAdmin != null && !isRoomAdmin!) {
      userList = [];

      for (var args in args[0] as List<dynamic>) {
        User user = User.fromJson(args as Map<String, dynamic>);

        if (!userList.contains(user)) {
          userList.add(user);
        }

        setState(() {});
      }
    }
  }

  void startTeamChoose(List<Object>? args) {
    if (args != null && isRoomAdmin != null && isRoomAdmin!) {
      userList = [];

      for (var args in args[0] as List<dynamic>) {
        User user = User.fromJson(args as Map<String, dynamic>);

        if (!userList.contains(user)) {
          userList.add(user);
        }

        allowJoin = args[1];
      }

      setState(() {});
    }
  }
}
