

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  static save(String key, value) async {

    SharedPreferences prefs = await SharedPreferences.getInstance() ;
    if(value is String) {
      prefs.setString(key, value) ;

    } else if (value is bool) {

      prefs.setBool(key, value) ;
    }

  }
  static get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}