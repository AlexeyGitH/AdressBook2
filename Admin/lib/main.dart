import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/LogIn.dart';
import 'screens/MainAdminPage.dart';
import 'package:admin/models/mainStatesModel.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

//https://github.com/carzacc/jwt-tutorial-flutter/blob/master/lib/main.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Address book',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {
  @override
  _MainWidget createState() => _MainWidget();
}

class _MainWidget extends State<MainWidget> {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => MainConstModel()),
        ChangeNotifierProvider<MainConstModel>(
          create: (context) => MainConstModel(),
        ),
      ],
      child: BodyWidget(),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  _BodyWidget createState() => _BodyWidget();
}

class _BodyWidget extends State<BodyWidget> {
  Widget build(BuildContext context) {
    var mainConstModel = context.watch<MainConstModel>();

    final _storage = const FlutterSecureStorage();

    Future<String> _readValStorage() async {
      String? val = await _storage.read(key: 'token_session');
      String t_s = val ?? '';

      debugPrint('before delay');
      Future.delayed(const Duration(seconds: 5), () {
        final f = t_s;
        debugPrint('after delay 2');

      });
      debugPrint('after delay 1');

      return t_s;
    }




    return FutureBuilder(
      future: _readValStorage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          debugPrint('Step 3, build widget: ${snapshot.data}');
          // Build the widget with data.
          //return Center(child: Container(child: Text('hasData: ${snapshot.data}')));
          if (snapshot.data == 'value88') {
            return MainAdminPage();
          } else {
            return LoginPage();
          }
        } else {
          // We can show the loading view until the data comes back.
          debugPrint('Step 1, build loading widget');
          return CircularProgressIndicator();
        }
      },
    );

  }
}
