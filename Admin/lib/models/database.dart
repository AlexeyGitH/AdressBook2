import 'dart:async';

import 'package:admin/ConstSystemAD.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future getTokenAuth(String login, String password) async {
  //List listdate;
  late var listdate;
  var now1 = new DateTime.now();
////////////////////

  try {

    var resBody = {};
    resBody["Login"] = login;
    resBody["Password"] = password;

    final response = await http.post(
      Uri.http(ipLocalhost, '/auth/'),
      body: jsonEncode(resBody),
    ).timeout(const Duration(seconds: 3));
    if (response.statusCode == 200) {

      listdate = jsonDecode(utf8.decode(response.bodyBytes));
      //listdate.map((s) => s as String).toList();
      //setlistdata(listdate.map((s) => s as String).toList());

      print('Response server: '+listdate.toString());
///////////////////////////////////////

    } else {
      print('Response server: nil 22');

    }

  }

  on TimeoutException catch (e) {
    print('Timeout:');
    rethrow;
    } on Error catch (e) {
    print('Caught error: $e');
    rethrow;

  }
  on http.ClientException catch (e) {
    print('Caught error: $e');
    rethrow;

  }
  catch (e) {
    print('Error general: $e');
    rethrow;
  }

}