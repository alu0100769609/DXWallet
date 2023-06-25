import 'package:flutter/material.dart';

import 'constants/Constants.dart';
import 'views/SignIn.dart';
import 'views/SignUp.dart';
import 'views/VisaList.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: DEBUGMODE,
      title: "Named routes",
      initialRoute: "/",
      routes: {
        '/': (context)=> Login(),
        'Register': (context)=> const Register(),
        'VisaList': (context)=> const VisaList(),
      },
    )
  );
}