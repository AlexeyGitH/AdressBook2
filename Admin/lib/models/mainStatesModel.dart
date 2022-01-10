import 'package:flutter/foundation.dart';
class MainConstModel extends ChangeNotifier {
  bool authenticated = false;
  String viewResume = 'Auth';

  void setAuthenticated(bool authenticated) {
    this.authenticated = authenticated;
    notifyListeners();
  }

  void setViewResume(String viewResume) {
    this.viewResume = viewResume;
    notifyListeners();
  }

}
