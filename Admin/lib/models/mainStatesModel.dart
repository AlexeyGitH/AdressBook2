import 'package:flutter/foundation.dart';
class MainConstModel extends ChangeNotifier {
  bool authenticated = false;
  String viewResume = 'Auth';

  String tokenAuth = '';

  void setAuthenticated(bool authenticated) {
    this.authenticated = authenticated;
    notifyListeners();
  }

  void setViewResume(String viewResume) {
    this.viewResume = viewResume;
    notifyListeners();
  }

  void setTokenAuth(String tokenAuth) {
    this.tokenAuth = tokenAuth;
    notifyListeners();
  }


}
