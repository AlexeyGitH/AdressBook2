import 'dart:async';

import 'package:ad_book_2/models/filterWidget.dart';
import 'package:flutter/material.dart';
import 'package:ad_book_2/ConstSystemAD.dart';
import 'PostContact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ad_book_2/models/filters.dart';

String ipLocalhost = "192.168.34.86:8000";
//String ipLocalhost = "192.168.88.253:8000";
//String ipLocalhost = "localhost:8000";

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

  }
  catch (e) {
    if (e is TimeoutException || e is http.ClientException)
      {
        listdate = [];
        settypeV(4);
        print('Error: $e');
      }
    else{
    print('Error general: $e');rethrow;}
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

  } catch (e) {
    if (e is TimeoutException || e is http.ClientException)
    {
      listdate = [];
      settypeV(4);
      print('Error: $e');
    }
    else{
      print('Error general: $e');rethrow;}
  }

  //print('CONTACTTS list server DONE');
}



class DataBaseData {
  int datalistcount = 0;
  ContactServer database = new ContactServer(countlist: 0, contacts: new List<ContactItem>.empty());
  bool blockrightarrow = false;
  int viewResume = 0;
  //DataBaseFilter filters;

  DataBaseData({
    required this.datalistcount,
    required this.database,
    required this.blockrightarrow,
    required this.viewResume,
    // required this.filters,
  });
}

Future<DataBaseData> getContactList(FiltersModel valFilter) async {


  DataBaseData dataBaseData = new DataBaseData(
    datalistcount: 0,
    database: new ContactServer(countlist: 0, contacts: new List<ContactItem>.empty()),
    blockrightarrow: false,
    viewResume: 0,

    /*
    filters: new DataBaseFilter(controllerFIO: "",
      controllerCorporation: "",
      controllerDepartament: "",
      controllerPhone: "",
      controllerTypePhone: "",
    ),*/
  );

  try {

    var resBody = {};
    resBody["Count"] = valFilter.datalistcount.toString();
    resBody["Limit"] = Limit_const.toString();
    resBody["FIO"] = valFilter.filters.controllerFIO;
    resBody["Corporation"] = "";
    resBody["Department"] = "";
    resBody["Phone"] = "";
    resBody["TypePhone"] = "";

    final response = await http.post(
      Uri.http(ipLocalhost, '/contacts_2/'),
      /*headers: {"Access-Control-Allow-Origin": "*"},*/
      body: jsonEncode(resBody),
    ).timeout(const Duration(seconds: 3));
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
          blockrightarrow: _blockrightarrow,
          viewResume: 1,
       );
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load contacts');
      //print('Error data');
      dataBaseData = new DataBaseData(
          datalistcount: 0,
          database: new ContactServer(countlist: 0, contacts: new List<ContactItem>.empty()),
          blockrightarrow: false,
          viewResume: 0,
      );
    }

  }

 on TimeoutException catch (e) {
   print('Timeout:');
   dataBaseData = new DataBaseData(
       datalistcount: 0,
       //database: new ContactServer(countlist: 0, contacts: []),
       database: new ContactServer(countlist: 0, contacts: new List<ContactItem>.empty()),
       blockrightarrow: false,
       viewResume: 0,
       );
} on Error catch (e) {
    print('Caught error: $e');
    dataBaseData = new DataBaseData(
        datalistcount: 0,
        database: new ContactServer(countlist: 0, contacts: new List<ContactItem>.empty()),
        blockrightarrow: false,
        viewResume: 0,
        );
}
  on http.ClientException catch (e) {
    dataBaseData = new DataBaseData(
      datalistcount: 0,
      database: new ContactServer(countlist: 0, contacts: new List<ContactItem>.empty()),
      blockrightarrow: false,
      viewResume: 0,
    );
  }
  catch (e) {
    print('Error general: $e');
    rethrow;
  }

  return dataBaseData;
}
