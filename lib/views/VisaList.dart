import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallet_v2/connection/DniStorage.dart';

import '../components/cards/VisaCard.dart';
import '../components/appbar/LoginAppBar.dart';
import '../components/drawers/CustomDrawer.dart';
import '../connection/Connections.dart';
import '/constants/Constants.dart';

class VisaList extends StatefulWidget {
  const VisaList({Key? key}) : super(key: key);

  @override
  _VisaListState createState() => _VisaListState();
}

class _VisaListState extends State<VisaList> {
  final bool debugThis = false; // Para entrar en el modo depuración
  late Future<Map> listOfVisas = Future<Map>.value({});

  @override
  void initState() {
    super.initState();
    loadVisaList();
  }

  void loadVisaList() async {
    String? loadedDNI = await DniStorage.loadDNI();
    setState(() {
      listOfVisas = getVisaList(loadedDNI!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginAppBar(),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: FutureBuilder<Map>(
          future: listOfVisas,
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Errores: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Text('No data available');
            }else { // Retorna datos
              if (DEBUGMODE && debugThis)
                print("SNAPSHOT DATA SUCCESS: ${snapshot.data!["success"]}");
              if (snapshot.data!["success"] == "0") {
                return Column(
                  children: [
                    gapH30,
                    Center(
                      child: Text(snapshot.data!["body"],
                        style: const TextStyle(
                            fontSize: SUBTITLE_SIZE,
                        color: DISABLED_COLOR),
                      ),
                    ),
                    gapH30,
                    const Icon(Icons.credit_card_off_rounded,
                      size: TITLE_SIZE * 4,
                      color: DISABLED_COLOR,
                    ),
                  ],
                );
              }
              else {
                List<dynamic> visaList = snapshot.data!["body"];
                int cardCount = visaList.length;
                return Column(
                  children: List.generate(cardCount, (index) {
                    Map<dynamic, dynamic> visaData = visaList[index];
                    return VisaCard(
                      imagePath: BLUE_CREDIT_CARD,
                      name: visaData["nombre"],
                      number: visaData["numero_tarjeta"],
                      amount:
                          "${visaData["saldo"].toString()} ${visaData["moneda"]}",
                      onTap: () {
                        Navigator.pushNamed(context, "VisaInfo", arguments: {"visaNumber" : visaData["numero_tarjeta"]});
//                        Fluttertoast.showToast(msg: "Tarjeta ${index + 1}");
                      },
                    );
                  }),
                );
              }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CUSTOM_PRIMARY_DARK,
        onPressed: () {
          // Acción al presionar el botón
          Navigator.pushNamed(context, "AddVisa");
        },
        child: const Icon(Icons.add_card_rounded),
      ),
    );
  }
}
