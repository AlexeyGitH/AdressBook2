import 'package:flutter/foundation.dart';
class MainConstModel extends ChangeNotifier {

  String currentPage = 'MainPage';

  void setCurrentPage(String currentPage) {
    this.currentPage = currentPage;
    notifyListeners();
  }
}
