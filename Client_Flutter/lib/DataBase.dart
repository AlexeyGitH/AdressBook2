//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'ConstSystemAD.dart';
import 'PostContact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//String ipLocalhost = "172.16.40.14:8000";
String ipLocalhost = "192.168.88.254:8000";

class DataBaseData {
  int datalistcount;
  ContactServer database;
  bool blockrightarrow;
  ParamFilter filters;

  DataBaseData({
    this.datalistcount,
    this.database,
    this.blockrightarrow,
    this.filters,
  });
}

class DataBaseFilter {
  String controllerFIO;
  String controllerCorporation;
  String controllerDepartament;
  String controllerPhone;
  String controllerTypePhone;

  DataBaseFilter({
    this.controllerFIO,
    this.controllerCorporation,
    this.controllerDepartament,
    this.controllerPhone,
    this.controllerTypePhone
  });
}

class DataBase extends ChangeNotifier {

  DataBaseFilter dataBaseFilter = new DataBaseFilter(controllerFIO: "",
    controllerCorporation: "",
    controllerDepartament: "",
    controllerPhone: "",
    controllerTypePhone: "",
  );

  DataBaseData dataBaseData = new DataBaseData(
    datalistcount: 0,
    database: new ContactServer(countlist: 0, contacts: null),
    blockrightarrow: false,
    filters: new ParamFilter(fio: ""),
  );

  /*
  DataBase({
    this.dataBaseFilter,
    this.dataBaseData,
  });
*/

  /*
  Future<String> fetchSomething() async {
    return Future.delayed(Duration(seconds: 3), () {
      //this.f = 'future';
      //print('future');
      //notifyListeners();
      return '1234 North Commercial Ave.';
    });
  }
*/

  void setFilters(String FIO) {
    this.dataBaseFilter.controllerFIO = FIO;
  }

  void contactsForward() {
    if (this.dataBaseData.datalistcount + Limit_const >=
        this.dataBaseData.database.countlist) {
    } else {
      this.dataBaseData.datalistcount = this.dataBaseData.datalistcount + Limit_const;
    }

    this.dataBaseData.blockrightarrow = false;
    if (this.dataBaseData.datalistcount + Limit_const >=
        this.dataBaseData.database.countlist) {
      this.dataBaseData.blockrightarrow = true;
    }
    notifyListeners();
  }

  void contactsBack() {
    if (this.dataBaseData.datalistcount - Limit_const < 0) {
      this.dataBaseData.datalistcount = 0;
    } else {
      this.dataBaseData.datalistcount = this.dataBaseData.datalistcount - Limit_const;
    }
    this.dataBaseData.blockrightarrow = false;
    notifyListeners();
  }

  Future<DataBaseData> getContactList() async {
 /*   var queryParameters = {
      'count': dataBaseData.datalistcount.toString(),
      'limit': Limit_const.toString(),
    };
*/
    //print('queryParameters $queryParameters');
//    var uri = Uri.http(ipLocalhost, '/contacts_2/', queryParameters);
//    final response = await http.get(uri);
//

    try {
      final response = await http.post(
        Uri.http(ipLocalhost, '/contacts_2/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'Count': dataBaseData.datalistcount.toString(),
          'Limit': Limit_const.toString(),
          'FIO': dataBaseFilter.controllerFIO,
          'Corporation': dataBaseFilter.controllerCorporation,
          'Department': dataBaseFilter.controllerDepartament,
          'Phone': dataBaseFilter.controllerPhone,
          'TypePhone': dataBaseFilter.controllerTypePhone,
        }),
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        var _database =
        ContactServer.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        bool _blockrightarrow = false;

        if (dataBaseData.datalistcount + Limit_const >= _database.countlist) {
          _blockrightarrow = true;
        }

        dataBaseData = new DataBaseData(
            datalistcount: dataBaseData.datalistcount,
            database: _database,
            blockrightarrow: _blockrightarrow);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        //throw Exception('Failed to load contacts');
        dataBaseData = new DataBaseData(
            datalistcount: 0,
            database: new ContactServer(countlist: 0, contacts: null),
            blockrightarrow: false);
      }

    }
    catch (err)
    {
      print('Caught error: $err');
      dataBaseData = new DataBaseData(
          datalistcount: 0,
          database: new ContactServer(countlist: 0, contacts: []),
          blockrightarrow: false);

    }

    // notifyListeners();
    print('datalistcount' + this.dataBaseData.datalistcount.toString());
    return dataBaseData;
    //notifyListeners();
  }


/*
  void getContactsAdd() {
    //print('add1 ${_databasedata.datalistcount}');

    if (_databasedata.datalistcount + Limit_const >=
        _databasedata.database.countlist) {
    } else {
      _databasedata.datalistcount = _databasedata.datalistcount + Limit_const;
    }

    _databasedata.blockrightarrow = false;
    if (_databasedata.datalistcount + Limit_const >=
        _databasedata.database.countlist) {
      _databasedata.blockrightarrow = true;
    }

    //print('add2 ${_databasedata.datalistcount}');

    notifyListeners();

    //print('count ${_databasedata.datalistcount}');
    /*
    var queryParameters = {
      'count': _databasedata.datalistcount.toString(),
      'limit': Limit_const.toString(),
    };*/
    //getContacts(queryParameters);
  }
*/

  /*
  void getContactsMinus() {
    //print('minus1 ${_databasedata.datalistcount}');
    if (_databasedata.datalistcount - Limit_const < 0) {
      _databasedata.datalistcount = 0;
    } else {
      _databasedata.datalistcount = _databasedata.datalistcount - Limit_const;
    }
    //print('minus2 ${_databasedata.datalistcount}');
    _databasedata.blockrightarrow = false;
    notifyListeners();

/*
    var queryParameters = {
      'count': _databasedata.datalistcount.toString(),
      'limit': Limit_const.toString(),
    };*/
    //getContacts(queryParameters);
  }
*/


/*
  void getContactsInit() {
    _databasedata.datalistcount = 0;
    var queryParameters = {
      'count': _databasedata.datalistcount.toString(),
      'limit': Limit_const.toString(),
    };
    //getContacts(queryParameters);
  }
*/

  /*

  Future<void> getContacts(
      String _controllerFIO,
      String _controllerCorporation,
      String _controllerDepartament,
      String _controllerPhone,
      String _controllerTypePhone) async {
    var queryParameters = {
      'count': _databasedata.datalistcount.toString(),
      'limit': Limit_const.toString(),
    };

    //print('queryParameters $queryParameters');
//    var uri = Uri.http(ipLocalhost, '/contacts_2/', queryParameters);
//    final response = await http.get(uri);
//
    final response = await http.post(
      Uri.http(ipLocalhost, '/contacts_2/', queryParameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'FIO': _controllerFIO,
        'Corporation': _controllerCorporation,
        'Departament': _controllerDepartament,
        'Phone': _controllerPhone,
        'TypePhone': _controllerTypePhone,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var _database =
          ContactServer.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      bool _blockrightarrow = false;

      if (_databasedata.datalistcount + Limit_const >= _database.countlist) {
        _blockrightarrow = true;
      }

      _databasedata = new DataBaseData(
          datalistcount: _databasedata.datalistcount,
          database: _database,
          blockrightarrow: _blockrightarrow);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load contacts');
      _databasedata = new DataBaseData(
          datalistcount: 0,
          database: new ContactServer(countlist: 0, contacts: null),
          blockrightarrow: false);
    }
    // notifyListeners();
    return _databasedata;
    //notifyListeners();
  }
*/


/*

  void getContacts(queryParameters) async {
    //print('queryParameters $queryParameters');
    var uri = Uri.http('192.168.88.234:8000', '/contacts_2/', queryParameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var _database =
          ContactServer.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      bool _blockrightarrow = false;

      if (_databasedata.datalistcount + Limit_const >= _database.countlist) {
        _blockrightarrow = true;
      }

      _databasedata = new DataBaseData(
          datalistcount: _databasedata.datalistcount,
          database: _database,
          blockrightarrow: _blockrightarrow);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load contacts');
      _databasedata = new DataBaseData(
          datalistcount: 0,
          database: new ContactServer(countlist: 0, contacts: null),
          blockrightarrow: false);
    }
    notifyListeners();
  }

  */
}

class CorporationList {
  Future<void> get getCorporation async {
    List corporationlist;
    //print('queryParameters $queryParameters');
    var uri = Uri.http(ipLocalhost, '/corporation/');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      corporationlist = jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load contacts');
      corporationlist = [];
    }
    // notifyListeners();
    return corporationlist.map((s) => s as String).toList();
    //notifyListeners();
  }
}

class DepartmentList {
  Future<void> get getDepartment async {
    List departmentlist;
    //print('queryParameters $queryParameters');
    var uri = Uri.http(ipLocalhost, '/department/');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      departmentlist = jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load contacts');
      departmentlist = [];
    }
    // notifyListeners();
    return departmentlist.map((s) => s as String).toList();
    //notifyListeners();
  }
}

/*
class SearchContacts {
  Future<List> postContacts(
      String _controllerFIO,
      String _controllerCorporation,
      String _controllerDepartament,
      String _controllerPhone,
      String _controllerTypePhone) async {
    List departmentlist;

    if (_controllerTypePhone == "Все") {
      _controllerTypePhone = "all";
    }
    if (_controllerTypePhone == "Доб") {
      _controllerTypePhone = "phone_additional";
    }
    if (_controllerTypePhone == "Раб") {
      _controllerTypePhone = "phone_work";
    }
    if (_controllerTypePhone == "Моб") {
      _controllerTypePhone = "phone_mobile";
    }

    final response = await http.post(
      //Uri.http(ipLocalhost, '/searchcontacts/'),
      Uri.http(ipLocalhost, '/contacts_2/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'FIO': _controllerFIO,
        'Corporation': _controllerCorporation,
        'Departament': _controllerDepartament,
        'Phone': _controllerPhone,
        'TypePhone': _controllerTypePhone,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //departmentlist = jsonDecode(utf8.decode(response.bodyBytes));
      departmentlist = [];
      //print('fffff-11-00');
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      departmentlist = [];
      //print('fffff-22-00');
    }
    print('syatus ' + response.statusCode.toString());
    return departmentlist.map((s) => s as String).toList();
  }
}
*/
