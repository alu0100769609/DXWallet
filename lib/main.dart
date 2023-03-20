import 'package:flutter/material.dart';
import 'package:wallet_v2/views/Login.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Named routes",
      initialRoute: "/",
      routes: {
        '/': (context)=> const Login()
      },
    )
  );
}