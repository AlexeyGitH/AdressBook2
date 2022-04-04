import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:admin/models/mainStatesModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'package:admin/models/database.dart';
import 'package:admin/ConstSystemAD.dart';
import 'package:admin/main.dart';

class MainAdminPage extends StatefulWidget {
  @override
  _MainAdminPage createState() => _MainAdminPage();
}

class _MainAdminPage extends State<MainAdminPage> {
  /*
  final ScrollController _firstController = ScrollController();
  final ScrollController _firstControllerV = ScrollController();
*/

  Widget build(BuildContext context) {
    /*
    var screenSize = MediaQuery.of(context).size;

    final _appBar = AppBar(
      title: Text("Contact list"),
    );
    final _TableHeader = TableHeader();
    final _TableBody = TableBody();
    final _TableFooter = TableFooter();
    */
/*
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar,
        body:
        Column(children: [
          Container(
              //width: 1400,
              height: MediaQuery.of(context).size.height-_appBar.preferredSize.height.round()-35,
              child:
              Scrollbar(
                //thumbVisibility: screenSize.width <= 600 ? true:false,
                  trackVisibility: screenSize.width <= 600 ? true:false,
                  controller: _firstController,
                  child:

                  SingleChildScrollView(
                      scrollDirection: Axis. horizontal,
                      controller: _firstController,


                      child:
                      Column(children: [

                        _TableHeader,
                        //Text('Table header'),




                        //Expanded(child:
                        Container(
                            height: MediaQuery.of(context).size.height-_appBar.preferredSize.height.round()-70,
                            child:

                            Scrollbar(
                              //thumbVisibility: true,
                                trackVisibility: true,
                                controller: _firstControllerV,
                                child:
                                SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    controller: _firstControllerV,
                                    child:

                                    Column(
                                        children: [
                                          _TableBody,
                                          //Text('Table body'),
                                        ])

                                )
                              //)

                            )
                        )

                        ,

                      ],)

                  ))),



          _TableFooter,

        ],)


    );
*/

    final _storage = const FlutterSecureStorage();

    Future<ContactServer> _readContactsData() async {
      String? val = await _storage.read(key: session_token_name);
      String t_s = val ?? '';
      var _resp = await getContacts(t_s);
      return _resp;
    }


    return FutureBuilder(
        future: _readContactsData(),
        builder: (context, AsyncSnapshot<ContactServer> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return  Center(
                child: SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator()),
              );
            default:
              if (snapshot.hasError)
                return RefreshWidget();
              else if (snapshot.data == null) {
                return RefreshWidget();
              } else {
                ContactServer? vDBD = snapshot.data;
                if (vDBD == null) {
                  return RefreshWidget();
                } else {
                  if (vDBD.authServer == true) {
                    /*
                    bool scan = true;
                    int i = 0;
                    final rows = <Text>[];

                    while(scan) {

                      rows.add(
                        Text('Row' + i.toString() + ' // ' + vDBD.contacts[i].firstname)
                      );

                      i++;
                      if (i >= vDBD.contacts.length)
                        {
                          scan = false;
                        }
                    }
                    */
                  //return Column(children: rows,);
                    return TableMainArea(dataServer: vDBD);
                  } else {return RefreshWidget();}
          }}
        }}

    );










  }
}

class TableHeader extends StatefulWidget {
  @override
  _TableHeader createState() => _TableHeader();
}

class _TableHeader extends State<TableHeader> {
  @override
  Widget build(BuildContext context) {
    var mainConstModel = context.watch<MainConstModel>();
    return
      Container(
          height: 35,
          alignment: Alignment.center,
          child:

          Table(

            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(100),
              1: FixedColumnWidth(600),
              2: FixedColumnWidth(300),
              3: FixedColumnWidth(300),
              4: FixedColumnWidth(300),
              5: FixedColumnWidth(300),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                children: <Widget>[

                  TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child:

                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(5),
                        child:
                        new Material(
                            color: Colors.transparent,
                            child:
                            new IconButton(
                              splashRadius: 10,
                              splashColor: Colors.lightBlue[300],
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              iconSize: 20,
                              padding: new EdgeInsets.all(0.0),
                              constraints: BoxConstraints(
                                minHeight: 20.0,
                                minWidth: 20.0,
                              ),
                              //color: themeData.primaryColor,
                              icon: new Icon(Icons.add_circle_outline),
                              onPressed: () {
                                mainConstModel.setCurrentIdContact('create card');
                                mainConstModel.setCurrentPage("CardContact");
                              },
                            )),
                        )),

                  TableCell(
                      child:
                      Container(
                        padding: const EdgeInsets.all(5),
                        child:  Center(child:Text('ФИО',style: TextStyle(fontWeight: FontWeight.bold),)),
                      )),
                  TableCell(
                      child:
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  width: 1.0, color: Colors.grey),
                              left: BorderSide(
                                  width: 1.0, color: Colors.grey),
                            )
                        ),

                        padding: const EdgeInsets.all(5),
                        child:  Center(child:Text('Организация',style: TextStyle(fontWeight: FontWeight.bold),)),
                      )),
                  TableCell(
                      child:
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  width: 1.0, color: Colors.grey),
                            )
                        ),
                        padding: const EdgeInsets.all(5),
                        child:  Center(child:Text('Подразделение',style: TextStyle(fontWeight: FontWeight.bold),)),
                      )),
                  TableCell(
                      child:
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  width: 1.0, color: Colors.grey),
                            )
                        ),
                        padding: const EdgeInsets.all(5),
                        child:  Center(child:Text('Должность',style: TextStyle(fontWeight: FontWeight.bold),)),
                      )),
                  TableCell(
                      child:
                      Container(
                        padding: const EdgeInsets.all(5),
                        child:  Center(child:Text('Телефон',style: TextStyle(fontWeight: FontWeight.bold),)),
                      )),

                ],
              ),
            ],
          ));
  }
}

class TableFooter extends StatefulWidget {
  @override
  _TableFooter createState() => _TableFooter();
}

class _TableFooter extends State<TableFooter> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
          height: 35,
          alignment: Alignment.center,
          child:

          Table(

            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(600),
              1: FixedColumnWidth(300),
              2: FixedColumnWidth(300),
              3: FixedColumnWidth(300),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  TableCell(
                    //decoration: BoxDecoration(color: Colors.grey[200]),
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)
                        ),
                        child: Center(child:Text('ФИО'))),
                  ),
                  TableCell(
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  width: 1.0, color: Colors.blueAccent),
                              bottom: BorderSide(
                                  width: 1.0, color: Colors.blueAccent),
                              right: BorderSide(
                                  width: 1.0, color: Colors.blueAccent),
                            )),
                        child: Center(child: Text('Организация'))),
                  ),
                  TableCell(
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  width: 1.0, color: Colors.blueAccent),
                              bottom: BorderSide(
                                  width: 1.0, color: Colors.blueAccent),
                              right: BorderSide(
                                  width: 1.0, color: Colors.blueAccent),
                            )),
                        child: Center(child: Text('Подразделение'))),
                  ),
                  TableCell(
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  width: 1.0, color: Colors.blueAccent),
                              bottom: BorderSide(
                                  width: 1.0, color: Colors.blueAccent),
                              right: BorderSide(
                                  width: 1.0, color: Colors.blueAccent),
                            )),
                        child: Center(child: Text('Должность'))),
                  ),

                ],
              ),
            ],
          ));

  }
}


class TableBody extends StatefulWidget {
  ContactServer dataServer;

  TableBody({required this.dataServer});

  @override
  _TableBody createState() => _TableBody();
}

class _TableBody extends State<TableBody> {
  @override
  Widget build(BuildContext context) {
    var mainConstModel = context.watch<MainConstModel>();
    final rows = <TableRow>[];
    var color = Colors.transparent;
    var getData = widget.dataServer;


    bool scan = true;
    int i = 0;

    while (scan) {
      String _phone_str1 = 'Раб.:' + getData.contacts[i].workphone;
      String _phone_str2 = getData.contacts[i].additionalphone=='' ? '': ' доб.' + getData.contacts[i].additionalphone;
      String _phone_str3 = getData.contacts[i].mobilephone=='' ? '': '\n'+'Моб.:' + getData.contacts[i].mobilephone;
      int _idRow = getData.contacts[i].id;

      rows.add(

        TableRow(
            decoration: BoxDecoration(
                color: i % 2 == 0 ? Colors.white : Colors.grey[100],
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                )),
            children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        new Material(
                            color: Colors.transparent,
                            child: new IconButton(
                              splashRadius: 10,
                              splashColor: Colors.lightBlue[300],
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              iconSize: 15,
                              padding: new EdgeInsets.all(2.0),
                              constraints: BoxConstraints(
                                minHeight: 15.0,
                                minWidth: 15.0,
                              ),
                              //color: themeData.primaryColor,
                              icon: new Icon(Icons.create),
                              onPressed: () {
                                //debugPrint('Crate button. ID:' + _idRow.toString());
                                mainConstModel.setCurrentIdContact(_idRow.toString());
                                mainConstModel.setCurrentPage("CardContact");

                              },
                            )),
                        new Material(
                            color: Colors.transparent,
                            child: new IconButton(
                              splashRadius: 10,
                              splashColor: Colors.lightBlue[300],
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              iconSize: 15,
                              padding: new EdgeInsets.all(2.0),
                              constraints: BoxConstraints(
                                minHeight: 15.0,
                                minWidth: 15.0,
                              ),
                              //color: themeData.primaryColor,
                              icon: new Icon(Icons.delete_forever),
                              onPressed: () {},
                            )),
                      ],
                    )),
              ),
              TableCell(
                //decoration: BoxDecoration(color: Colors.grey[200]),
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(getData.contacts[i].firstname.toString() + " " +
                            getData.contacts[i].middlename.toString() + " " +
                            getData.contacts[i].lastname.toString()))),
              ),
              TableCell(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Center(child: Text(getData.contacts[i].corporation))),
              ),
              TableCell(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Center(child: Text(getData.contacts[i].department))),
              ),
              TableCell(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Center(child: Text(getData.contacts[i].position))),
              ),
              TableCell(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Center(child: Text(_phone_str1+_phone_str2+_phone_str3))),



              ),
            ]),
      );

      i++;
      if (i >= getData.contacts.length) {
        scan = false;
      }
    };

    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(100),
        1: FixedColumnWidth(600),
        2: FixedColumnWidth(300),
        3: FixedColumnWidth(300),
        4: FixedColumnWidth(300),
        5: FixedColumnWidth(300),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: rows,
    );
  }
}

class TableMainArea extends StatefulWidget {
  ContactServer dataServer;
  TableMainArea({required this.dataServer});

  @override
  _TableMainArea createState() => _TableMainArea();
}

class _TableMainArea extends State<TableMainArea> {

  final ScrollController _firstController = ScrollController();
  final ScrollController _firstControllerV = ScrollController();

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;
    var postPone = widget.dataServer;

    final _appBar = AppBar(
      title: Text("Contact list"),
    );
    final _TableHeader = TableHeader();
    final _TableBody = TableBody(dataServer: postPone);
    final _TableFooter = TableFooter();


    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar,
        body:
        Column(children: [
          Container(
            //width: 1400,
              height: MediaQuery.of(context).size.height-_appBar.preferredSize.height.round()-35,
              child:
              Scrollbar(
                //thumbVisibility: screenSize.width <= 600 ? true:false,
                  trackVisibility: screenSize.width <= 600 ? true:false,
                  controller: _firstController,
                  child:

                  SingleChildScrollView(
                      scrollDirection: Axis. horizontal,
                      controller: _firstController,
                      child:
                      Column(children: [
                        _TableHeader,
                        Container(
                            height: MediaQuery.of(context).size.height-_appBar.preferredSize.height.round()-70,
                            child:
                            Scrollbar(
                              //thumbVisibility: true,
                                trackVisibility: true,
                                controller: _firstControllerV,
                                child:
                                SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    controller: _firstControllerV,
                                    child:
                                    Column(
                                        children: [
                                          _TableBody,
                                        ])
                                )
                            )
                        ),
                      ],)
                  ))),
          _TableFooter,
        ],)
    );
  }
}

