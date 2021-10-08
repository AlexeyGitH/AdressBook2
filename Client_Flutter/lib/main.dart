import 'package:flutter/material.dart';
//import 'DataBase.dart';
import 'package:provider/provider.dart';
import 'SearchPage.dart';

import 'common/theme.dart';
import 'screens/contacts.dart';
import 'screens/filters.dart';
import 'package:ad_book_2/models/contacts.dart';
import 'package:ad_book_2/models/filters.dart';


void main() {
  runApp(
      MyApp()
    /*
    RestartWidget(
      child: MyApp(),
    ),*/
  );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Provider(create: (context) => DataBase()),
        //Provider(create: (context) => DataBaseFilter()),
        Provider(create: (context) => FiltersModel()),

        /*
        ChangeNotifierProxyProvider<DataBase, FiltersModel>(
          create: (context) => FiltersModel(),
          update: (context, DataBase, DataBaseFilter) {
            //if (DataBaseFilter == null) throw ArgumentError.notNull('DataBaseFilter');
            //cart.catalog = catalog;
            //return cart;
          },
        ),
        */
    ChangeNotifierProvider<FiltersModel>(
      create: (context) => FiltersModel(),

    ),
      ],
      child:

      MaterialApp(
        title: 'Address book',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => Contacts(),
          '/filters': (context) => Filters(),
        },
    ),

    );
  }
}


/*
class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}
*/

/*
class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
*/