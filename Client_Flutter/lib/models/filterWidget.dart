import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FiltersModelView extends ChangeNotifier {
  int filterView = 0;
  String textValue = '';
  List listdata = [];

  void setFilterView(int _val) {
    filterView = _val;
    notifyListeners();
  }

  void setFilterValue(String _val) {
    textValue = _val;
    notifyListeners();
  }

  void setFilterValueonlyset(String _val) {
    textValue = _val;
  }

  void setListdata(Future<List> loaddata) {
    late var f;
    print('start');
    f = loaddata;
  }

}