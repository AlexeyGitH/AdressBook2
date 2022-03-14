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



 /*   return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Main page"),
        ),
        body:
Column(children: [
        Scrollbar(
        isAlwaysShown: screenSize.width <= 600 ? true:false,
        controller: _firstController,
        child:

        SingleChildScrollView(
        scrollDirection: Axis. horizontal,
        controller: _firstController,
        child:
Column(children: [
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
    ),
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
  ) ,
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
  ),
],)

        )),




]
  ,)


    );
*/
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
          thumbVisibility: screenSize.width <= 600 ? true:false,
          controller: _firstController,
          child:

          SingleChildScrollView(
            scrollDirection: Axis. horizontal,
            controller: _firstController,


               child: Expanded(child:
               Column(children: [

                 _TableHeader,




    //Expanded(child:
                 Container(
                     height: MediaQuery.of(context).size.height-_appBar.preferredSize.height.round()-70,
                     child:

                     Scrollbar(
                         thumbVisibility: true,
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
          //)

    )
    )

                 ,


/*

                 Container(
                     height: 100,
                     color: Colors.red,
                     child:
                     SingleChildScrollView(
                       scrollDirection: Axis.vertical,
                       child: Column(
                         children: <Widget>[

                           Container(
                             color: Colors.green, // Yellow
                             height: 200.0,
                             width: 200.0,
                           ),

                           Image.network('https://flutter-examples.com/wp-content/uploads/2019/09/blossom.jpg',
                               width: 300, height: 200, fit: BoxFit.contain),

                           Image.network('https://flutter-examples.com/wp-content/uploads/2019/09/sample_img.png',
                               width: 200, fit: BoxFit.contain),

                           Container(
                             color: Colors.pink, // Yellow
                             height: 200.0,
                             width: 200.0,
                           ),

                           Text('Some Sample Text - 1', style: TextStyle(fontSize: 28)),

                           Container(
                             color: Colors.redAccent, // Yellow
                             height: 200.0,
                             width: 200.0,
                           ),

                           Image.network('https://flutter-examples.com/wp-content/uploads/2019/09/blossom.jpg',
                               width: 300, height: 200, fit: BoxFit.contain),

                         ],
                       ),
                     )),
*/






               ],))

           ))),



              _TableFooter,

            ],)

/*
   Container(
   height: MediaQuery.of(context).size.height-_appBar.preferredSize.height.round(),
      child:
    Scrollbar(
    isAlwaysShown: screenSize.width <= 600 ? true:false,
    controller: _firstController,
    child:

    SingleChildScrollView(
    scrollDirection: Axis. horizontal,
    controller: _firstController,
    child:
    Expanded(child:
    Column(children: [
      Text('ff'),
      Expanded(child: Container(child: Text('ff'),)),
      Text('ff'),

  ]))))),
*/


/*
    Text('ff'),
    Expanded(child: Container(child: Text('ff'),)),
    Text('ff'),
*/


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
      child:
      Container(
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)
                    ),
                    child: Center(child:Text('ФИО',style: TextStyle(fontWeight: FontWeight.bold),)))),
              ),
              TableCell(
              child:
              Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
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
                    child: Center(child: Text('Организация', style: TextStyle(fontWeight: FontWeight.bold),)))),
              ),
              TableCell(
              child:
              Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
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
                    child: Center(child: Text('Подразделение', style: TextStyle(fontWeight: FontWeight.bold),)))),
              ),
              TableCell(
              child:
              Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
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
                    child: Center(child: Text('Должность', style: TextStyle(fontWeight: FontWeight.bold),)))),
              ),
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

    //for (var rowData in myRowDataList) {

    int i = 0;
    for (i = 0; i < 50; i++) {
      rows.add(

          TableRow(
            children: <Widget>[
              TableCell(
                //decoration: BoxDecoration(color: Colors.grey[200]),
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)
                    ),
                    child: Center(child:Text('ФИО'+i.toString()))),
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
                    child: Center(child: Text('Должность'+i.toString()))),
              ),
            ],
          )

      );
    };



    return
      Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(600),
          1: FixedColumnWidth(300),
          2: FixedColumnWidth(300),
          3: FixedColumnWidth(300),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: rows,
      );
  }

}

/*
<TableRow>[
TableRow(
children:
<Widget>[
TableCell(
//decoration: BoxDecoration(color: Colors.grey[200]),
child: Container(
padding: const EdgeInsets.all(5),
decoration: BoxDecoration(
border: Border.all(color: Colors.blueAccent)
),
child: Center(child:Text('ФИО1'))),
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
child: Center(child: Text('Должность1'))),
),
],
),                     TableRow(
children: <Widget>[
TableCell(
//decoration: BoxDecoration(color: Colors.grey[200]),
child: Container(
padding: const EdgeInsets.all(5),
decoration: BoxDecoration(
border: Border.all(color: Colors.blueAccent)
),
child: Center(child:Text('ФИО2'))),
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
child: Center(child: Text('Должность2'))),
),
],
),
TableRow(
children: <Widget>[
TableCell(
//decoration: BoxDecoration(color: Colors.grey[200]),
child: Container(
padding: const EdgeInsets.all(5),
decoration: BoxDecoration(
border: Border.all(color: Colors.blueAccent)
),
child: Center(child:Text('ФИО3'))),
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
child: Center(child: Text('Должность3'))),
),
],
),
],
*/