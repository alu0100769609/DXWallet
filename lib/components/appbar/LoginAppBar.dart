import 'package:flutter/material.dart';
import '/constants/Constants.dart';

class LoginAppBar extends StatefulWidget implements PreferredSizeWidget {
//  const LoginAppBar({Key? key}) : preferredSize = const Size.fromHeight(kToolbarHeight), super(key: key);
  final bool showLogo;
  LoginAppBar([this.showLogo = true]) : preferredSize = const Size.fromHeight(kToolbarHeight);
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
          (widget.showLogo)?
          Image.asset(LARGE_LOGO_ROUTE, height: largeLogoHeight): EMPTY_BOX,
        ],
      ),
      backgroundColor: CUSTOM_PRIMARY_DARK,
    );
  }
}