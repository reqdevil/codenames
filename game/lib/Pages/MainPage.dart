// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Helpers/Helpers.dart';
import 'package:game/Models/Room.dart';
import 'package:game/Models/User.dart';
import 'package:game/Pages/TeamPage.dart';
import 'package:game/Services/API/Manager/ServerManager.dart';
import 'package:game/Services/Provider/HubConnection.dart';
import 'package:game/Services/ToastService.dart';
import 'package:game/Utilities/Constants.dart';
import 'package:game/Widgets/CustomButton.dart';
import 'package:game/Widgets/CustomDrawer.dart';
import 'package:game/Widgets/CustomTextField.dart';
import 'package:provider/provider.dart';
import 'package:signalr_netcore/signalr_client.dart';

class MainPage extends StatefulWidget {
  final User user;

  const MainPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final service = getIt<ServerManager>();

  late HubConnection hubConnection;

  Room? room;

  final roomIdController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Is user has another room?
    findUserRoom();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Connect SignalR
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
      drawer: CustomDrawer(user: widget.user),
      body: Container(
        color: AppColors.mainColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (room != null)
                const Text(
                  "Your old room:",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (room != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(room!.id.toString()),
                      const SizedBox(width: 25),
                      Text(room!.roomName),
                      const Expanded(child: SizedBox.shrink()),
                      GestureDetector(
                        child: const Icon(Icons.done_outline_rounded),
                        onTap: () async {
                          try {
                            final params = {
                              "roomId": room!.id.toString(),
                            };

                            final response = await service.postData(
                              path: JOIN_ROOM,
                              user: widget.user,
                              params: params,
                              parseFunction: (data) => roomFromJson(data),
                            );

                            // Insert HubConnection into provider
                            Provider.of<HubConnectionProvider>(context,
                                    listen: false)
                                .updateKisi(hubConnection);

                            await fadeNavigation(
                              context: context,
                              page: TeamPage(
                                user: widget.user,
                                room: response.data,
                              ),
                            );
                          } on Exception catch (e) {
                            ToastService.errorToast(
                              context,
                              "Error Occured",
                              e.toString(),
                              Alignment.bottomCenter,
                            );
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        child: const Icon(Icons.delete_outline_rounded),
                        onTap: () async {
                          final serverResponse = await service.postData(
                            path: DELETE_ROOM,
                            user: widget.user,
                            parseFunction: (data) => roomFromJson(data),
                          );

                          final serverRoom = serverResponse.data as Room;
                          if (!serverRoom.isActive) {
                            setState(() {
                              room = null;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              if (room != null) const SizedBox(height: 20),
              CustomButton(
                labelText: "Create Room",
                hasState: room == null,
                onPressed: () async {
                  if (room != null) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 4,
                          color: AppColors.bgColorDark,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  "You have a room registered to your account. If you continue, that room will be deleted. Do you confirm?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    const Expanded(child: SizedBox.shrink()),
                                    CustomButton(
                                      labelText: "Confirm",
                                      color: AppColors.white,
                                      onPressed: () async {
                                        try {
                                          final response =
                                              await service.postData(
                                            path: CREATE_ROOM,
                                            user: widget.user,
                                            parseFunction: (data) =>
                                                roomFromJson(data),
                                          );

                                          // Insert HubConnection into provider
                                          Provider.of<HubConnectionProvider>(
                                                  context,
                                                  listen: false)
                                              .updateKisi(hubConnection);

                                          await fadeNavigation(
                                            context: context,
                                            page: TeamPage(
                                              user: widget.user,
                                              room: response.data,
                                            ),
                                          );
                                        } on Exception catch (e) {
                                          ToastService.errorToast(
                                            context,
                                            "Error Occured",
                                            e.toString(),
                                            Alignment.bottomCenter,
                                          );
                                        }
                                      },
                                    ),
                                    const Expanded(child: SizedBox.shrink()),
                                    CustomButton(
                                      labelText: "Cancel",
                                      hasState: false,
                                      color: AppColors.white,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    const Expanded(child: SizedBox.shrink()),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  try {
                    final response = await service.postData(
                      path: CREATE_ROOM,
                      user: widget.user,
                      parseFunction: (data) => roomFromJson(data),
                    );

                    // Insert HubConnection into provider
                    Provider.of<HubConnectionProvider>(context, listen: false)
                        .updateKisi(hubConnection);

                    await fadeNavigation(
                      context: context,
                      page: TeamPage(
                        user: widget.user,
                        room: response.data,
                      ),
                    );
                  } on Exception catch (e) {
                    ToastService.errorToast(
                      context,
                      "Error Occured",
                      e.toString(),
                      Alignment.bottomCenter,
                    );
                  }
                },
              ),
              const SizedBox(height: 30),
              CustomTextField(
                controller: roomIdController,
                labelText: "Enter room id",
              ),
              const SizedBox(height: 15),
              CustomButton(
                labelText: "Join Room",
                onPressed: () async {
                  try {
                    final params = {
                      "roomId": room!.id.toString(),
                    };

                    final response = await service.postData(
                      path: JOIN_ROOM,
                      user: widget.user,
                      params: params,
                      parseFunction: (data) => roomFromJson(data),
                    );

                    // Insert HubConnection into provider
                    Provider.of<HubConnectionProvider>(context, listen: false)
                        .updateKisi(hubConnection);

                    await fadeNavigation(
                      context: context,
                      page: TeamPage(
                        user: widget.user,
                        room: response.data,
                      ),
                    );
                  } on Exception catch (e) {
                    ToastService.errorToast(
                      context,
                      "Error Occured",
                      e.toString(),
                      Alignment.bottomCenter,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void findUserRoom() async {
    final response = await service.postData(
      path: FIND_ROOM,
      user: widget.user,
      parseFunction: (data) => roomFromJson(data),
    );

    setState(() {
      room = response.data as Room;
    });
  }

  void initSignalR() {
    hubConnection = HubConnectionBuilder().withUrl(GAME_HUB).build();
    hubConnection.start();

    hubConnection.onclose(({error}) {
      ToastService.infoToast(
        context,
        "Hub Connection Lost",
        "Your connection to the server has been lost.",
        Alignment.bottomCenter,
      );
    });

    hubConnection.onreconnected(({connectionId}) {
      ToastService.infoToast(
        context,
        "Hub Connection Reconnected",
        "Your connection to the server has been reconnected.",
        Alignment.bottomCenter,
      );
    });

    // hubConnection.on("UserJoined", _handleUser);
    // hubConnection.on("ReceiveHint", _handleHint);
  }
}
