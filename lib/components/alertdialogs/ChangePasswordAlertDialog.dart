import 'package:flutter/material.dart';
import 'package:wallet_v2/components/alertdialogs/ProcessAndBackAlertDialog.dart';
import 'package:wallet_v2/connection/Connections.dart';
import 'package:wallet_v2/connection/DniStorage.dart';

import '../../constants/Strings.dart';
import 'BankConnectAlertDialog.dart';

class ChangePasswordAlertDialog extends AlertDialog {

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController1 = TextEditingController();
  TextEditingController _newPasswordController2 = TextEditingController();
  late Future<Map> resp = Future<Map>.value({});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(changePassword_str),
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: _oldPasswordController, // Asignamos el controlador al campo de texto
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(labelText: oldPassword_str), // Etiqueta del campo de texto
            ),
            TextField(
              controller: _newPasswordController1, // Asignamos el controlador al campo de texto
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(labelText: newPassword1_str), // Etiqueta del campo de texto
            ),
            TextField(
              controller: _newPasswordController2, // Asignamos el controlador al campo de texto
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(labelText: newPassword2_str), // Etiqueta del campo de texto
            ),
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
            String? loadedDNI = await DniStorage.loadDNI();
            print("DATOS: ${_oldPasswordController.text}");
            Map<dynamic, dynamic> responseMap = await changePassword(loadedDNI!,
                _oldPasswordController.text, _newPasswordController1.text, _newPasswordController2.text);

            if (responseMap != null) {
              if (responseMap["success"] == "0") {
                stringResponse = "Proceso cancelado.\n\n${responseMap["body"]}";
              }
              else {
                stringResponse = "${responseMap["body"]}";
                DniStorage.removeDNI();
                Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
              }
            }
            return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ProcessAndBackAlertDialog(message: stringResponse);
                }
            );
          },
        ),
      ],
    );
  }
}
