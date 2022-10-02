import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper{
  static late SharedPreferences sharedPref;

  static Future<void> init() async{
    sharedPref = await SharedPreferences.getInstance();
  }

  static Future<bool> saveThemeMode({required bool isDark}) async{
      return await sharedPref.setBool('isDark', isDark);
  }

  static bool getThemeMode() {
    bool? isDark = sharedPref.getBool('isDark');
    if(isDark==null){
      return false;
    }else{
      return isDark;
    }
  }

  static saveMarkerData(List<String> list){
    sharedPref.setStringList('marker',list);
}

  static getMarkerData(String key){
    sharedPref.getStringList(key);
  }

}