import 'package:flutter/material.dart';
import 'package:ad_book_2/ConstSystemAD.dart';
import 'PostContact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//String ipLocalhost = "172.16.40.14:8000";
//String ipLocalhost = "192.168.88.252:8000";
String ipLocalhost = "192.168.0.105:8000";


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