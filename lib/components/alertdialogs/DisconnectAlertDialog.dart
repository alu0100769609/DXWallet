import 'package:flutter/material.dart';
import 'package:wallet_v2/connection/DniStorage.dart';

import '../../constants/Strings.dart';

class DisconnectAlertDialog extends AlertDialog {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(logout_str),
      content: const Text(askIfLogout_str),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('No'),
          onPressed: () {
            // Si se presiona que no se quiere salir
            Navigator.of(context).pop(); // Se cierra el alert dialog
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Sí'),
          onPressed: () {
            // Si se presiona que se quiere salir borramos la pila y vamos a login
            DniStorage.removeDNI();
            Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
//            SystemNavigator.pop(); // Cerramos la aplicación
          },
        ),
      ],
    );
  }
}