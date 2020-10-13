import 'package:flutter/material.dart';
import 'package:ad_book_2/ConstSystemAD.dart';
import 'package:ad_book_2/PostContact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataBaseData {
  int datalistcount;
  ContactServer database;
  bool blockrightarrow;

  DataBaseData({this.datalistcount, this.database, this.blockrightarrow});
}

class DataBase extends ChangeNotifier {
  var _databasedata = new DataBaseData(
      datalistcount: 0,
      database: new ContactServer(countlist: 0, contacts: null),
      blockrightarrow: false);

  DataBaseData get getContactList {
    return _databasedata;
  }

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

  Future<void> get getContacts async {
    var queryParameters = {
      'count': _databasedata.datalistcount.toString(),
      'limit': Limit_const.toString(),
    };

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
    // notifyListeners();
    return _databasedata;
    //notifyListeners();
  }

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
    var uri = Uri.http('192.168.88.234:8000', '/corporation/');

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
    return corporationlist;
    //notifyListeners();
  }
}
