import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wallet_v2/views/Ejemplo.dart';
import 'package:wallet_v2/views/Login.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Named routes",
      initialRoute: "ejemplo",
      routes: {
        '/': (context)=> Login(),
        'ejemplo': (context)=> LoginScreen(),
      },
    )
  );
}