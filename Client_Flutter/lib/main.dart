//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'DataBase.dart';
import 'package:provider/provider.dart';
//import 'SearchPage.dart';

void main() {
  runApp(MyApp());

  //runApp(ListPage());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

      MultiProvider(
        providers: [
          //ChangeNotifierProvider(create: (_)=> DataBase()),
          FutureProvider(create: (context) => DataBase().fetchSomething()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: AddressBookHomePage(),),
      );
  }
}

class AddressBookHomePage extends StatefulWidget {
  AddressBookHomePage({Key key}) : super(key: key);

  @override
  _AddressBookHomePageState createState() => _AddressBookHomePageState();
}


class _AddressBookHomePageState extends State<AddressBookHomePage> {

  @override
  Widget build(BuildContext context) {

    //return Consumer<DataBase>(
    //    builder: (context, myModel, child) =>
    return        Scaffold(
              appBar: AppBar(
                title: Text('Address book'),
              ),
              body: GetBasePageWidget(),
              bottomNavigationBar: BottomAppBar(
                color: Colors.blue[700],
                child: Row(
                  children: [
                    //LeftArrowBottomWidget(),
                    Spacer(),
                    //RightArrowBottomWidget(),
                  ],
                ),
              ),
            );
   // );
  }
}


class GetBasePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ModelDateBase = Provider.of<String>(context);
    //var ModelDateBase2 = Provider.of<DataBase>(context);

    //var futureBuilder = new FutureBuilder()

    //return ModelDateBase.getContactList();
    //return futureBuilder;


    //return Text(ModelDateBase.f);
    return
      Consumer<String>(
          builder: (context, myModel, child) =>
            ModelDateBase == null ? Text('Loading...') : Text(ModelDateBase)
      );
    //print('dsfsdfsdf ');
    //print(ModelDateBase.fetchSomething());
    //return Text(ModelDateBase.f);
  }
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
class MyApp_ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: DataBase(),
        ),
      ],
      child: MaterialApp(
        title: 'Address book',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BasePage(title: "Address book"),
      ),
    );
  }
}
*/

/*
class BasePage extends StatelessWidget {
  final String title;
  BasePage({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: GetBasePageWidget(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue[700],
        child: Row(
          children: [
            LeftArrowBottomWidget(),
            Spacer(),
            RightArrowBottomWidget(),
          ],
        ),
      ),
    );
  }
}
*/

/*
class _GetBasePageWidget_ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: Provider.of<DataBase>(context).getContacts("", "orp", "", "", ""),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            //print('1');
            return ListPageError();
          case ConnectionState.waiting:
            //print('2');
            return ListPageWaiting();
          default:
            if (snapshot.hasError) {
              //return new Text('Error: ${snapshot.error}');
              //print('3');
              //return new Text('Do not connect to server');
              return ListPageError();
            } else if (snapshot.hasData) {
              //print(snapshot.data);
              //setState(() {
              //  this.countcontacts = snapshot.data.countlist;
              // });
              // print('4');
              return ListPageList(serverdata: snapshot.data);

              //return snapshot.data;
            } else {
              //print('5');
              return ListPageWaiting();
            }
        }
      },
    );
    //return Text('2333442221111');
    return futureBuilder;
  }
}
*/



/*
class RightArrowBottomWidget extends StatelessWidget {
  void _getContactsAdd(BuildContext context) {
    Provider.of<DataBase>(context, listen: false).getContactsAdd();
  }

  @override
  Widget build(BuildContext context) {
    var contactlist = Provider.of<DataBase>(context).getContactList;
    Color colorarrow;
    //Waiting spiner ... ... ..
    colorarrow = contactlist.blockrightarrow == true
        ? Colors.blueGrey[600]
        : Colors.white;
    return new SizedBox(
      height: 40.0,
      width: 40.0,
      child: new IconButton(
          padding: new EdgeInsets.all(0.0),
          color: colorarrow,
          icon: new Icon(Icons.arrow_right, size: 40.0),
          onPressed: () {
            if (contactlist.blockrightarrow != true) {
              _getContactsAdd(context);
            }
          }),
    );
  }
}

class LeftArrowBottomWidget extends StatelessWidget {
  void _getContactsMinus(BuildContext context) {
    Provider.of<DataBase>(context, listen: false).getContactsMinus();
  }

  @override
  Widget build(BuildContext context) {
    var contactlist = Provider.of<DataBase>(context).getContactList;
    Color colorarrow;
    //Waiting spiner ... ... ..
    colorarrow =
        (contactlist.datalistcount == 0 && contactlist.database.countlist != 0)
            ? Colors.blueGrey[600]
            : Colors.white;

    return new SizedBox(
      height: 40.0,
      width: 40.0,
      child: new IconButton(
          padding: new EdgeInsets.all(0.0),
          color: colorarrow,
          icon: new Icon(Icons.arrow_left, size: 40.0),
          onPressed: () {
            if (contactlist.datalistcount != 0 ||
                contactlist.database.countlist == 0) {
              _getContactsMinus(context);
            }
          }),
    );
  }
}

widgetADPropertyValue(String sProperty, String sValue, String sIcon) {
  return Container(
      padding: EdgeInsets.only(top: 3),
      child: Row(
        children: [
          Expanded(
              flex: 10,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  sProperty,
                  style: new TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              )),
          Expanded(
              flex: 2,
              child: Align(
                alignment: AlignmentDirectional.center,
                child: _getIcon(sIcon),
              )),
          Expanded(
              flex: 20,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  sValue,
                  style:
                      new TextStyle(fontSize: 14.0, color: Colors.indigo[900]),
                ),
              )),
        ],
      ));
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      color: Colors.black38, //                   <--- border color
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.6),
        spreadRadius: 3,
        blurRadius: 2,
        offset: Offset(2, 3), // changes position of shadow
      ),
    ],
    //
  );
}

Widget _getIcon(sIcon) {
  if (sIcon == 'p')
    return Icon(
      Icons.call,
      color: Colors.green[900],
      size: 14.0,
    );
  else if (sIcon == 'e')
    return Icon(
      Icons.alternate_email,
      color: Colors.green[900],
      size: 14.0,
    );
  else
    return Text(':', style: new TextStyle(fontSize: 14.0, color: Colors.black));
}

class ListPageWaiting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        new Container(
          margin: const EdgeInsets.only(top: 80.0),
          child: new SizedBox(
            height: 150.0,
            width: 150.0,
            child: new CircularProgressIndicator(
              value: null,
              strokeWidth: 4.0,
            ),
          ),
        ),
        new Container(
          margin: const EdgeInsets.only(top: 25.0),
          child: new Center(
            child: new Text(
              "loading.. waiting...",
              style: new TextStyle(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}

class ListPageError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        new Container(
          margin: const EdgeInsets.only(top: 25.0),
          child: new Center(
            child: new Text(
              "connection error..",
              style: new TextStyle(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}

class ListPageList extends StatelessWidget {
  final DataBaseData serverdata;
  ListPageList({this.serverdata});

  @override
  Widget build(BuildContext context) {
    //print('12345');
    // print('datalist  ;22; ${serverdata.database.contacts[0].firstname}');
    // return Text('22131231212');

    return new ListView.builder(
      itemCount: serverdata.database.contacts.length,
      itemBuilder: (context, index) {
        var postPone = serverdata.database.contacts[index];
        return new Container(
            decoration: myBoxDecoration(),
            margin: const EdgeInsets.all(6.0),
            padding: const EdgeInsets.all(3.0),
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      postPone.image.toString(),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Row(children: [
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Статус: ',
                                        style: new TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: postPone.status.toString(),
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.green[900])),
                                        ],
                                      ),
                                    ))),
                          ]),
                          Row(children: [
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      postPone.firstname.toString() +
                                          " " +
                                          postPone.middlename.toString() +
                                          " " +
                                          postPone.lastname.toString(),
                                      style: new TextStyle(
                                        //backgroundColor: Colors.blue,
                                        fontFamily: 'Quicksand',
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))),
                          ])
                        ],
                      )),
                ],
              ),
              Container(
                  margin: const EdgeInsets.all(3.0),
                  child: Column(
                    children: [
                      /////////
                      widgetADPropertyValue(
                          'Организация', postPone.corporation.toString(), ''),
                      widgetADPropertyValue(
                          'Должность', postPone.position.toString(), ''),
                      widgetADPropertyValue(
                          'Подразделение', postPone.department.toString(), ''),
                      widgetADPropertyValue(
                          'Дата рождения', postPone.birthdate.toString(), ''),

                      widgetADPropertyValue(
                          'Рабочий тел.', postPone.workphone.toString(), 'p'),
                      widgetADPropertyValue('Мобильный тел.',
                          postPone.mobilephone.toString(), 'p'),
                      widgetADPropertyValue(
                          'Почта', postPone.mail.toString(), 'e'),
                    ],
                  )),
            ]));
      },
    );
  }
}
*/