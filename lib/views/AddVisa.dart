import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../connection/DniStorage.dart';
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
  final bool debugThis = false; // Para entrar en el modo depuración
  bool? checkedValue = false;

  // Instanciamos los controladores para recuperar el texto introducido por el usuario
  final TextEditingController _txtVisaName = TextEditingController();
  final TextEditingController _txtVisaNumber = TextEditingController();
  final TextEditingController _txtCurrency = TextEditingController();

  late String selectedOption;
  List<dynamic> stringOfCurrencies = [];

  bool allDataIsOk() {
    if (_txtVisaName.text.isEmpty ||
        _txtVisaNumber.text.isEmpty ||
        _txtCurrency.text.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> currencies() async {
    // ...resto de la función...
    // Realiza las operaciones para obtener las monedas
    Map<dynamic, dynamic> currencies = await getCurrencies(); // Ejemplo: función para obtener las monedas desde algún lugar

    List<dynamic> currenciesBody = currencies['body'];
    List<String> resultList = [""];
    for (var currency in currenciesBody) {
      String nombre = currency['nombre'];
      String simbolo = currency['simbolo'];
      String currencyString = '$nombre ($simbolo)';
      resultList.add(currencyString);
    }
    setState(() {
      if (DEBUGMODE && debugThis)
        print("MONEDAS: ${currencies}");
      stringOfCurrencies = resultList;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedOption = ''; // Establecer el elemento inicial seleccionado
    currencies();
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
                  child: Text(newVisa_str,
                    style: TextStyle(
                      fontSize: TITLE_SIZE,
                      color: CUSTOM_PRIMARY_DARK,
                    ),
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
                            controller: _txtVisaName,
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
                          readOnly: true,
                          controller: _txtVisaNumber,
//                          initialValue: "Hola",
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
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownButton<String>(
                                  value: selectedOption,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedOption = newValue!;
                                    });
                                  },
                                  items: stringOfCurrencies
//                                  items: <String>['', 'Moneda 1 (€)', 'Moneda 2 (\$)']
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                gapH30,
                /// Crear tarjeta
                ElevatedButton(
                    onPressed: () async {
                      print("MONEDAS: ${await getCurrencies()}"); // TODO: CONTINUAR DESDE AQUÍ

                      // petición
                      if (checkedValue!) {
                        if (allDataIsOk()) {
                          Map<String, String> data = {
                            "dni": await DniStorage.loadDNI().toString(),
                            "nombre_tarjeta": _txtVisaName.text,
                            "numero_tarjeta": _txtVisaNumber.text,
                            "moneda": _txtCurrency.text,
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
                    child: const Text(create_str,
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