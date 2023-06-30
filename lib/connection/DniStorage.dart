import 'package:shared_preferences/shared_preferences.dart';

class DniStorage {
  static const String _kDniKey = 'dni';

  // Función para guardar el valor del DNI en SharedPreferences
  static Future<void> saveDNI(String dni) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kDniKey, dni);
  }

  // Función para cargar el valor del DNI desde SharedPreferences
  static Future<String?> loadDNI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kDniKey);
  }

  // Función para eliminar el valor del DNI en SharedPreferences
  static Future<void> removeDNI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kDniKey);
  }
}
