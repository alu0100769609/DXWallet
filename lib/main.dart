import 'package:flutter/material.dart';

import 'constants/Constants.dart';
import 'views/AddVisa.dart';
import 'views/SignIn.dart';
import 'views/SignUp.dart';
import 'views/VisaList.dart';
import 'views/VisaInfo.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: DEBUGMODE,
      title: "DX-Wallet APP",
      initialRoute: "/",
      routes: {
        '/': (context)=> Login(),
        'Register': (context)=> const Register(),
        'VisaList': (context)=> const VisaList(),
        'AddVisa': (context)=> const AddVisa(),
        'VisaInfo': (context)=> VisaInfo(),
      },
    )
  );
}