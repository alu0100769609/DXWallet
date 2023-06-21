import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/appbar/LoginAppBar.dart';
import '../connection/Connections.dart';
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
  final TextEditingController _txtUsername = TextEditingController();
  final TextEditingController _txtNID = TextEditingController();
  final TextEditingController _txtPass = TextEditingController();
  final TextEditingController _txtPass2 = TextEditingController();
  final TextEditingController _txtName = TextEditingController();
  final TextEditingController _txtSurname1 = TextEditingController();
  final TextEditingController _txtSurname2 = TextEditingController();
  final TextEditingController _txtAddress = TextEditingController();
  final TextEditingController _txtPhone = TextEditingController();

  bool allDataIsOk() {
    if (_txtEmail.text.isEmpty ||
        _txtUsername.text.isEmpty ||
        _txtNID.text.isEmpty ||
        _txtPass.text.isEmpty ||
        _txtPass2.text.isEmpty ||
        _txtName.text.isEmpty ||
        _txtSurname1.text.isEmpty ||
        _txtSurname2.text.isEmpty ||
        _txtAddress.text.isEmpty ||
        _txtPhone.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginAppBar(false),
      body:SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode
              .onUserInteraction, //valida cuando el usuario empieze a escribir
          child: Column(
            children: [
              gapH30,
              /// Imagen
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
              /// Título Cuenta
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(createAccount_str,
                  style: TextStyle(
                    fontSize: TITLE_SIZE,
                    color: CUSTOM_PRIMARY_DARK,
                  ),
                ),
              ),
              /// Título Cuenta usuario
              Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Row(
                  children: const [
                    Text(accountData_str,
                      style: TextStyle(
                        fontSize: SUBTITLE_SIZE,
                        color: CUSTOM_PRIMARY_DARK,
                      ),
                    ),
                  ],
                ),
              ),
              /// Campos Cuenta de usuario
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    /// Usuario
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _txtUsername,
                          autocorrect: false, // no autocorrige
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: username_str,
                          ),
                        )
                    ),
                    /// Email
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
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
                    /// Contraseña
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _txtPass,
                          autocorrect: false, // no autocorrige
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: password_str,
                          ),
                        )
                    ),
                    /// Repetir Contraseña
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                            controller: _txtPass2,
                            autocorrect: false, // no autocorrige
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: repeatPassword_str,
                            ),
                            validator: (value) {
                              if (_txtPass.text != value) {
                                return differentPassword_str;
                              }
                              return null;
                            }
                        )
                    ),
                  ],
                ),
              ),
              /// Título Datos personales
              Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Row(
                  children: const [
                    Text(personalData_str,
                      style: TextStyle(
                        fontSize: SUBTITLE_SIZE,
                        color: CUSTOM_PRIMARY_DARK,
                      ),
                    ),
                  ],
                ),
              ),
              /// Campos Datos personales
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    /// Nombre
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _txtName,
                          autocorrect: false, // no autocorrige
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: name_str,
                          ),
                        )
                    ),
                    /// Primer apellido
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                            controller: _txtSurname1,
                            autocorrect: false, // no autocorrige
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: surname1_str,
                            )
                        )
                    ),
                    /// Segundo apellido
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                            controller: _txtSurname2,
                            autocorrect: false, // no autocorrige
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: surname2_str,
                            )
                        )
                    ),
                    /// DNI
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _txtNID,
                          autocorrect: false, // no autocorrige
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: nid_str,
                          ),
                        )
                    ),
                    /// Dirección
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                            controller: _txtAddress,
                            autocorrect: false, // no autocorrige
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: address_str,
                            )
                        )
                    ),
                    /// Teléfono
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                            controller: _txtPhone,
                            autocorrect: false, // no autocorrige
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: phone_str,
                            )
                        )
                    ),
                  ],
                ),
              ),
              /// Política privacidad
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
              /// Checkbox política
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
              /// Acceder
              ElevatedButton(
                  onPressed: () async {
                    // petición
                    if (checkedValue!) {
                      if (allDataIsOk()) {
                        Map<String, String> data = {
                          "usuario": _txtUsername.text,
                          "email": _txtEmail.text,
                          "password": _txtPass.text,
                          "nombre": _txtName.text,
                          "apellido1": _txtSurname1.text,
                          "apellido2": _txtSurname2.text,
                          "dni": _txtNID.text,
                          "direccion": _txtAddress.text,
                          "telefono": _txtPhone.text
                        };
                        sendRegister(data).then((Map response) {
                          if (response["success"] == "1") { // Si se enviaron los datos
                            Fluttertoast.showToast(msg: "${response["body"]}");
                            Navigator.pushReplacementNamed(context, "/");
                          }
                          else {
                            Fluttertoast.showToast(msg: "Respuesta: ${response["body"]}");
                          }
                        });
                        Fluttertoast.showToast(msg: "Registro completo");
                      }
                      else {
                        Fluttertoast.showToast(msg: "Rellena todos los campos para continuar");
                      }
                    }
                    else {
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