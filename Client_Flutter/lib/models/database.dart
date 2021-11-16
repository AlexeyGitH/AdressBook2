import 'dart:async';

import 'package:ad_book_2/models/filterWidget.dart';
import 'package:flutter/material.dart';
import 'package:ad_book_2/ConstSystemAD.dart';
import 'PostContact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ad_book_2/models/filters.dart';

//String ipLocalhost = "172.16.40.14:8000";
//String ipLocalhost = "192.168.88.252:8000";
//String ipLocalhost = "192.168.0.105:8000";
String ipLocalhost = "192.168.88.253:8000";

/*
class CorporationList {
  Future<List> get getCorporation async {
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
  Future<List> get getDepartment async {
    List departmentlist;
    //print('queryParameters $queryParameters');
    var uri = Uri.http(ipLocalhost, '/department/');

    final response = await http.get(uri).timeout(const Duration(seconds: 5));

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
*/

Future getCorporationList(void settypeV(int _val), void setlistdata(List<String> _list)) async {
  var uri = Uri.http(ipLocalhost, '/corporation/');
  List listdate;
  var now1 = new DateTime.now();

  try {
    final response = await http.get(uri).timeout(const Duration(seconds: 3));

    if (response.statusCode == 200) {
      var now2 = new DateTime.now();
      // If the server did return a 200 OK response,
      // then parse the JSON.
      if (now2.millisecondsSinceEpoch - now1.millisecondsSinceEpoch < 500){
        await Future.delayed(Duration(milliseconds: 500));
      }
      listdate = jsonDecode(utf8.decode(response.bodyBytes));
      //listdate.map((s) => s as String).toList();
      setlistdata(listdate.map((s) => s as String).toList());
      settypeV(3);
      //print('list server'+listdate.length.toString());
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load contacts');
      listdate = [];
      settypeV(4);
      //print('CONTACTTS list server/ERROR-3');
    }

  } on TimeoutException catch (e) {
    listdate = [];
    settypeV(4);
    print('Timeout');
  } on Error catch (e) {
    listdate = [];
    settypeV(4);
    print('Error: $e');
  }

  //print('CONTACTTS list server DONE');
}

Future getDepartmentList(void settypeV(int _val), void setlistdata(List<String> _list)) async {

  var uri = Uri.http(ipLocalhost, '/department/');
  List listdate;
  var now1 = new DateTime.now();

  try {
    final response = await http.get(uri).timeout(const Duration(seconds: 3));

    if (response.statusCode == 200) {
      var now2 = new DateTime.now();
      // If the server did return a 200 OK response,
      // then parse the JSON.
      if (now2.millisecondsSinceEpoch - now1.millisecondsSinceEpoch < 500){
        await Future.delayed(Duration(milliseconds: 500));
      }
      listdate = jsonDecode(utf8.decode(response.bodyBytes));
      //listdate.map((s) => s as String).toList();
      setlistdata(listdate.map((s) => s as String).toList());
      settypeV(3);
      //print('list server'+listdate.length.toString());
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load contacts');
      listdate = [];
      settypeV(4);
      //print('CONTACTTS list server/ERROR-3');
    }

  } on TimeoutException catch (e) {
    listdate = [];
    settypeV(4);
    print('Timeout');
  } on Error catch (e) {
    listdate = [];
    settypeV(4);
    print('Error: $e');
  }

  //print('CONTACTTS list server DONE');
}



class DataBaseData {
  int datalistcount;
  ContactServer database;
  bool blockrightarrow;
  //DataBaseFilter filters;

  DataBaseData({
    required this.datalistcount,
    required this.database,
    required this.blockrightarrow,
    // required this.filters,
  });
}

Future<DataBaseData> getContactList() async {


  DataBaseData dataBaseData = new DataBaseData(
    datalistcount: 0,
    database: new ContactServer(countlist: 0, contacts: new List<ContactItem>.empty()),
    blockrightarrow: false,
    /*
    filters: new DataBaseFilter(controllerFIO: "",
      controllerCorporation: "",
      controllerDepartament: "",
      controllerPhone: "",
      controllerTypePhone: "",
    ),*/
  );

  try {
    final response = await http.post(
      Uri.http(ipLocalhost, '/contacts_2/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Count': 0.toString(),
        'Limit': Limit_const.toString(),
        'FIO': '',
        'Corporation': '',
        'Department': '',
        'Phone': '',
        'TypePhone': '',
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
          database: new ContactServer(countlist: 0, contacts: new List<ContactItem>.empty()),
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

  return dataBaseData;
}
