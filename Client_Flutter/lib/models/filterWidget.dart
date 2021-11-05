import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FiltersModelView extends ChangeNotifier {
  int filterView = 0;
  String textValue;
  List<String> listdata = [];

  FiltersModelView(this.textValue);

  void setFilterView(int _val) {
    //print('setFilterView provider: ' + _val.toString());
    filterView = _val;
    notifyListeners();
  }

  void setFilterViewonlyset(int _val) {
    filterView = _val;
  }

  void setFilterValue(String _val) {
   // print('setFilterValue provider: ' + _val.toString());
    textValue = _val;
    notifyListeners();
  }

  void setFilterValueonlyset(String _val) {
    textValue = _val;
  }

  void  setlistdataonlyset(List<String> _listdata) {
    listdata = _listdata;
    //print('list length set provider: ' + listdata.length.toString());
  }

}