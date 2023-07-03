import 'package:flutter/material.dart';

import '../../constants/Strings.dart';

class ImageAlertDialog extends AlertDialog {
  final String imageURL;

  const ImageAlertDialog({Key? key, required this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Vista previa"),
      content: Image.asset(imageURL,
          fit: BoxFit.cover),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Cerrar'),
          onPressed: () {
            // Si se presiona que no se quiere salir
            Navigator.of(context).pop(); // Se cierra el alert dialog
          },
        ),
      ],
    );
  }
}