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
    this.a = 'Test 1A' + (t).toString();
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> MyModel()),
        ],
        child: MaterialApp(
        home: MyHomePage(),),
      );
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
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => Page2(),
                    ),
                    ),
                tooltip: 'Press',
                child: Icon(Icons.access_alarm),
              ),
            )
    );
  }
}


class Page2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var myModel = Provider.of<MyModel>(context); // A
   // myModel.addNumber();
    return Scaffold(
      appBar: AppBar(
        title: Text(myModel.b),
      ),
      body:
      Center(child: Text('You have pressed the button ' + myModel.c.toString())),
      floatingActionButton: FloatingActionButton(
        onPressed:

            () => {
          myModel.addNumber(),
          myModel.changeA(myModel.c),
          Navigator.of(context).pop(),
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );

  }
}