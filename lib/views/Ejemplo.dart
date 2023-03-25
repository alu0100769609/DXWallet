import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Define la función que maneja la petición de inicio de sesión y devuelve el token
Future<String> login(String email, String password) async {
  final url = Uri.parse('https://sebt.es/adexe/app_related/register_login/login.php');
  final response = await http.post(url, body: {
    'USERS': email,
    'PASS': password,
  });

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    final token = jsonResponse['token'];

    // Si la respuesta es exitosa, devuelve el token
    return token;
  } else {
    // Si la respuesta no es exitosa, lanza una excepción
    throw Exception('Error al iniciar sesión: ${response.statusCode}');
  }
}

// En tu widget, puedes llamar a la función de inicio de sesión y mostrar el resultado en un Text widget
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _token = '';

  Future<void> _handleLogin(String email, String password) async {
    try {
      final token = await login(email, password);
      setState(() {
        _token = token;
      });
    } catch (e) {
      // Si se produce un error, muestra el mensaje de error en la consola
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Token: $_token'),
            ElevatedButton(
              onPressed: () => _handleLogin('g', 'g'),
              child: Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
