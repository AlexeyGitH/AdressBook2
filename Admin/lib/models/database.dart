import 'dart:async';

import 'package:admin/ConstSystemAD.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future getTokenAuth() async {
  var uri = Uri.http(ipLocalhost, '/auth/');
  //List listdate;
  String listdate;
  var now1 = new DateTime.now();

  try {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      listdate = jsonDecode(utf8.decode(response.bodyBytes));
      //listdate.map((s) => s as String).toList();
      //setlistdata(listdate.map((s) => s as String).toList());

      print('Response server: '+listdate.toString());
    } else {
      //
    }

  }
  catch (e) {
    if (e is TimeoutException || e is http.ClientException)
    {
      //listdate = [];
      listdate = '';
      print('Error: $e');
    }
    else{
      print('Error general: $e');rethrow;}
  }
}