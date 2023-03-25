//TODO: Aquí la petición genérica con las conexiones pertinentes

import 'package:http/http.dart' as http;
import 'dart:convert';

/// ////////////////////////////////////////////////////////////////////////////
/// //////////////////////// PETICIONES AL SERVIDOR ////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////

/// LOGIN //////////////////////////////////////////////////////////////////////
Future<Map> sendLogin(String email, String password) async {
  final url = Uri.parse('https://sebt.es/adexe/app_related/register_login/login.php');
  final response = await http.post(url, body: {
    'USERS': email,
    'PASS': password,
  });

  final Map <String, String> resp = { "success" : "no", "body" : ""};

  if (response.statusCode == 200) {
    // Si la respuesta es exitosa, aquí puedes realizar cualquier acción que quieras, como navegar a la siguiente pantalla.
    print('Inicio de sesión exitoso!');
    print(jsonDecode(response.body));
    resp.update("success", (value) => "yes");
    resp.update("body", (value) => jsonDecode(response.body));
  }
  else {
    // Si la respuesta no es exitosa, aquí puedes mostrar un mensaje de error.
    print('Error al iniciar sesión: ${response.statusCode}');
    resp.update("success", (value) => "no");
    resp.update("body", (value) => "ERROR: ${response.statusCode}");
  }
  return resp;
}

/// REGISTRO ///////////////////////////////////////////////////////////////////
