import 'package:flutter/material.dart';
import 'package:wallet_v2/components/cards/MovementCard.dart';
import 'package:wallet_v2/views/VisaInfo.dart';

import 'constants/Constants.dart';
import 'views/AddVisa.dart';
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
        'AddVisa': (context)=> const AddVisa(),
        'VisaInfo': (context)=> const VisaInfo(),
        'MovementCard': (context)=> const MovementCard(),
      },
    )
  );
}