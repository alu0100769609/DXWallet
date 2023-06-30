import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallet_v2/components/alertdialogs/DisconnectAlertDialog.dart';
import 'package:wallet_v2/constants/Constants.dart';

class CustomDrawer extends Drawer {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: CUSTOM_PRIMARY_DARK,
            ),
            child: Image.asset(SMALL_LOGO_ROUTE),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: CUSTOM_PRIMARY_DARK),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, "VisaList", (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: CUSTOM_PRIMARY_DARK),
            title: const Text('Perfil'),
            onTap: () {
              Fluttertoast.showToast(msg: "Perfil");
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications, color: CUSTOM_PRIMARY_DARK),
            title: const Text('Notificaciones'),
            onTap: () {
              Fluttertoast.showToast(msg: "Notificaciones");
            },
          ),
          const Divider(
            height: 10,
            thickness: 2,
            indent: 0,
            endIndent: 0,
            color: DISABLED_COLOR,
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: CUSTOM_PRIMARY_DARK),
            title: const Text('Ajustes'),
            onTap: () {
              Fluttertoast.showToast(msg: "Ajustes");
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_support, color: CUSTOM_PRIMARY_DARK),
            title: const Text('Soporte'),
            onTap: () {
              Fluttertoast.showToast(msg: "Soporte");
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: CUSTOM_PRIMARY_DARK),
            title: const Text('Sobre nosotros'),
            onTap: () {
              Fluttertoast.showToast(msg: "Sobre nosotros");
            },
          ),
          ListTile(
            leading: const Icon(Icons.power_settings_new_outlined, color: CUSTOM_PRIMARY_DARK),
            title: const Text('Desconectarse'),
            onTap: () async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DisconnectAlertDialog();
                }
              );
            },
          ),
        ]
      ),
    );
  }
}