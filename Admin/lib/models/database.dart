import 'dart:async';
//import 'dart:ffi';

import 'package:admin/ConstSystemAD.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthData {
  bool Auth = false;
  String Msg = '';

  AuthData({
    required this.Auth,
    required this.Msg,
  });
}

Future<AuthData> getTokenAuth(String login, String password) async {
  //List listdate;
//  late var listdate;
//  var now1 = new DateTime.now();
////////////////////
  AuthData authResponse = new AuthData(
    Auth: false,
    Msg: 'Server no connected',
  );



  try {

    var resBody = {};
    resBody["Login"] = login;
    resBody["Password"] = password;

    final response = await http.post(
      Uri.http(ipLocalhost, '/auth/'),
      body: jsonEncode(resBody),
    ).timeout(const Duration(seconds: 3));
    if (response.statusCode == 200 || response.statusCode == 401) {
      var AuthDataServer = AuthServer.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      //print('Response server: '+AuthData32.Auth.toString() +' ' +  AuthData32.Msg.toString() );

      authResponse = new AuthData(
        Auth: AuthDataServer.Auth,
        Msg: AuthDataServer.Msg,
      );
///////////////////////////////////////

    } else {
      //print('Response server: nil 22');

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
  return authResponse;
}


class AuthServer {
  bool Auth = false;
  String Msg = '';

  AuthServer({
    required this.Auth,
    required this.Msg,
  });

  factory AuthServer.fromJson(Map<String, dynamic> parsedJson) {

    return new AuthServer(
      Auth: parsedJson['Auth'],
      Msg: parsedJson['Msg'],
    );
  }

}