import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  late SharedPreferences _pref;
 
  // Return MyID
  Future<String?> getMyID() async {
    _pref = await SharedPreferences.getInstance();
    var id = _pref.getString('myID');
    return id;
  }

  //Remove Token and ID
  Future<void> removeMyID() async {
    _pref = await SharedPreferences.getInstance();
    _pref.remove('myID');
  }
}
