import 'package:shared_preferences/shared_preferences.dart';

class BaseViewModel {
  SharedPreferences? sharedPref;

  final String argLoggedIn = 'ARG_LOGGED_IN';

  Future getInstances() async {
    sharedPref = await SharedPreferences.getInstance();
  }
}
