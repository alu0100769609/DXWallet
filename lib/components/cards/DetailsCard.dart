import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/Constants.dart';
import '../../constants/Strings.dart';

class DetailsCard extends StatefulWidget
    implements PreferredSizeWidget {
  final Function? onTapDownload;
  final Function? onTapView;
  const DetailsCard({
    Key? key,
    this.onTapDownload,
    this.onTapView,
  }) : super(key: key);

  @override
  _DetailsCard createState() => _DetailsCard();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _DetailsCard extends State<DetailsCard> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Lado izquierdo (Descargar)
                Expanded(
                  child: GestureDetector(
                    onTap: ()                 {
                      setState(() {
                        showDetails = !showDetails;
                        if (widget.onTapDownload == null) {
                          Fluttertoast.showToast(msg: "Descargar");
                        } else {
                          widget.onTapDownload!();
                        }
                      });
                    },

                    child: Card(
                      elevation: 10,
                      color: CUSTOM_SECONDARY,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          /// Icono de descarga
                          Icon(Icons.save_alt),
                          /// Texto de descarga
                          Text(download_str,
                              style: TextStyle(fontSize: SUBTITLE_SIZE)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                /// Lado derecho (Ver online)
                Expanded(
                  child: GestureDetector(
                    onTap: ()                 {
                      setState(() {
                        showDetails = !showDetails;
                        if (widget.onTapView == null) {
                          Fluttertoast.showToast(msg: "Ver online");
                        } else {
                          widget.onTapView!();
                        }
                      });
                    },

                    child: Card(
                      elevation: 10,
                      color: CUSTOM_SECONDARY,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          /// Icono de ver online
                          Icon(Icons.visibility),
                          /// Texto de ver online
                          Text(onlineView_str,
                              style: TextStyle(fontSize: SUBTITLE_SIZE)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]
            ),
          ),
        ]
      ),
    );
  }
}
