import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/models/mainStatesModel.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin  {
  late AnimationController _controller;
  late Animation<Color?> _color;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(seconds: 2),vsync: this,)..repeat(reverse: true);
    _color = ColorTween(begin: Colors.blue[400], end: Colors.blue[700]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final _storage = const FlutterSecureStorage();
  Future<void> _writeValStorage() async {
    await _storage.write(key: 'fff', value: 'value88');
  }

  Future<void> _deleteValStorage() async {
    await _storage.delete(key: 'fff');
  }

  Widget build(BuildContext context) {
    var mainConstModel = context.watch<MainConstModel>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Admin login"),
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
                          width: 160,
                          height: 120,
                          child: Image.asset('assets/logo.png')),
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
                        labelText: 'Login',
                        hintText: 'Enter login'),
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

                  AnimatedBuilder(
                    animation: _color,
                    builder: (BuildContext _, Widget? __) {
                      return

                        Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                              color: _color.value, borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                            onPressed: () {
                              //mainConstModel.setAuthenticated(true);
                              //String base64Auth = stringToBase64.encode("${login}:${password}");
                              //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'fff'),), (route) => false);

                              //Navigator.push(
                              //    context, MaterialPageRoute(builder: (_) => MyHomePage(title: 'fff',)));
                              _writeValStorage();
                              debugPrint('Write storage');


                            },
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        );






                    },
                  ),












                ),

                Text('ffff 444'),


              ])),
              Expanded(child: Column()),
            ])
        )

    );
  }

}

