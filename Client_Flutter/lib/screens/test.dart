import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ad_book_2/models/test.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => TestModel()),
          ChangeNotifierProvider<TestModel>(
            create: (context) => TestModel(),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
            ),
            body: Container(child: TestWidget()),
          ),
        ));
  }
}

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tesProv = context.watch<TestModel>();

    if (tesProv.triggerfliters < 0) {
      return Container(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                tesProv.increaseValue2();
              },
            ),
            Text(tesProv.triggerfliters.toString()),
          ],
        ),
      );
    } else {
      return Container(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.question_answer),
              onPressed: () {
                tesProv.increaseValue1();
              },
            ),
            Text(tesProv.triggerfliters.toString()),
          ],
        ),
      );
    }
  }
}

/*
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final button = PopupMenuButton(
        key: _menuKey,
        itemBuilder: (_) => const<PopupMenuItem<String>>[
          PopupMenuItem<String>(
              child: Text('Doge'), value: 'Doge'),
          PopupMenuItem<String>(
              child: Text('Lion'), value: 'Lion'),
        ],
        onSelected: (_) {});

    final tile =
    ListTile(title: Text('Doge or lion?'), trailing: button, onTap: () {
      // This is a hack because _PopupMenuButtonState is private.
      dynamic state = _menuKey.currentState;
      state.showButtonMenu();
    });
    return Scaffold(
      body: Center(
        child: tile,
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';

void main() => runApp(const Test());

/// This is the main application widget.
class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
        () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2!,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future: _calculation, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Result: ${snapshot.data}'),
              )
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
*/
