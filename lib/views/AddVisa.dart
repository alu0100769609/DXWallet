import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/appbar/LoginAppBar.dart';
import '../connection/Connections.dart';
import '/constants/Constants.dart';
import '/constants/Strings.dart';

class AddVisa extends StatefulWidget {
  const AddVisa({Key? key}) : super(key: key);

  final bool debugThis = false; // Para entrar en el modo depuración

  @override
  State<AddVisa> createState() => _AddVisaState();
}

class _AddVisaState extends State<AddVisa> {
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
                /// Título Tarjeta
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Text(addNewVisa_str,
                    style: TextStyle(
                      fontSize: TITLE_SIZE,
                      color: CUSTOM_PRIMARY_DARK,
                    ),
                  ),
                ),
                /// Título Cuenta
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
                  child: Row(
                    children: const [
                      Text(visaData_str,
                        style: TextStyle(
                          fontSize: SUBTITLE_SIZE,
                          color: CUSTOM_PRIMARY_DARK,
                        ),
                      ),
                    ],
                  ),
                ),
                /// Campos de la nueva tarjeta
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      /// Nombre
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: _txtUsername,
                            autocorrect: false, // no autocorrige
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: visaName_str,
                            ),
                          )
                      ),
                      /// Número de tarjeta
                      Padding( // TODO: Campo no modificable, mostrar el num de tarjeta y ya
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _txtEmail,
                          autocorrect: false, // no autocorrige
                          keyboardType: TextInputType.emailAddress, // para que el teclado aparezca especialmente para introducir un email
                          decoration: const InputDecoration(
                            labelText: visaNumber_str,
                          ),
                        ),
                      ),
                      /// Moneda nueva (lista)
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: _txtPass,
                            autocorrect: false, // no autocorrige
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: currency_str,
                            ),
                          )
                      ),
                    ],
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