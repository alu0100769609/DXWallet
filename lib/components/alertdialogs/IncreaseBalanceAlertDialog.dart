import 'package:flutter/material.dart';
import 'package:wallet_v2/connection/Connections.dart';
import 'package:wallet_v2/connection/DniStorage.dart';

import '../../constants/Strings.dart';
import 'BankConnectAlertDialog.dart';

class IncreaseBalanceAlertDialog extends AlertDialog {
  IncreaseBalanceAlertDialog({required this.visaNumber});

  final String visaNumber;
  TextEditingController _amountController = TextEditingController();
  late Future<Map> resp = Future<Map>.value({});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(increaseBalance_str),
      content: Container(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: _amountController, // Asignamos el controlador al campo de texto
              keyboardType: TextInputType.number, // Tipo de teclado numérico
              decoration: InputDecoration(labelText: inputAmount_str), // Etiqueta del campo de texto
            ),
            const Text(askIfAgree_str),
          ],
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text(cancel_str),
          onPressed: () {
            // Si se presiona que no se quiere salir
            Navigator.of(context).pop(); // Se cierra el alert dialog
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text(accept_str),
          onPressed: () async {
            String stringResponse = "";
            Map<dynamic, dynamic> responseMap = await increaseAmount(visaNumber, _amountController.text?? "0");

            if (responseMap != null) {
              if (responseMap["success"] == "0") {
                stringResponse = "Proceso cancelado.\n\n${responseMap["body"]}";
              }
              else {
                stringResponse = "Conectando con el banco... En breve tendrá su dinero disponible";
              }
            }
            return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BankConnectAlertDialog(message: stringResponse);
                }
            );
          },
        ),
      ],
    );
  }
}
