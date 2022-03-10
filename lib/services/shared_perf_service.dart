import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static Future<void> setData(List<dynamic> data) async {
    var prefs = await SharedPreferences.getInstance();
    String encodedMap = json.encode(data);
    prefs.setString('LISTDATA', encodedMap);
  }

  static Future<List<dynamic>> getData() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getString('LISTDATA') != null) {
      String encodedMap = prefs.getString('LISTDATA')!;
      List<dynamic> decodedMap = json.decode(encodedMap);
      return decodedMap;
    } else {
      return [];
    }
  }
}
