import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyModel extends  ChangeNotifier {
  String a = 'Test1';
  String b = 'Test2';
  int c = 1;
  addNumber() {
    c =c+1;
  }
  changeA(t) {
    this.a = 'Test 1A' + (t+1).toString();
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_)=> MyModel(),
        child: MaterialApp(
          home: MyHomePage(),));

  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Consumer<MyModel>(
        builder: (context, myModel, child) =>
            Scaffold(
              appBar: AppBar(
                title: Text(myModel.a),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () =>
                    Navigator.of(context).push(_createRoute(),
                    ),
                tooltip: 'Press',
                child: Icon(Icons.access_alarm),
              ),
            )
    );
  }
}


Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class Page2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var myModel = Provider.of<MyModel>(context); // A
    myModel.addNumber();
    return Scaffold(
      appBar: AppBar(
        title: Text(myModel.b),
      ),
      body:
      Center(child: Text('You have pressed the button ' + myModel.c.toString())),
      floatingActionButton: FloatingActionButton(
        onPressed:

            () => {
          myModel.changeA(myModel.c),
          Navigator.of(context).pop(),
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );

  }
}