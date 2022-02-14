import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/models/mainStatesModel.dart';
import 'package:admin/models/database.dart';

import 'dart:async';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin  {
  late AnimationController _controller;
  late Animation<Color?> _color;
  TextEditingController _svLogin = TextEditingController();
  TextEditingController _svPassword = TextEditingController();
  String msgText = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(seconds: 2),vsync: this,)..repeat(reverse: true);
    _color = ColorTween(begin: Colors.blue[400], end: Colors.blue[700]).animate(_controller);
    msgText ='';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                    controller: _svLogin,
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
                    controller: _svPassword,
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
                            onPressed: () async {
                              //mainConstModel.setAuthenticated(true);
                              //String base64Auth = stringToBase64.encode("${login}:${password}");
                              //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'fff'),), (route) => false);
                              var _resp = await getTokenAuth(_svLogin.text, _svPassword.text);
                              if (_resp.Auth == true) {
                                mainConstModel.setCurrentPage("MainPage");
                                //debugPrint('Write storage');
                              } else {
                                setState(() {msgText = _resp.Msg;});
                              }



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

                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(msgText,
                    style: TextStyle(
                    fontSize: 16,
                    color: Colors.red[300],
                    decoration: TextDecoration.underline,
                    ),),
                ),


              ])),
              Expanded(child: Column()),
            ])
        )

    );
  }

}
