import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/models/mainStatesModel.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

class MainAdminPage extends StatefulWidget {
  @override
  _MainAdminPage createState() => _MainAdminPage();
}


class _MainAdminPage extends State<MainAdminPage> {

  Widget build(BuildContext context) {
    var mainConstModel = context.watch<MainConstModel>();

    final _storage = const FlutterSecureStorage();
    Future<void> _deleteValStorage() async {
      await _storage.delete(key: 'fff');
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Admin 2"),
        ),
        body: SingleChildScrollView(
            child: Row (children: [
              Expanded(child: Column()),
              Expanded(flex:5, child: Column(children: [
                Center(
                  child:
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 30.0),
                    child: Center(
                      child: Container(
                          width: 200,
                          height: 150,
                          child: Image.asset('logo.png')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Login2',
                        hintText: 'Enter login22'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(

                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 40, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child:

                  TextButton(
                    onPressed: () {
//                      mainConstModel.setAuthenticated(false);
                      _deleteValStorage();
                      debugPrint('Delete storage');
                      //String base64Auth = stringToBase64.encode("${login}:${password}");
                      //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'fff'),), (route) => false);

                      //Navigator.push(
                      //    context, MaterialPageRoute(builder: (_) => MyHomePage(title: 'fff',)));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.black38, fontSize: 25),
                    ),
                  ),
              ),



              ])),
              Expanded(child: Column()),


            ])
        )

    );
  }

}

