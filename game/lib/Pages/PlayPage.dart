// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Helpers/Helpers.dart';
import 'package:game/Models/User.dart';
import 'package:game/Models/Word.dart';
import 'package:game/Services/API/Manager/ServerManager.dart';
import 'package:game/Services/API/Response/ListResponse.dart';
import 'package:game/Utilities/Constants.dart';
import 'package:game/Utilities/Enums/IslemSonucu.dart';
import 'package:game/Utilities/Enums/Teams.dart';
import 'package:game/Widgets/CardWidget.dart';
import 'package:game/Widgets/LogoCircularProgressIndicator.dart';
import 'package:game/Widgets/CustomDrawer.dart';
import 'package:game/Widgets/TeamContainer.dart';

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

  final serverUrl = "http://10.0.2.2:25528/gamesocket";
  // late HubConnection hubConnection;

  Color backgroundColor = AppColors.blueBg;

  late int userId;
  late String hint;

  @override
  void initState() {
    super.initState();

    // initSignalR();

    userId = 1;
    hint = "deneme";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Icon(Icons.stop),
      ),
      drawer: CustomDrawer(user: widget.user),
      body: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Row(
                children: [
                  const TeamContainer(team: Teams.red),
                  Expanded(child: Container()),
                  const TeamContainer(team: Teams.blue)
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FutureBuilder(
                  future: initWord(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: AppColors.white,
                            ),
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final response = snapshot.data as ListResponse<Word>;

                        if (response.islemSonucu ==
                            IslemSonucu.BasariylaTamamlandi) {
                          return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                childAspectRatio: 1.5,
                              ),
                              itemCount: response.data!.length,
                              itemBuilder: (context, index) {
                                final item = response.data![index];

                                return Container(
                                  padding: const EdgeInsets.all(1),
                                  child: CardWidget(text: item.value),
                                );
                              });
                        } else {
                          return Center(
                            child: Text(
                              '${response.mesajlar!.first}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          );
                        }
                      }
                    }

                    return const Center(
                      child: LogoCircularProgressIndicator(),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void initSignalR() {
  //   hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
  //   hubConnection.onclose(({error}) {
  //     print("Connection closed.");
  //   });
  //   hubConnection.on("ReceiveHint", _handleHint);
  // }

  // void _handleHint(List<Object>? args) {
  //   if (args != null) {
  //     setState(() {
  //       userId = args[0] as int;
  //       hint = args[1] as String;
  //     });
  //   }
  // }

  Future<ListResponse<Word>> initWord() {
    return service.getWords(path: GET_PLAY_WORDS);
  }
}
