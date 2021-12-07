import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ad_book_2/ConstSystemAD.dart';

class DataBaseFilter {
  String controllerFIO;
  String controllerCorporation;
  String controllerDepartament;
  String controllerPhone;
  String controllerTypePhone;

  DataBaseFilter({
    required this.controllerFIO,
    required this.controllerCorporation,
    required this.controllerDepartament,
    required this.controllerPhone,
    required this.controllerTypePhone
  });
}

class FiltersModel extends ChangeNotifier {
    int datalistcount = 0;
    int viewResume = 0;

    DataBaseFilter filters = new DataBaseFilter(
      controllerFIO: '',
      controllerCorporation: '',
      controllerDepartament: '',
      controllerTypePhone: 'Все',
      controllerPhone: '',
    );


    void setFilters(String fio, String corporation, String departament) {
      //filters.controllerFIO = fio;
      //filters.controllerCorporation = corporation;
      //filters.controllerDepartament = departament;
      //notifyListeners();
    }

    void setFilterFio(String fio) {
      filters.controllerFIO = fio;
    }

    void setFilterCorp(String corporation) {
      //print('Set state corporation $corporation');
      filters.controllerCorporation = corporation;
      //setFilternotifyListeners();
    }

    void setFilterDepart(String departament) {
      //print('Set state corporation $corporation');
      filters.controllerDepartament = departament;
      //setFilternotifyListeners();
    }

    void setFilterPhone({String? typePhone, String? phone,}) {
      if(typePhone != null){filters.controllerTypePhone = typePhone;};
      if(phone != null){filters.controllerPhone = phone;};
    }


    void setviewResume(int val) {
      viewResume = val;
      notifyListeners();
    }

    void setStartContactsRange() {
      datalistcount = 0;
    }

    void contactsChangeRange(int kindRange, int total_count) {
      if (kindRange == 0) {
        if (datalistcount - Limit_const < 0) {
          datalistcount = 0;
        } else {
          datalistcount = datalistcount - Limit_const;
        }
        notifyListeners();
      }
      else {
        if (datalistcount + Limit_const >=
            total_count) {
        } else {
          datalistcount = datalistcount + Limit_const;
        }
        notifyListeners();

      }
    }

  }




