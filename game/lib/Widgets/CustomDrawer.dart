// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game/Helpers/AppColors.dart';
import 'package:game/Models/User.dart';
import 'package:game/Widgets/CustomDivider.dart';

class CustomDrawer extends StatefulWidget {
  final User user;

  const CustomDrawer({
    Key? key,
    required this.user,
  }) : super(key: key);

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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.bgColorDark,
              AppColors.mainColor,
              AppColors.bgColor
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
                      color: AppColors.transparent,
                    ),
                    margin: const EdgeInsets.all(5),
                    accountEmail: Text(
                      "${widget.user.name} ${widget.user.surname}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    accountName: Text(
                      widget.user.username,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    currentAccountPictureSize: const Size.square(80.0),
                    currentAccountPicture: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.mainColor,
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
                        selected: false,
                        leading: const Icon(
                          Icons.verified_user,
                          color: AppColors.white,
                        ),
                        title: const Text(
                          'Profil',
                          style: TextStyle(
                            color: AppColors.white,
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
                        leading: RotationTransition(
                          turns: Tween(begin: 0.0, end: -.1)
                              .chain(CurveTween(curve: Curves.elasticIn))
                              .animate(_animationController),
                          child: const Icon(
                            Icons.notifications,
                            color: AppColors.white,
                          ),
                        ),
                        title: const Text(
                          'Bildirimler',
                          style: TextStyle(
                            color: AppColors.white,
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
                        leading: const Icon(
                          Icons.settings,
                          color: AppColors.white,
                        ),
                        title: const Text(
                          'Ayarlar',
                          style: TextStyle(
                            color: AppColors.white,
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
                        leading: const Icon(
                          Icons.border_color,
                          color: AppColors.white,
                        ),
                        title: const Text(
                          'Geri Dönüş',
                          style: TextStyle(
                            color: AppColors.white,
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
                    child: const CustomDivider(AppColors.white),
                  ),
                  ListTile(
                    dense: true,
                    leading: const Icon(
                      Icons.exit_to_app,
                      color: AppColors.white,
                    ),
                    title: const Text(
                      'Güvenli Çıkış',
                      style: TextStyle(
                        color: AppColors.white,
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
                  height: 50,
                  alignment: Alignment.center,
                  child: const Image(
                    fit: BoxFit.contain,
                    image: AssetImage('lib/assets/logo.png'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 65,
                  ),
                  height: 15,
                  alignment: Alignment.center,
                  child: Text(
                    '© 2010 - ${DateTime.now().year}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
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
}
