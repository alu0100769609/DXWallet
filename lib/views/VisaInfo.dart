import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/alertdialogs/IncreaseBalanceAlertDialog.dart';
import '../components/appbar/LoginAppBar.dart';
import '../components/cards/MovementCard.dart';
import '../components/cards/VisaCard.dart';
import '../connection/Connections.dart';
import '../connection/DniStorage.dart';
import '../constants/Constants.dart';
import '../constants/Strings.dart';

class VisaInfo extends StatefulWidget {
  VisaInfo({Key? key}) : super(key: key);

  @override
  State<VisaInfo> createState() => _VisaInfoState();
}

class _VisaInfoState extends State<VisaInfo> {

  String? loadedDNI = "";
  String _visa = "";
  final bool debugThis = false;
 // Para entrar en el modo depuración
  late Future<Map> listOfMovements = Future<Map>.value({});
  String _scanBarcode = defaultText_str;
  late String moneyIcon;

  @override
  void initState() {
    super.initState();
    loadDNI();
  }

  void loadDNI() async {
    loadedDNI = await DniStorage.loadDNI();
    setState(() {
    });
  }
  void loadVisaList(String visa) async {
    setState(() {
      listOfMovements = getMovementList(loadedDNI!, visa);
    });
  }

  // Función que abre barcodeScan e introduce el valor en _scanBarcode
  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
//      Fluttertoast.showToast(msg: "Escaneo: $barcodeScanRes");
      // Scan debe devolver Visa comercio e importe.
      Map<String, String> scan = getValues(barcodeScanRes);
      print("Scan: $scan");
      // comprobamos que getValues no dio error
      if (scan["success"] == "1") {
        print("Valores SUCCESS");
        //Tenemos visa de tienda e importe. Hacemos el pago enviando además nuestra visa
        Map<dynamic, dynamic> responseMap = await pay(_visa, scan["visaNumber"]!, scan["amount"]!);
        print("RESPONSE: $responseMap");
        if (responseMap != null) {
          if (responseMap["success"] == "0") {
            Fluttertoast.showToast(msg: "Proceso cancelado.\n\n${responseMap["body"]}");
          }
          else {
            // El pago se realizó correctamente. Generamos factura
            // y creamos el movimiento correspondiente
            /// ////////////////////////////////////////////////////////////////////////////////////////////////////
            Map<dynamic, dynamic> responseMap2 = await generateBillAndMovement(_visa, scan["visaNumber"]!, scan["amount"]!);
            print("RESPONSE: $responseMap2");
            if (responseMap2 != null) {
              if (responseMap2["success"] == "0") {
                Fluttertoast.showToast(msg: "Proceso cancelado.\n\n${responseMap2["body"]}");
              }
              else {
                Fluttertoast.showToast(msg: "${responseMap2["body"]}");
              }
            }
            /// ////////////////////////////////////////////////////////////////////////////////////////////////////
            Fluttertoast.showToast(msg: "${responseMap["body"]}");
          }
        }
      }
      else {
        Fluttertoast.showToast(msg: "${scan["message"]}");
      }
//      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Map<String, String> getValues(String barcodeScanRes) {
    List<String> values = barcodeScanRes.split('\n');
    Map<String, String> data;
    String visaNumber;
    String amount;

    print("VALUES: $values");

    if (values.length != 2) {
      // Manejar un error si la cadena no contiene exactamente dos valores separados por un espacio
      data = {
        'success': "0",
        'message': "El QR no tiene el formato requerido",
      };
    }
    else {
      visaNumber = values[0];
      amount = values[1];
      // Aquí podríamos comprobar que visaNumber y amount son lo que deben ser..
      // De momento nos fiamos y omitimos por ahora.
      data = {
        'success': "1",
        'visaNumber': visaNumber,
        'amount': amount,
      };
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? visa = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    _visa = visa!['visaNumber'];
    loadVisaList(_visa);

    if (DEBUGMODE && debugThis)
      print("VISA: ${_visa}");

    return FutureBuilder<Map<String, dynamic>>(
      future: getVisaData(_visa),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mientras se carga, mostramos un indicador de carga
          return const Center(
            child: SizedBox(
              width: 40.0,
              height: 40.0,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // Si ocurre un error, mostramos un mensaje de error
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No data available');
        } else {
          if (DEBUGMODE && debugThis)
            print("SNAPSHOT DATA SUCCESS: ${snapshot.data!["message"]}");
          if (snapshot.data!["success"] == "0") {
            return Column(
              children: [
                gapH30,
                Center(
                  child: Text(snapshot.data!["body"],
                    style: const TextStyle(
                        fontSize: SUBTITLE_SIZE,
                        color: DISABLED_COLOR),
                  ),
                ),
                gapH30,
                const Icon(Icons.credit_card_off_rounded,
                  size: TITLE_SIZE * 4,
                  color: DISABLED_COLOR,
                ),
              ],
            );
          }
          else {
            final Map<String, dynamic> visaData = snapshot.data!["body"][0];
            moneyIcon = visaData["moneda"];
            if (DEBUGMODE && debugThis)
              print("VISADATA: ${visaData}");
            return Scaffold(
              appBar: LoginAppBar(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    VisaCard(
                      imagePath: BLUE_CREDIT_CARD,
                      name: visaData["nombre"],
                      number: visaData["numero_tarjeta"],
                      amount: "${visaData["saldo"].toString()} ${visaData["moneda"]}",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            scanQR();
//                            Navigator.pushNamed(context, "QrScanScreen");
//                            Fluttertoast.showToast(msg: "Abrir cámara");
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(CUSTOM_PRIMARY),
                            backgroundColor: MaterialStateProperty.all<Color>(CUSTOM_SECONDARY_DARK),
                            minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 48)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.qr_code_scanner,size: TITLE_SIZE),
                              gapW10,
                              Text(pay_str,
                                  style: TextStyle(color: Colors.white,fontSize: TITLE_SIZE)
                              ),
                            ],
                          )
                      ),
                    ),
                    gapH30,
                    FutureBuilder<Map>(
                      future: listOfMovements,
                      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Errores: ${snapshot.error}');
                        } else if (!snapshot.hasData) {
                          return Text('No data available');
                        }else { // Retorna datos
                          if (DEBUGMODE && debugThis)
                            print("SNAPSHOT DATA SUCCESS: ${snapshot.data!["success"]}");
                          if (snapshot.data!["success"] == "0") {
                            return Column(
                              children: [
                                gapH30,
                                Center(
                                  child: Text(snapshot.data!["body"],
                                    style: const TextStyle(
                                        fontSize: SUBTITLE_SIZE,
                                        color: DISABLED_COLOR),
                                  ),
                                ),
                                gapH30,
                                const Icon(Icons.credit_card_off_rounded,
                                  size: TITLE_SIZE * 4,
                                  color: DISABLED_COLOR,
                                ),
                              ],
                            );
                          }
                          else {
                            List<dynamic> movementList = snapshot.data!["body"];
                            movementList.sort((a, b) => b["fecha"].compareTo(a["fecha"]));
                            int cardCount = movementList.length;
                            return Column(
                              children: List.generate(cardCount, (index) {
                                Map<dynamic, dynamic> movementData = movementList[index];
                                return MovementCard(
                                  shopName: movementData["nombre_tienda"],
                                  amount: movementData["cantidad"],
                                  currency: moneyIcon,
                                  movementDate: movementData["fecha"],
                                  ticketURL: movementData["ticketURL"],
                                );
                              }),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: VALID_GREEN,
                onPressed: () async {
                  return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return IncreaseBalanceAlertDialog(visaNumber: _visa);
                      }
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(moneyIcon, style: TextStyle(fontSize: SUBTITLE_SIZE)),
                    Icon(Icons.add),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
