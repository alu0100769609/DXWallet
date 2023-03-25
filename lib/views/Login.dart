import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallet_v2/components/appbar/LoginAppBar.dart';
import 'package:wallet_v2/components/inputtext/InputText.dart';

import 'package:wallet_v2/constants/constants.dart';
import 'package:wallet_v2/constants/strings.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

/// ////////////////////////////////////////////////////////////////////////////
/// //////////////////////////// VISTA DE LOGIN ////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoginAppBar(),
      body:  Column(
        children: [
          gapH30,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(login_str,
                  style:TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w500,
                  )
              )
            ],
          ),
          gapH50,
          const Text(userName_str),
          gapH10,
          const InputText(password: false),
          gapH20,
          const Text(password_str),
          gapH10,
          const InputText(password: true),
          gapH30,
          ElevatedButton(
              onPressed: ()=>{
                Fluttertoast.showToast(msg: enter_str),
                login('g', 'g') // TODO: AUTOMATIZAR. Leer desde textField
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(colorLightGrey),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text(enter_str,
              style: TextStyle(color: colorBlack),)
          ),

          Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child:SizedBox(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(askNoAccount_str),
                      Padding(padding: const EdgeInsets.fromLTRB(10,0, 0, 0),
                        child:GestureDetector(
                          onTap: ()=>{
                            Fluttertoast.showToast(msg: goRegister_str)
                          },
                          child: const Text(goRegister_str,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: normalSize
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              )
          ),
        ],
      ),

    );
  }
}

/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////// PETICIÓN AL SERVIDOR ////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////

// Define la función que maneja la petición de inicio de sesión
Future<void> login(String email, String password) async {
  final url = Uri.parse('https://sebt.es/adexe/app_related/register_login/login.php');
  final response = await http.post(url, body: {
    'USERS': email,
    'PASS': password,
  });

  if (response.statusCode == 200) {
    // Si la respuesta es exitosa, aquí puedes realizar cualquier acción que quieras, como navegar a la siguiente pantalla.
    print('Inicio de sesión exitoso!');
    print(jsonDecode(response.body));
  } else {
    // Si la respuesta no es exitosa, aquí puedes mostrar un mensaje de error.
    print('Error al iniciar sesión: ${response.statusCode}');
  }
}

// Luego, llama a la función de inicio de sesión en tu código
