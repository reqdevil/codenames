// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Widgets/CustomDivider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  String user = 'unknow_user';
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(0),
      ),
      child: createMenuDrawer(context),
    );
  }

  Drawer createMenuDrawer(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.75,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red,
              Colors.blue,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Flexible(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    arrowColor: Colors.pink,
                    margin: const EdgeInsets.all(5),
                    accountEmail: const Text(
                      "name",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                      ),
                    ),
                    accountName: Column(
                      children: const [
                        SizedBox(
                          height: 35,
                        ),
                        Text(
                          "username",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                    currentAccountPictureSize: const Size.square(80.0),
                    currentAccountPicture: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.orange,
                          width: 3.0,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            ExactAssetImage('lib/assets/userImage.png'),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      ListTile(
                        dense: true,
                        selectedColor: Colors.purple,
                        selectedTileColor: Colors.red,
                        selected: false,
                        leading: const Icon(
                          Icons.verified_user,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Profil',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        onTap: () async {},
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      ListTile(
                        dense: true,
                        selectedColor: Colors.purple,
                        selectedTileColor: Colors.purple,
                        leading: RotationTransition(
                          turns: Tween(begin: 0.0, end: -.1)
                              .chain(CurveTween(curve: Curves.elasticIn))
                              .animate(_animationController),
                          child: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text(
                          'Bildirimler',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        onTap: () async {},
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      ListTile(
                        dense: true,
                        selectedColor: Colors.purple,
                        selectedTileColor: Colors.purple,
                        leading: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Ayarlar',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        onTap: () async {},
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      ListTile(
                        dense: true,
                        selectedColor: Colors.purple,
                        selectedTileColor: Colors.purple,
                        leading: const Icon(
                          Icons.border_color,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Geri Dönüş',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        onTap: () async {},
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                      bottom: 10,
                      right: 15,
                      top: 10,
                    ),
                    child: const CustomDivider(Colors.black),
                  ),
                  ListTile(
                    dense: true,
                    leading: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Güvenli Çıkış',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                  ),
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: const Image(
                    fit: BoxFit.contain,
                    image: AssetImage('lib/assets/logo.png'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 68,
                    bottom: 65,
                  ),
                  height: 15,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '© 2010 - ${DateTime.now().year}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Visibility menuIndicator(BuildContext context, String menuName) {
    return Visibility(
      visible: true,
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(left: 5),
        width: MediaQuery.of(context).size.width / 2,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            width: 1.5,
            color: Colors.purple,
          ),
          // borderRadius: BorderRadius.circular(12.0),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
      ),
    );
  }
}
