import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallet_v2/components/cards/MovementCard.dart';
import 'package:wallet_v2/components/cards/VisaCard.dart';
import 'package:wallet_v2/connection/Connections.dart';
import 'package:wallet_v2/constants/Constants.dart';

import '../components/appbar/LoginAppBar.dart';
import '../constants/Strings.dart';

class VisaInfo extends StatelessWidget {
  const VisaInfo({Key? key}) : super(key: key);

  final bool debugThis = false; // Para entrar en el modo depuración

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? visa = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String _visa = visa!['visaNumber'];
    if (DEBUGMODE && debugThis)
      print("VISA: ${_visa}");


    return FutureBuilder<Map<String, dynamic>>(
      future: getVisaData(_visa),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mientras se carga, mostramos un indicador de carga
          return CircularProgressIndicator();
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
                            Fluttertoast.showToast(msg: "Abrir cámara");
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(CUSTOM_PRIMARY),
                            backgroundColor: MaterialStateProperty.all<Color>(CUSTOM_SECONDARY_DARK),
                            minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 48)),
                          ),
                          child: const Text(pay_str,
                              style: TextStyle(color: CUSTOM_BLACK)
                          )
                      ),
                    ),
                    gapH30,
                    MovementCard(shopName: "La Marquesa Outflet", amount: "-25€", movementDate: "19/06/2023"),
                    MovementCard(shopName: "Compras Locas", amount: "+18€", movementDate: "26/04/2023"),
                    MovementCard(shopName: "Compras Locas", amount: "-66€", movementDate: "24/04/2023"),
                    MovementCard(shopName: "Taller Juan Molina", amount: "-701.69€", movementDate: "11/02/2023"),
                    MovementCard(shopName: "La Marquesa Outflet", amount: "-25€", movementDate: "19/06/2023"),
                    MovementCard(shopName: "Compras Locas", amount: "+18€", movementDate: "26/04/2023"),
                    MovementCard(shopName: "Compras Locas", amount: "-66€", movementDate: "24/04/2023"),
                    MovementCard(shopName: "Taller Juan Molina", amount: "-701.69€", movementDate: "11/02/2023"),
                    MovementCard(shopName: "La Marquesa Outflet", amount: "-25€", movementDate: "19/06/2023"),
                    MovementCard(shopName: "Compras Locas", amount: "+18€", movementDate: "26/04/2023"),
                    MovementCard(shopName: "Compras Locas", amount: "-66€", movementDate: "24/04/2023"),
                    MovementCard(shopName: "Taller Juan Molina", amount: "-701.69€", movementDate: "11/02/2023"),
                    MovementCard(shopName: "La Marquesa Outflet", amount: "-25€", movementDate: "19/06/2023"),
                    MovementCard(shopName: "Compras Locas", amount: "+18€", movementDate: "26/04/2023"),
                    MovementCard(shopName: "Compras Locas", amount: "-66€", movementDate: "24/04/2023"),
                    MovementCard(shopName: "Taller Juan Molina", amount: "-701.69€", movementDate: "11/02/2023"),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: VALID_GREEN,
                onPressed: () {
                  // Acción al presionar el botón
                  Fluttertoast.showToast(msg: "Aumentar saldo");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(Icons.add),
                    Icon(Icons.attach_money),
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
