import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/appbar/LoginAppBar.dart';
import '/constants/Constants.dart';
import '/constants/Strings.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool? checkedValue = false;

  // Instanciamos los controladores para recuperar el texto introducido por el usuario
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtPass = TextEditingController();
  final TextEditingController _txtPass2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoginAppBar(),
      body:SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode
              .onUserInteraction, //valida cuando el usuario empieze a escribir
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
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(createAccount_str,
                  style: TextStyle(
                    fontSize: TITLE_SIZE,
                    color: CUSTOM_PRIMARY_DARK,
                  ),
                ),
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
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField( // Contraseña
                    controller: _txtPass2,
                    autocorrect: false, // no autocorrige
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: password_str,
                    ),
                    validator: (value) {
                      if (_txtPass.text != value) {
                        return differentPassword_str;
                      }
                      return null;
                    }
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GestureDetector(
                  child: const Text(showPolicy_str,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue)),
                  onTap: () => {Fluttertoast.showToast(msg: "Política de privacidad")},
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: CheckboxListTile(
                  title: const Text(readAndAcceptPolicy_str),
                  value: checkedValue,
                  onChanged: (newValue) {
                    setState(() {
                      checkedValue = newValue;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.green,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    // petición
                    Fluttertoast.showToast(msg: "Registrarse");
                    if (checkedValue!) {
                      Fluttertoast.showToast(msg: "Checkbox");
                    } else {
                      Fluttertoast.showToast(
                          msg: "Debes aceptar las políticas de privacidad");
                    }
                  },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(CUSTOM_PRIMARY),
                  backgroundColor: MaterialStateProperty.all<Color>(CUSTOM_SECONDARY_DARK),
                ),
                child: const Text(access_str,
                    style: TextStyle(color: CUSTOM_BLACK)
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}