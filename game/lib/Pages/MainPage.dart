// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Helpers/Helpers.dart';
import 'package:game/Models/User.dart';
import 'package:game/Pages/TeamPage.dart';
import 'package:game/Services/API/Manager/ServerManager.dart';
import 'package:game/Utilities/Constants.dart';
import 'package:game/Widgets/CustomButton.dart';
import 'package:game/Widgets/CustomDrawer.dart';
import 'package:game/Widgets/CustomTextField.dart';

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
  final _service = getIt<ServerManager>();

  final roomNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    findUserRoom();
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
              CustomButton(
                labelText: "Create Room",
                onPressed: () async {
                  // final response = await _service.createRoom(path: CREATE_ROOM);

                  // await fadeNavigation(
                  //   context: context,
                  //   page: TeamPage(
                  //     user: widget.user,
                  //     room: response.data!,
                  //   ),
                  // );
                },
              ),
              const SizedBox(height: 50),
              CustomTextField(
                controller: roomNameController,
                labelText: "Enter your room name",
              ),
              const SizedBox(height: 15),
              CustomButton(
                labelText: "Join Room",
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
  
  void findUserRoom() {
    
  }
}
