import 'package:flutter/material.dart';
import 'package:wallet_v2/constants/constants.dart';

class LoginAppBar extends StatefulWidget implements PreferredSizeWidget {
  const LoginAppBar({Key? key}) : preferredSize = const Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _LoginAppBar createState() => _LoginAppBar();
}

class _LoginAppBar extends State<LoginAppBar>{

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(largeLogoRoute, height: largeLogoHeight)
        ],
      ),
      backgroundColor: colorPrimaryDark,
    );
  }
}