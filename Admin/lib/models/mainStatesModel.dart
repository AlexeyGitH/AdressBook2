import 'package:flutter/foundation.dart';
class MainConstModel extends ChangeNotifier {

  String currentPage = 'MainPage';
  String currentIdContact = '';
  double InitScrollOffset = 0;

  void setCurrentPage(String currentPage) {
    this.currentPage = currentPage;
    notifyListeners();
  }

  void setCurrentIdContact(String currentId) {
    currentIdContact = currentId;
  }

  void setInitScrollOffset(double initScroll) {
    InitScrollOffset = initScroll;
  }


}
