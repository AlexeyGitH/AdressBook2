import 'dart:async';
//import 'dart:ffi';

import 'package:admin/ConstSystemAD.dart';
import 'package:flutter/material.dart';
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


class ContactItem {
  final int id;
  final String status;
  final String firstname;
  final String middlename;
  final String lastname;
  final String photo;
  final String department;
  final String corporation;
  final String position;
  final String workphone;
  final String mobilephone;
  final String birthdate;
  final String mail;
  final String additionalphone;

  ContactItem(
      { required this.id,
        required this.status,
        required this.firstname,
        required this.middlename,
        required this.lastname,
        required this.photo,
        required this.department,
        required this.corporation,
        required this.position,
        required this.workphone,
        required this.mobilephone,
        required this.birthdate,
        required this.mail,
        required this.additionalphone});

  factory ContactItem.fromJson(Map<String, dynamic> parsedJson) {
    return new ContactItem(
      id: parsedJson['Id'],
      status: parsedJson['Status'],
      firstname: parsedJson['FirstName'],
      middlename: parsedJson['MiddleName'],
      lastname: parsedJson['LastName'],
      photo: parsedJson['Photo'],
      department: parsedJson['Department'],
      corporation: parsedJson['Corporation'],
      position: parsedJson['Position'],
      workphone: parsedJson['WorkPhone'],
      mobilephone: parsedJson['MobilePhone'],
      birthdate: parsedJson['BirthDate'],
      mail: parsedJson['Mail'],
      additionalphone: parsedJson['AdditionalPhone'],
    );
  }
}

class ContactServer {
  bool authServer;
  List<ContactItem> contacts;
  ContactServer({required this.authServer, required  this.contacts});

  factory ContactServer.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['ContactList'] as List;

    return new ContactServer(
      authServer: parsedJson['AuthServer'],
      contacts: list.map((i) => ContactItem.fromJson(i)).toList(),
    );
  }

  factory ContactServer.EmptyContact() {
    List<ContactItem> listv = [];
    ContactItem varl = new ContactItem(id: 0, status:'', firstname: '', middlename: '', lastname: '', photo: '', department: '', corporation: '', position: '', workphone: '',  mobilephone: '', birthdate: '', mail: '', additionalphone: '');
    listv.add(varl);

    return new ContactServer(
      authServer: true,
      contacts: listv,
    );
  }


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

  void setFilters(String fio, String corporation, String departament) {
    //filters.controllerFIO = fio;
    //filters.controllerCorporation = corporation;
    //filters.controllerDepartament = departament;
    //notifyListeners();
  }


}


Future<bool> checkTokenAuth(String token) async {

  bool result = false;

  try {
    var resBody = {};
    resBody["Token"] = token;

    final response = await http.post(
      Uri.http(ipLocalhost, '/checkToken/'),
      body: jsonEncode(resBody),).timeout(const Duration(seconds: 3));
    if (response.statusCode == 200) {
      result = true;
    }
  }

  on TimeoutException catch (e) {
    print('Timeout:');
    rethrow;
  } on Error catch (e) {
    print('Caught error 1: $e');
    rethrow;
  }
  on http.ClientException catch (e) {
    print('Caught error 2: $e');
    rethrow;
  }
  catch (e) {
    print('Error general: $e');
    rethrow;
  }
  debugPrint('Step 6, build base:');
  return result;
}


Future<ContactServer> getContacts(String token, {String id_contact = ''}) async {

  if (id_contact == 'create card') {
    return ContactServer.EmptyContact();
  }



  ContactServer result = new ContactServer(authServer: false, contacts:[]);

  try {
    var resBody = {};
    resBody["Token"] = token;
    resBody["IdContact"] = id_contact;

    final response = await http.post(
      Uri.http(ipLocalhost, '/getAllContacts/'),
      body: jsonEncode(resBody),).timeout(const Duration(seconds: 3));
    if (response.statusCode == 200) {
      result =
      ContactServer.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
  }

  on TimeoutException catch (e) {
    print('Timeout:');
    rethrow;
  } on Error catch (e) {
    print('Caught error 1: $e');
    rethrow;
  }
  on http.ClientException catch (e) {
    print('Caught error 2: $e');
    rethrow;
  }
  catch (e) {
    print('Error general: $e');
    rethrow;
  }
  //debugPrint('Step 6, build base:');
  return result;
}
