import 'package:flutter/material.dart';

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
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




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
  _controller = AnimationController(duration: Duration(seconds: 5),vsync: this,)..repeat(reverse: true);
  _color = ColorTween(begin: Colors.blue, end: Colors.amber).animate(_controller);
}

@override
void dispose() {
 _controller.dispose();
 super.dispose();
}



  Widget build(BuildContext context) {
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

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'fff'),), (route) => false);

                //Navigator.push(
                //    context, MaterialPageRoute(builder: (_) => MyHomePage(title: 'fff',)));
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


      ])),
      Expanded(child: Column()),
  ])
    )

      );
    }

  }






