import 'dart:convert';

import 'package:flutter/material.dart';
import 'PostContact.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

const int Limit_const = 1;

/////////11

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Address book'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

Future<ContactServer> fetchContactServer(queryParameters) async {
  /*
  var queryParameters = {
    'count': '1',
    'limit': '10',
  };
*/
  var uri = Uri.http('192.168.88.234:8000', '/contacts_2/', queryParameters);

  final response = await http.get(uri);

/*
  final response =
      await http.get('http://192.168.88.234:8000/contacts_2/?count=1&limit=3');
*/
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ContactServer.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load contacts');
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var numbercontacts = 1;
  var countcontacts = 1;

  @override
  Widget build(BuildContext context) {
    var queryParameters = {
      'count': numbercontacts.toString(),
      'limit': Limit_const.toString(),
    };

    var futureBuilder = new FutureBuilder(
      future: fetchContactServer(queryParameters),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('No signal...');
          case ConnectionState.waiting:
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
                      "waiting.. ",
                      style: new TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            );
          default:
            if (snapshot.hasError)
              //return new Text('Error: ${snapshot.error}');
              return new Text('Do not connect to server');
            else if (snapshot.hasData) {
              //setState(() {
              //  this.countcontacts = snapshot.data.countlist;
              // });
              return contactsscafold(snapshot.data);
              //return new Text('Do not connect to server');
            } else {
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
                        "loading.. wait...",
                        style: new TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              );
            }
        }
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: futureBuilder,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue[700],
        child: Row(
          children: [
            new SizedBox(
              height: 40.0,
              width: 40.0,
              child: new IconButton(
                  padding: new EdgeInsets.all(0.0),
                  color: Colors.white,
                  icon: new Icon(Icons.arrow_left, size: 40.0),
                  onPressed: () {}),
            ),
            Spacer(),
            new SizedBox(
              height: 40.0,
              width: 40.0,
              child: new IconButton(
                  padding: new EdgeInsets.all(0.0),
                  color: Colors.white,
                  icon: new Icon(Icons.arrow_right, size: 40.0),
                  onPressed: () {
                    //setState(() => this._MyHomePageState = _MyHomePageState());
                    if (this.numbercontacts + Limit_const >=
                        this.countcontacts) {
                      print('space');
                    } else {
                      print('this.numbercontacts ${this.numbercontacts}');
                      print('this.countcontacts ${this.countcontacts}');

                      //setState(() {
                      //  this.numbercontacts = this.numbercontacts + Limit_const;
                      //});
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
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

contactsscafold(ContactServer datacontact) {
  //return new Text('OOKKK');
  ///*
  ///
  print('snapshot.data.countlist ${datacontact.countlist}');
  return new ListView.builder(
    itemCount: datacontact.contacts.length,
    itemBuilder: (context, index) {
      var postPone = datacontact.contacts[index];
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
                                          fontSize: 12.0, color: Colors.black),
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
                    widgetADPropertyValue(
                        'Мобильный тел.', postPone.mobilephone.toString(), 'p'),
                    widgetADPropertyValue(
                        'Почта', postPone.mail.toString(), 'e'),
                  ],
                )),
          ]));
    },
  );
//*/
}
