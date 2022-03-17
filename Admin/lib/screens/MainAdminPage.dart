import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:admin/models/mainStatesModel.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

class MainAdminPage extends StatefulWidget {
  @override
  _MainAdminPage createState() => _MainAdminPage();
}

class _MainAdminPage extends State<MainAdminPage> {
  final ScrollController _firstController = ScrollController();
  final ScrollController _firstControllerV = ScrollController();


  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    final _appBar = AppBar(
      title: Text("Contact list"),
    );
    final _TableHeader = TableHeader();
    final _TableBody = TableBody();
    final _TableFooter = TableFooter();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar,
        body:
        Column(children: [
          Container(
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

  }
}

class TableHeader extends StatefulWidget {
  @override
  _TableHeader createState() => _TableHeader();
}

class _TableHeader extends State<TableHeader> {
  @override
  Widget build(BuildContext context) {
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
                        new IconButton(
                          iconSize: 20,
                          padding: new EdgeInsets.all(0.0),
                          constraints: BoxConstraints(
                            minHeight: 15.0,
                            minWidth: 15.0,
                          ),
                          //color: themeData.primaryColor,
                          icon: new Icon(Icons.add_circle_outline),
                          onPressed: () {
                          },
                        )

                        ,)),

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
                        padding: const EdgeInsets.all(5),
                        child:  Center(child:Text('Должность',style: TextStyle(fontWeight: FontWeight.bold),)),
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
  @override
  _TableBody createState() => _TableBody();
}

class _TableBody extends State<TableBody> {



  @override
  Widget build(BuildContext context) {

    final rows = <TableRow>[];
    var color = Colors.transparent;

    //for (var rowData in myRowDataList) {

    int i = 0;
    for (i = 0; i < 50; i++) {
      rows.add(

        TableRow(
            decoration: BoxDecoration(
                color: i % 2 == 0 ? Colors.white: Colors.grey[100],
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey, width: 0.5,),
                )),

            children: [

              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child:
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(5),
                    child:


                    Row(children: [
                      new Material(
                          child:
                      new IconButton(
                        splashRadius: 8,
                        splashColor: Colors.transparent,
                        hoverColor: Colors.amberAccent,
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
                        },
                      )),
                      new IconButton(
                        iconSize: 15,
                        padding: new EdgeInsets.all(2.0),
                        constraints: BoxConstraints(
                          minHeight: 15.0,
                          minWidth: 15.0,
                        ),
                        //color: themeData.primaryColor,
                        icon: new Icon(Icons.delete_forever),
                        onPressed: () {
                        },
                      ),
                    ],))

                ,),


              TableCell(
                //decoration: BoxDecoration(color: Colors.grey[200]),
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Align( alignment: Alignment.centerLeft,child:Text('ФИО'+i.toString()))),
              ),
              TableCell(
                child:Container(
                    padding: const EdgeInsets.all(5),
                    child: Center(child: Text('Организация'))),
              ),
              TableCell(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Center(child: Text('Подразделение'))),
              ),
              TableCell(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Center(child: Text('Должность'+i.toString()))),
              ),]
        ),

      );
    };



    return
      Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(100),
          1: FixedColumnWidth(600),
          2: FixedColumnWidth(300),
          3: FixedColumnWidth(300),
          4: FixedColumnWidth(300),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: rows,

      );
  }

}
