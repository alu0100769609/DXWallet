import 'package:flutter/material.dart';
import '/constants/Constants.dart';

class LoginAppBar extends StatefulWidget implements PreferredSizeWidget {
  const LoginAppBar({Key? key}) : preferredSize = const Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _LoginAppBar createState() => _LoginAppBar();
}

class _LoginAppBar extends State<LoginAppBar>{
  static const double largeLogoHeight = 50;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(LARGE_LOGO_ROUTE, height: largeLogoHeight)
        ],
      ),
      backgroundColor: CUSTOM_PRIMARY_DARK,
    );
  }
}