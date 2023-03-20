import 'package:flutter/material.dart';
import 'package:wallet_v2/constants/constants.dart';

class LogoAppBar extends StatefulWidget implements PreferredSizeWidget {
  const LogoAppBar({Key? key}) : preferredSize = const Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _LogoAppBar createState() => _LogoAppBar();
}

class _LogoAppBar extends State<LogoAppBar>{

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