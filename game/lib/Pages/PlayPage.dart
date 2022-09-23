// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Helpers/Helpers.dart';
import 'package:game/Models/Game.dart';
import 'package:game/Models/User.dart';
import 'package:game/Services/API/Manager/ServerManager.dart';
import 'package:game/Services/API/Response/DataResponse.dart';
import 'package:game/Services/SharedPreference.dart';
import 'package:game/Utilities/Constants.dart';
import 'package:game/Utilities/Enums/Teams.dart';
import 'package:game/Widgets/CardWidget.dart';
import 'package:game/Widgets/LogoCircularProgressIndicator.dart';
import 'package:game/Widgets/CustomDrawer.dart';
import 'package:game/Widgets/TeamContainer.dart';
import 'package:signalr_netcore/signalr_client.dart' as signalr;

class PlayPage extends StatefulWidget {
  final User user;

  const PlayPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final service = getIt<ServerManager>();

  Future<DataResponse<dynamic>>? wordList;
  late int blueRemaining;
  late int redRemaining;
  late bool endGame;
  late Widget body;

  final serverUrl = "http://10.0.2.2:25528/gamesocket";
  late signalr.HubConnection hubConnection;

  @override
  void initState() {
    super.initState();

    wordList = null;

    initWord();
    blueRemaining = -1;
    redRemaining = -1;
    endGame = false;

    initSignalR();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          hubConnection.state == signalr.HubConnectionState.Disconnected
              ? await hubConnection.start()
              : await hubConnection.stop();

          setState(() {
            print(hubConnection.state.toString());
          });
        },
        child: hubConnection.state == signalr.ConnectionState.Disconnected
            ? const Icon(Icons.play_arrow)
            : const Icon(Icons.stop),
      ),
      drawer: CustomDrawer(user: widget.user),
      body: FutureBuilder(
        future: wordList,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColors.mainColor,
                ),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                color: AppColors.mainColor,
                child: const LogoCircularProgressIndicator(),
              ),
            );
          }

          final game = (snapshot.data as DataResponse<dynamic>).data as Game;

          if (blueRemaining == -1 && redRemaining == -1) {
            if (game.startingTeam == Teams.blue) {
              blueRemaining = 9;
              redRemaining = 8;
            } else {
              blueRemaining = 8;
              redRemaining = 9;
            }
          }

          if (endGame) {
            body = Container(
              color: AppColors.transparent,
            );
          } else {
            body = Padding(
              padding: const EdgeInsets.all(5),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: game.wordList.length,
                  itemBuilder: (context, index) {
                    final item = game.wordList[index];

                    return Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          padding: const EdgeInsets.all(1),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image(
                              image: item.image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(1),
                          child: CardWidget(
                            text: item.vocable,
                            visible: item.isOpened ? 0 : 1,
                            onDoubleTap: () {
                              setState(() {
                                if (!item.isOpened) {
                                  if (item.image ==
                                          const AssetImage(
                                              "lib/assets/cards/r3.png") ||
                                      item.image ==
                                          const AssetImage(
                                              "lib/assets/cards/b3.png")) {
                                    setState(() {
                                      switch (item.team) {
                                        case Teams.blue:
                                          blueRemaining -= 1;
                                          break;
                                        case Teams.red:
                                          redRemaining -= 1;
                                          break;
                                        default:
                                      }

                                      item.isOpened = !item.isOpened;

                                      Future.delayed(
                                          const Duration(milliseconds: 1000),
                                          () {
                                        setState(() {
                                          endGame = true;
                                        });
                                      });
                                    });
                                  } else {
                                    switch (item.team) {
                                      case Teams.blue:
                                        blueRemaining -= 1;
                                        break;
                                      case Teams.red:
                                        redRemaining -= 1;
                                        break;
                                      default:
                                    }

                                    item.isOpened = !item.isOpened;

                                    if (blueRemaining == 1) {
                                      for (var item in game.wordList) {
                                        if (item.team == Teams.blue &&
                                            item.isOpened == false) {
                                          item.image = const AssetImage(
                                            "lib/assets/cards/b3.png",
                                          );
                                        }
                                      }
                                    } else if (redRemaining == 1) {
                                      for (var item in game.wordList) {
                                        if (item.team == Teams.red &&
                                            item.isOpened == false) {
                                          item.image = const AssetImage(
                                            "lib/assets/cards/r3.png",
                                          );
                                        }
                                      }
                                    }
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }),
            );
          }

          return IgnorePointer(
            ignoring: endGame,
            child: Container(
              color: game.startingTeam == Teams.red
                  ? AppColors.redBg
                  : AppColors.blueBg,
              padding: const EdgeInsets.only(top: kToolbarHeight),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Row(
                      children: [
                        TeamContainer(
                          team: Teams.red,
                          wordCount: redRemaining,
                        ),
                        Expanded(
                          child: MaterialButton(
                            child: const Text("data"),
                            onPressed: () async {
                              print("object");

                              // await service.joinRoom(
                              //   path: JOIN_ROOM,
                              //   params: {
                              //     "userId": "1",
                              //     "roomName": "Berk",
                              //   },
                              // );
                              hubConnection.invoke("JoinRoom", args: ["Berk"]);
                            },
                          ),
                        ),
                        TeamContainer(
                          team: Teams.blue,
                          wordCount: blueRemaining,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 1500),
                      child: body,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void initSignalR() {
    hubConnection = signalr.HubConnectionBuilder().withUrl(serverUrl).build();

    hubConnection.onclose(({error}) {
      print("Connection closed.");
      setState(() {});
    });

    hubConnection.onreconnected(({connectionId}) {
      print("Connection established.");
      setState(() {});
    });

    hubConnection.on("UserJoined", _handleUser);
    hubConnection.on("ReceiveHint", _handleHint);
  }

  void _handleHint(List<Object>? args) {
    if (args != null) {
      print("Args: ${args[0]} ${args[1]}");
    }
  }

  void _handleUser(List<Object>? args) {
    if (args != null) {
      print("Args: ${args[0]}");
    }
  }

  void initWord() async {
    // wordList = service.getData(
    //   path: START_GAME,
    //   parseFunction: (data) => gameFromJson(data),
    // );
  }
}
