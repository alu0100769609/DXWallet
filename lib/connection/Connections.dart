import 'package:http/http.dart' as http;
import 'dart:convert';

import '/constants/Constants.dart';

/// ////////////////////////////////////////////////////////////////////////////
/// //////////////////////// PETICIONES AL SERVIDOR ////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////

/// LOGIN //////////////////////////////////////////////////////////////////////
Future<Map> sendLogin(String email, String password) async {
  const bool debugThis = false; // Para entrar en el modo depuración
  final url = Uri.parse(LOGIN_URL);
  final response = await http.post(url, body: {
    'email': email,
    'password': password,
  });

  final Map <String, dynamic> resp = { "success" : "0", "body" : ""};

  if (response.statusCode == 200) { // La conexión fue exitosa
    if (DEBUGMODE && debugThis)
      print('Conexión establecida');
    dynamic respuesta = jsonDecode(response.body);
    if (respuesta["success"] == "1") { // Si se hizo login
      if (DEBUGMODE && debugThis)
        print("Autenticación correcta: ${respuesta["login"]}");
      // Guardamos la respuesta del login
      resp.update("success", (value) => "1");
      resp.update("body", (value) => respuesta["login"]);
    }
    else { // Si no se hizo login
      if (DEBUGMODE && debugThis)
        print("Error de autenticación: ${respuesta["message"]}");
      resp.update("body", (value) => respuesta["message"]);
    }
  }
  else {
    // Si la respuesta no es exitosa, mostramos un mensaje de error.
    if (DEBUGMODE && debugThis)
      print('Conexión no establecida: ${response.statusCode}');
    resp.update("body", (value) => "ERROR: ${response.statusCode}");
  }
  return resp;
}

/// REGISTER ///////////////////////////////////////////////////////////////////
Future<Map> sendRegister(Map<String, String> data) async {
  const bool debugThis = false; // Para entrar en el modo depuración
  final url = Uri.parse(REGISTER_URL);
  final response = await http.post(url, body: data);

  final Map <String, dynamic> resp = { "success" : "0", "body" : ""};

  if (response.statusCode == 200) { // La conexión fue exitosa
    if (DEBUGMODE && debugThis)
      print('Conexión establecida');
    dynamic respuesta = jsonDecode(response.body);
    if (respuesta["success"] == "1") { // Si se introdujeron los datos
      if (DEBUGMODE && debugThis)
        print("Datos enviados correctamente: ${respuesta["message"]}");
      // Guardamos la respuesta del login
      resp.update("success", (value) => "1");
      resp.update("body", (value) => respuesta["message"]);
    }
    else { // Si no se introdujeron los datos
      if (DEBUGMODE && debugThis)
        print("Error al enviar los datos: ${respuesta["message"]}");
      resp.update("body", (value) => respuesta["message"]);
    }
  }
  else {
    // Si la respuesta no es exitosa, mostramos un mensaje de error.
    if (DEBUGMODE && debugThis)
      print('Conexión no establecida: ${response.statusCode}');
    resp.update("body", (value) => "ERROR: ${response.statusCode}");
  }
  return resp;
}

/// GET LIST OF VISAS //////////////////////////////////////////////////////////
Future<Map> getVisaList(String nid) async {
  const bool debugThis = false; // Para entrar en el modo depuración
  final url = Uri.parse(GET_VISAS_URL);
  final response = await http.post(url, body: {
    'dni': nid,
  });

  final Map <String, dynamic> resp = { "success" : "0", "body" : ""};

  if (response.statusCode == 200) { // La conexión fue exitosa
    if (DEBUGMODE && debugThis)
      print('Conexión establecida');
    dynamic respuesta = jsonDecode(response.body);
    if (respuesta["success"] == "1") { // Si se encontraron datos
      if (DEBUGMODE && debugThis)
        print("Datos encontrados: ${respuesta["visaList"]}");
      // Guardamos la respuesta del login
      resp.update("success", (value) => "1");
      resp.update("body", (value) => respuesta["visaList"]);
    }
    else { // Si no se encontraron datos
      if (DEBUGMODE && debugThis)
        print("Error, no hay visas: ${respuesta["message"]}");
      resp.update("body", (value) => respuesta["message"]);
    }
  }
  else {
    // Si la respuesta no es exitosa, mostramos un mensaje de error.
    if (DEBUGMODE && debugThis)
      print('Conexión no establecida: ${response.statusCode}');
    resp.update("body", (value) => "ERROR: ${response.statusCode}");
  }
  return resp;
}

/// GET CURRENCIES /////////////////////////////////////////////////////////////
Future<Map> getCurrencies() async {
  const bool debugThis = false; // Para entrar en el modo depuración
  final url = Uri.parse(GET_CURRENCIES_URL);
  final response = await http.post(url);

  final Map <String, dynamic> resp = { "success" : "0", "body" : ""};

  if (response.statusCode == 200) { // La conexión fue exitosa
    if (DEBUGMODE && debugThis)
      print('Conexión establecida');
    dynamic respuesta = jsonDecode(response.body);
    if (respuesta["success"] == "1") { // Si se encontraron datos
      if (DEBUGMODE && debugThis)
        print("Datos encontrados: ${respuesta["currencies"]}");
      // Guardamos la respuesta del login
      resp.update("success", (value) => "1");
      resp.update("body", (value) => respuesta["currencies"]);
    }
    else { // Si no se encontraron datos
      if (DEBUGMODE && debugThis)
        print("Error, no hay visas: ${respuesta["message"]}");
      resp.update("body", (value) => respuesta["message"]);
    }
  }
  else {
    // Si la respuesta no es exitosa, mostramos un mensaje de error.
    if (DEBUGMODE && debugThis)
      print('Conexión no establecida: ${response.statusCode}');
    resp.update("body", (value) => "ERROR: ${response.statusCode}");
  }
  return resp;
}

/// CHECK VISA NUMBER ////////////////////////////////////////////////////////
/*
Future<Map> existVisaNumber(String visaNumber) async { // TODO: Está pendiente
  const bool debugThis = false; // Para entrar en el modo depuración
  final url = Uri.parse(GET_VISA_NUMBER_URL);
  print("AQUI ESTAMOS");
  final response = await http.post(url, body: {
    'visa_number': visaNumber,
  });

  final Map <String, dynamic> resp = { "success" : "0", "body" : ""};

  if (response.statusCode == 200) { // La conexión fue exitosa
    if (DEBUGMODE && debugThis)
      print('Conexión establecida');
    dynamic respuesta = jsonDecode(response.body);
    if (respuesta["success"] == "1") { // Si se encontraron datos
      if (DEBUGMODE && debugThis)
        print("Mal, hay coincidencia encontrada");
      resp.update("success", (value) => "1");
      resp.update("body", (value) => respuesta["body"]);
    }
    else { // Si no se encontraron datos
      if (DEBUGMODE && debugThis)
        print("Bien, no existe el número de visa: ${visaNumber}");
      resp.update("body", (value) => respuesta["body"]);
    }
  }
  else {
    // Si la respuesta no es exitosa, mostramos un mensaje de error.
    if (DEBUGMODE && debugThis)
      print('Conexión no establecida: ${response.statusCode}');
    resp.update("body", (value) => "ERROR: ${response.statusCode}");
  }
  return resp;
}
*/

/// ADD NEW VISA ///////////////////////////////////////////////////////////////
Future<Map> addNewVisa(Map<String, String> data) async {
  const bool debugThis = false; // Para entrar en el modo depuración
  final url = Uri.parse(ADD_NEW_VISA_URL);
  final response = await http.post(url, body: data);

  final Map <String, dynamic> resp = { "success" : "0", "body" : ""};

  if (response.statusCode == 200) { // La conexión fue exitosa
    if (DEBUGMODE && debugThis)
      print('Conexión establecida');
    dynamic respuesta = jsonDecode(response.body);
    if (respuesta["success"] == "1") { // Si se introdujeron los datos
      if (DEBUGMODE && debugThis)
        print("Datos enviados correctamente: ${respuesta["message"]}");
      resp.update("success", (value) => "1");
      resp.update("body", (value) => respuesta["message"]);
    }
    else { // Si no se introdujeron los datos
      if (DEBUGMODE && debugThis)
        print("Error al enviar los datos: ${respuesta["message"]}");
      resp.update("body", (value) => respuesta["message"]);
    }
  }
  else {
    // Si la respuesta no es exitosa, mostramos un mensaje de error.
    if (DEBUGMODE && debugThis)
      print('Conexión no establecida: ${response.statusCode}');
    resp.update("body", (value) => "ERROR: ${response.statusCode}");
  }
  return resp;
}

/// GET VISA DATA //////////////////////////////////////////////////////////////
Future<Map<String, dynamic>> getVisaData(String visaNumber) async {
  const bool debugThis = false; // Para entrar en el modo depuración
  final url = Uri.parse(GET_VISA_DATA_URL);
  final response = await http.post(url, body: {
    'visa_number': visaNumber,
  });

  final Map <String, dynamic> resp = { "success" : "0", "body" : ""};

  if (response.statusCode == 200) { // La conexión fue exitosa
    if (DEBUGMODE && debugThis)
      print('Conexión establecida');
    dynamic respuesta = jsonDecode(response.body);
    if (respuesta["success"] == "1") { // Si se encontraron datos
      if (DEBUGMODE && debugThis)
        print("Datos encontrados: ${respuesta["visa"]}");
      resp.update("success", (value) => "1");
      resp.update("body", (value) => respuesta["visa"]);
    }
    else { // Si no se encontraron datos
      if (DEBUGMODE && debugThis)
        print("Error, no hay visa: ${respuesta["message"]}");
      resp.update("body", (value) => respuesta["message"]);
    }
  }
  else {
    // Si la respuesta no es exitosa, mostramos un mensaje de error.
    if (DEBUGMODE && debugThis)
      print('Conexión no establecida: ${response.statusCode}');
    resp.update("body", (value) => "ERROR: ${response.statusCode}");
  }
  return resp;
}

