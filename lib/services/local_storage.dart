import 'package:abejita/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _obscureModeKey = "felo";
  

  static SharedPreferences? _preferencesInstance;

  static SharedPreferences get preferences {
    if (_preferencesInstance == null) {
      throw ("Invoque LocalStorage.init() para iniciar el almacenamiento local antes de acceder a las preferencias.");
    }
    return _preferencesInstance!;
  }

  static Future<void> init() async {
    _preferencesInstance = await SharedPreferences.getInstance();
  }

  static Future<bool> clear() async {
    return preferences.clear();
  }

  static set isObscure(bool value) => preferences.setBool(_obscureModeKey, value);
  static bool get isObscure => preferences.getBool(_obscureModeKey) ?? false;
}
