import 'package:http/http.dart' as http;
import 'dart:convert';

import '/constants/Constants.dart';

/// ////////////////////////////////////////////////////////////////////////////
/// //////////////////////// PETICIONES AL SERVIDOR ////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////

/// LOGIN //////////////////////////////////////////////////////////////////////
Future<Map> sendLogin(String email, String password) async {
  final url = Uri.parse(LOGIN_URL);
  final response = await http.post(url, body: {
    'USERS': email,
    'PASS': password,
  });

  final Map <String, dynamic> resp = { "success" : "0", "body" : ""};

  if (response.statusCode == 200) { // La conexión fue exitosa
     print('Conexión establecida');
    dynamic respuesta = jsonDecode(response.body);
    if (respuesta["success"] == "1") { // Si se hizo login
      print("Autenticación correcta: ${respuesta["login"]}");
      // Guardamos la respuesta del login
      resp.update("success", (value) => "1");
      resp.update("body", (value) => respuesta["login"]);
    }
    else { // Si no se hizo login
      print("Error de autenticación");
      resp.update("body", (value) => "Usuario o contraseña incorrecto");
    }
  }
  else {
    // Si la respuesta no es exitosa, mostramos un mensaje de error.
    print('Conexión no establecida: ${response.statusCode}');
    resp.update("body", (value) => "ERROR: ${response.statusCode}");
  }
  return resp;
}

/// REGISTRO ///////////////////////////////////////////////////////////////////
