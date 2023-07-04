import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wallet_v2/constants/Constants.dart';

import '../../constants/Strings.dart';

class ProcessAndBackAlertDialog extends StatefulWidget {
  final int duration = 2000;
  final String message;

  const ProcessAndBackAlertDialog({Key? key, required this.message}) : super(key: key);

  @override
  _ProcessAndBackAlertDialogState createState() => _ProcessAndBackAlertDialogState();
}

class _ProcessAndBackAlertDialogState extends State<ProcessAndBackAlertDialog> {
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
            children: [
              Text(widget.message, textAlign: TextAlign.center),
//            Text(bankConnect_str),
              const Center(
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
        Navigator.pop(context);
        Navigator.pop(context);
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
