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


  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
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


    Table(

      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(600),
        1: FixedColumnWidth(300),
        2: FixedColumnWidth(300),
        3: FixedColumnWidth(300),
        4: FixedColumnWidth(700),
        5: FixedColumnWidth(700),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            TableCell(
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Container(padding: const EdgeInsets.all(5), child: Center(child:Text('ФИО'))),
            ),
            TableCell(
              child: Container(padding: const EdgeInsets.all(5), child: Center(child:Text('Организация'))),
            ),
            TableCell(
              child: Container(padding: const EdgeInsets.all(5), child: Center(child:Text('Подразделение'))),
            ),
            TableCell(
              child: Container(padding: const EdgeInsets.all(5), child: Center(child:Text('Должность'))),
            ),
            TableCell(
              child: Container(padding: const EdgeInsets.all(5), child: Center(child:Text('Должность'))),
            ),
            TableCell(
              child: Container(padding: const EdgeInsets.all(5), child: Center(child:Text('Должность'))),
            ),

          ],
        ),
      ],
    ),

        ))



















/*

        Scrollbar(
            isAlwaysShown: screenSize.width <= 600 ? true:false,
            controller: _firstController,
            child:

        SingleChildScrollView(
          scrollDirection: Axis. horizontal,
            controller: _firstController,
            child:




            Column(children: [

          Row(

            children: [
                Container(
                    width: 200,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Color(0xFF000000)),
                          left: BorderSide(width: 1.0, color: Color(0xFF000000)),
                          right: BorderSide(width: 1.0, color: Color(0xFF000000)),
                          bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
                        ),
                      ),
                      //margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),

                    child: Row(

                      children: [Expanded(child: Center(child:Text('ФИО'))), Text('ff')],)
                  ),
              SizedBox(
                width: 200,
                child:
                Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Color(0xFF000000)),
                        right: BorderSide(width: 1.0, color: Color(0xFF000000)),
                        bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
                      ),
                    ),
                    //margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),

                    child: Row(children: [Expanded(child: Center(child:Text('ФИО dfd dfdfgd dfgdf fdgdfgd fdsfs sdfsd sdfsd sdfsfsd'))), Text('ff')],)),
              ),


                  Column(
                    children: [
                      Text('ФИО'),
                    ],
                  ),




              SizedBox(
                  width: 400,
                  child: Column(
                    children: [
                      Text('Организация'),
                    ],
                  )),
              SizedBox(
                  width: 400,
                  child: Column(
                    children: [
                      Text('Подразделение'),
                    ],
                  )),
              SizedBox(
                  width: 500,
                  child: Column(
                    children: [
                      Text('Должность'),
                    ],
                  )),

              SizedBox(
                width: 600,
                child:
                Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Color(0xFF000000)),
                        left: BorderSide(width: 1.0, color: Color(0xFF000000)),
                        right: BorderSide(width: 1.0, color: Color(0xFF000000)),
                        bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
                      ),
                    ),
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),

                    child: Text('ФИО')),
              ),
              SizedBox(
                width: 600,
                child:
                Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Color(0xFF000000)),
                        left: BorderSide(width: 1.0, color: Color(0xFF000000)),
                        right: BorderSide(width: 1.0, color: Color(0xFF000000)),
                        bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
                      ),
                    ),
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),

                    child: Text('ФИО')),
              ),
            ],
          )
        ])

    )
        )
*/


],)
    );
  }
}
