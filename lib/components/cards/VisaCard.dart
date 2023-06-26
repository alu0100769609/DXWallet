import 'package:flutter/material.dart';

import '../../constants/Constants.dart';
import '../../constants/Strings.dart';

class VisaCard extends StatefulWidget
    implements PreferredSizeWidget {
  final int id;
  final String imagePath;
  final String name;
  final String number;
  final String amount;
  final Function? onTap;
  const VisaCard(
      {Key? key,
        required this.id,
        required this.imagePath,
        required this.name,
        required this.number,
        required this.amount,
        this.onTap,
      })
      : super(key: key);
  @override
  _VisaCard createState() => _VisaCard();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _VisaCard extends State<VisaCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => widget.onTap == null ? () {} : widget.onTap!(),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: 150,
                    child: Image.asset(widget.imagePath,
                        fit: BoxFit.cover),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      child: Text(widget.name,
                          style: TextStyle(fontSize: SUBTITLE_SIZE),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    gapH10,
                    SizedBox(
                      child: Text(_separarDigitos(widget.number),
                          style: TextStyle(fontSize: NORMAL_SIZE)
                      ),
                    ),
                    gapH10,
                    SizedBox(
                      child: Text(widget.amount,
                          style: TextStyle(fontSize: NORMAL_SIZE)
                      ),
                    ),
                  ],
                ),
              ]),
            )
          )
      ]),
    );
  }

  String _separarDigitos(String string) {
    // Verificar que el string tenga 16 dígitos
    if (string.length != 16) {
      return viewError_str;
    }
    // Separar los dígitos de 4 en 4 y agregar un espacio entre ellos
    String nuevoString = "";
    for (int i = 0; i < string.length; i += 4) {
      nuevoString += "${string.substring(i, i + 4)} ";
    }
    return nuevoString.trim();
  }
}
