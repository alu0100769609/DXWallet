import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wallet_v2/constants/Constants.dart';

import '../../constants/Strings.dart';

class BankConnectAlertDialog extends StatefulWidget {
  final int duration = 5000;

  const BankConnectAlertDialog({super.key});

  @override
  _BankConnectAlertDialogState createState() => _BankConnectAlertDialogState();
}

class _BankConnectAlertDialogState extends State<BankConnectAlertDialog> {
  late Timer _timer;
  late AlertDialog _dialog;

  @override
  void initState() {
    super.initState();
    _dialog = AlertDialog(
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(bankConnect_str),
            Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(),
              ),
            ),
          ]
        ),
      ),
    );

    _timer = Timer(Duration(milliseconds: widget.duration), () {
      if (mounted) {
//        Navigator.of(context).pop(); // Cierra el alert
//        Navigator.of(context).pop(); // Cierra el "fondo oscurecido"
      // TODO: Hacer incremento de dinero en la cuenta
        Navigator.pushNamedAndRemoveUntil(context, "VisaList", (route) => false);
      }
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) => _dialog,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
