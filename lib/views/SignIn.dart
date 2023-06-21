import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/components/appbar/LoginAppBar.dart';
import '/connection/Connections.dart';

import '/constants/Constants.dart';
import '/constants/Strings.dart';

/// ////////////////////////////////////////////////////////////////////////////
/// //////////////////////////// VISTA DE LOGIN ////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final String email = "";
  final String password = "";

  // Instanciamos los controladores para recuperar el texto introducido por el usuario
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginAppBar(false),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            gapH30,
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                border: Border.all(color: CUSTOM_PRIMARY, width: 4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(SMALL_LOGO_ROUTE),
              ),
            ),
            gapH30,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(login_str,
                    style:TextStyle(
                      fontSize: TITLE_SIZE,
                      fontWeight: FontWeight.w500,
                    )
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField( // email
                controller: _txtEmail,
                autocorrect: false, // no autocorrige
                keyboardType: TextInputType.emailAddress, // para que el teclado aparezca especialmente para introducir un email
                decoration: const InputDecoration(
                  labelText: email_str,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  RegExp regExp = RegExp(REGEXP_VALIDATE_EMAIL);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : insertValidEmail_str;
                }, //Al cambiar, el campo de texto, de actualiza el form.
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField( // Contraseña
                  controller: _txtPass,
                  autocorrect: false, // no autocorrige
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: password_str,
                  ),
                )
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                  child: GestureDetector(
                    child: const Text(forgotPassword_str,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: NORMAL_SIZE,
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () => {
                      Fluttertoast.showToast(msg: "Clic en contraseña olvidada")
                      //SendCode(),
                    },
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  sendLogin(_txtEmail.text, _txtPass.text).then((Map response) {
                    if (response["success"] == "1") { // Si el inicio de sesión fue exitoso
                      Fluttertoast.showToast(msg: "Usuario encontrado: ${response["body"]}");
                    }
                    else {
                      Fluttertoast.showToast(msg: "${response["body"]}");
                    }
                  });
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(CUSTOM_PRIMARY),
                  backgroundColor: MaterialStateProperty.all<Color>(CUSTOM_SECONDARY_DARK),
                ),
                child: const Text(access_str,
                  style: TextStyle(color: CUSTOM_BLACK)
                )
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
                              Navigator.pushNamed(context, 'Register'),
                            },
                            child: const Text(goRegister_str,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: NORMAL_SIZE
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
      ),

    );
  }
}