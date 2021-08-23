import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class DataBaseFilter {
  String controllerFIO;
  String controllerCorporation;
  /*
  String controllerDepartament;
  String controllerPhone;
  String controllerTypePhone;
*/
  DataBaseFilter({
    this.controllerFIO,
    this.controllerCorporation,
    /*
    this.controllerDepartament,
    this.controllerPhone,
    this.controllerTypePhone*/
  });
}

class FiltersModel extends ChangeNotifier {

    DataBaseFilter filters = new DataBaseFilter(
controllerFIO: '', controllerCorporation: '');


    void setFilters(String fio, String corporation) {
      //filters.controllerFIO.text = fio;
      filters.controllerFIO = fio;
      filters.controllerCorporation = corporation;
      notifyListeners();
    }


  }



