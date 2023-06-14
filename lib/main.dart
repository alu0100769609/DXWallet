import 'package:flutter/material.dart';

import 'views/SignIn.dart';
import 'views/SignUp.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Named routes",
      initialRoute: "/",
      routes: {
        '/': (context)=> Login(),
        'Register': (context)=> const Register(),
      },
    )
  );
}