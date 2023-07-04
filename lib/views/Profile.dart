import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallet_v2/components/alertdialogs/ChangePasswordAlertDialog.dart';
import 'package:wallet_v2/connection/DniStorage.dart';

import '../components/appbar/LoginAppBar.dart';
import '../connection/Connections.dart';
import '/constants/Constants.dart';
import '/constants/Strings.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  final bool debugThis = false; // Para entrar en el modo depuración

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool? checkedValue = false;
  String _enabled = "0";

  // Instanciamos los controladores para recuperar el texto introducido por el usuario
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtUsername = TextEditingController();
  final TextEditingController _txtNID = TextEditingController();
  final TextEditingController _txtName = TextEditingController();
  final TextEditingController _txtSurname1 = TextEditingController();
  final TextEditingController _txtSurname2 = TextEditingController();
  final TextEditingController _txtAddress = TextEditingController();
  final TextEditingController _txtPhone = TextEditingController();

  bool allDataIsOk() {
    if (_txtEmail.text.isEmpty ||
        _txtUsername.text.isEmpty ||
        _txtNID.text.isEmpty ||
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
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    String? dni = await DniStorage.loadDNI();
    Map<String, dynamic> userData = await getProfileInfo(dni);
    print("USERDATA: ${userData["body"][0]}");
    // Establecer valores predeterminados para los controladores de texto
    if (userData["success"] == "1") {
    _txtEmail.text = userData["body"][0]["email"];
    _txtUsername.text = userData["body"][0]["usuario"];
    _txtNID.text = dni!;
    _txtName.text = userData["body"][0]["nombre"];
    _txtSurname1.text = userData["body"][0]["apellido1"];
    _txtSurname2.text = userData["body"][0]["apellido2"];
    _txtAddress.text = userData["body"][0]["direccion"];
    _txtPhone.text = userData["body"][0]["telefono"];
    _enabled = userData["body"][0]["habilitado"];
    }

  }
  Future<Map<String, dynamic>> _loadUserData() async {
    String? dni = await DniStorage.loadDNI();
    Map<String, dynamic> userData = await getProfileInfo(dni);
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LoginAppBar(),
        body:FutureBuilder<Map<String, dynamic>>(
            future: _loadUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(), // Muestra un indicador de carga mientras se esperan los datos
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error al cargar los datos'), // Muestra un mensaje de error si hay un problema al cargar los datos
                );
              } else {
                // Los datos se han cargado correctamente
                Map<String, dynamic> userData = snapshot.data!;

                // Actualiza los controladores de texto con los datos cargados
                _txtEmail.text = userData["body"][0]["email"];
                _txtUsername.text = userData["body"][0]["usuario"];
                _txtNID.text = userData["body"][0]["dni"];
                _txtName.text = userData["body"][0]["nombre"];
                _txtSurname1.text = userData["body"][0]["apellido1"];
                _txtSurname2.text = userData["body"][0]["apellido2"];
                _txtAddress.text = userData["body"][0]["direccion"];
                _txtPhone.text = userData["body"][0]["telefono"];
                _enabled = userData["body"][0]["habilitado"];

                return SingleChildScrollView(
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
                            border: Border.all(color: CUSTOM_SECONDARY, width: 4),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(PROFILE_PHOTO),
                          ),
                        ),
                        /// Título Cuenta
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: (_enabled == "0")?
                          GestureDetector(
                            onTap: () {
                              Fluttertoast.showToast(msg: disabledUser_str);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(_txtName.text.toString(),
                                  style: TextStyle(
                                    fontSize: TITLE_SIZE,
                                    color: CUSTOM_PRIMARY_DARK,
                                  ),
                                ),
                                gapW5,
                                Icon(Icons.warning,color: Colors.amber,size: NORMAL_SIZE,)
                              ],
                            ),
                          ) :
                          Text(_txtName.text.toString(),
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
                              /// Acceder
                              ElevatedButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all<Color>(CUSTOM_PRIMARY),
                                  backgroundColor: MaterialStateProperty.all<Color>(CUSTOM_SECONDARY_DARK),
                                ),
                                child: const Text(changePassword_str,
                                    style: TextStyle(color: CUSTOM_BLACK)
                                ),
                                onPressed: () async {
                                  // petición
                                  return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ChangePasswordAlertDialog();
//                                    Fluttertoast.showToast(msg: "Alert Cambiar contraseña");
                                    },
                                  );
                                }
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
                        /// Guardar
                        ElevatedButton(
                            onPressed: () async {
                              if (allDataIsOk()) {
                                Map<String, String> data = {
                                  "usuario": _txtUsername.text,
                                  "email": _txtEmail.text,
                                  "nombre": _txtName.text,
                                  "apellido1": _txtSurname1.text,
                                  "apellido2": _txtSurname2.text,
                                  "dni": _txtNID.text,
                                  "direccion": _txtAddress.text,
                                  "telefono": _txtPhone.text
                                };
                                modifyData(data).then((Map response) {
                                  if (response["success"] == "1") { // Si se enviaron los datos
                                    Navigator.pushReplacementNamed(context, "VisaList");
                                  }
                                  else {
                                    Fluttertoast.showToast(msg: "Respuesta2: ${response["body"]}");
                                  }
                                });
                                Fluttertoast.showToast(msg: "Datos actualizados correctamente");
                              }
                              else {
                                Fluttertoast.showToast(msg: "Rellena todos los campos para continuar");
                              }
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(CUSTOM_PRIMARY),
                              backgroundColor: MaterialStateProperty.all<Color>(CUSTOM_SECONDARY_DARK),
                            ),
                            child: const Text(save_str,
                                style: TextStyle(color: CUSTOM_BLACK)
                            )
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
        )
    );
  }
}