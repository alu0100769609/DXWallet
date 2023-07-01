import 'package:flutter/material.dart';
import 'package:wallet_v2/connection/DniStorage.dart';

import '../../constants/Strings.dart';
import 'BankConnectAlertDialog.dart';

class IncreaseBalanceAlertDialog extends AlertDialog {
  TextEditingController _amountController = TextEditingController();

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
            return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BankConnectAlertDialog();
                }
            );
          },
        ),
      ],
    );
  }
}
