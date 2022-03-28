import 'package:flutter/foundation.dart';
class MainConstModel extends ChangeNotifier {

  String currentPage = 'MainPage';
  String currentIdContact = '';

  void setCurrentPage(String currentPage) {
    this.currentPage = currentPage;
    notifyListeners();
  }

  void setCurrentIdContact(String currentId) {
    currentIdContact = currentId;
  }

}
