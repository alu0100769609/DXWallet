import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/Constants.dart';
import '../../constants/Strings.dart';
import 'DetailsCard.dart';

class MovementCard extends StatefulWidget
    implements PreferredSizeWidget {
  final String shopName;
  final String movementDate;
  final String amount;
  const MovementCard({
    Key? key,
    this.shopName = 'Shop Name', // Valor por defecto para shopName
    this.movementDate = 'Movement Date', // Valor por defecto para movementDate
    this.amount = 'Amount', // Valor por defecto para amount
  }) : super(key: key);

  @override
  _MovementCard createState() => _MovementCard();

  @override
  Size get preferredSize => throw UnimplementedError();
}

class _MovementCard extends State<MovementCard> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    showDetails = !showDetails;
                  });
                },
                child: Card(
                  color: CUSTOM_SECONDARY,
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            /// Lado izquierdo (imagen)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Nombre de la tienda
                                    Container(
                                      child: Text(widget.shopName,
                                        style: TextStyle(fontSize: SUBTITLE_SIZE),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    gapH10,

                                    /// Número de ticket
                                    SizedBox(
                                      child: Text(widget.movementDate,
                                          style: TextStyle(fontSize: NORMAL_SIZE)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// Lado derecho (Saldo)
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(widget.amount,
                                  style: TextStyle(
                                    fontSize: SUBTITLE_SIZE,
                                    fontWeight: FontWeight.bold,
                                    color: (widget.amount.toString().contains("-")) ? Colors.red : VALID_GREEN
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ]
                      ),
                      /// Submenú de descarga
                      (showDetails) ?
                      DetailsCard(
                        onTapDownload: () {
                          // Aquí debería descargar el ticket asociado
                          // TODO
                        Fluttertoast.showToast(msg: "Descargar ticket: ${widget.shopName}");
                        },
                        onTapView: () {
                          // Aquí debería mostrar el ticket asociado
                          // TODO
                          Fluttertoast.showToast(msg: "Ver online: ${widget.shopName}");
                        },
                      ) : EMPTY_BOX,
                    ],
                  ),
                )
            ),
          ]
      ),
    );
  }
}
