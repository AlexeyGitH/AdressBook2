import 'dart:async';
//import 'dart:ffi';

import 'package:admin/ConstSystemAD.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthData {
  bool Auth = false;
  String Msg = "";
  String Token = "";

  AuthData({
    required this.Auth,
    required this.Msg,
    required this.Token,
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
    Token: "",
  );

  final _storage = const FlutterSecureStorage();
  Future<void> _writeValStorage(String _token) async {
    await _storage.write(key: session_token_name, value: _token);
  }

  Future<void> _deleteValStorage() async {
    await _storage.delete(key: session_token_name);
  }


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
        Token: AuthDataServer.Token,
      );
      if (response.statusCode == 200) {
        _writeValStorage(AuthDataServer.Token);
      } else {
        _deleteValStorage();
      }
///////////////////////////////////////

    } else {
      //print('Response server: nil 22');
      _deleteValStorage();
    }

  }

  on TimeoutException catch (e) {
    print('Timeout:');
    _deleteValStorage();
    rethrow;
    } on Error catch (e) {
    print('Caught error: $e');
    _deleteValStorage();
    rethrow;

  }
  on http.ClientException catch (e) {
    print('Caught error: $e');
    _deleteValStorage();
    rethrow;

  }
  catch (e) {
    print('Error general: $e');
    _deleteValStorage();
    rethrow;
  }
  return authResponse;
}


class AuthServer {
  bool Auth = false;
  String Msg = "";
  String Token = "";

  AuthServer({
    required this.Auth,
    required this.Msg,
    required this.Token,
  });

  factory AuthServer.fromJson(Map<String, dynamic> parsedJson) {

    return new AuthServer(
      Auth: parsedJson['Auth'],
      Msg: parsedJson['Msg'],
      Token: parsedJson['Token'],
    );
  }

}


Future<bool> checkTokenAuth(String token) async {

  bool result = false;

  try {
    var resBody = {};
    resBody["Token"] = token;

    final response = await http.post(
      Uri.http(ipLocalhost, '/checkToken/'),
      body: jsonEncode(resBody),);
    if (response.statusCode == 200) {
      result = true;
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
  return result;
}
