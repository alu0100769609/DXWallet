import 'package:flutter/material.dart';
import 'package:wallet_v2/views/Profile.dart';

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
        'AddVisa': (context)=> const AddVisa(),
        'Profile': (context)=> const Profile(),
        'Register': (context)=> const Register(),
        'VisaInfo': (context)=> VisaInfo(),
        'VisaList': (context)=> const VisaList(),
      },
    )
  );
}