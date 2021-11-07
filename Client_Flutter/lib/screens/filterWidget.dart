import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ad_book_2/models/filterWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RowFiltersButton extends StatefulWidget {
  final String labelltext;
  String initialltext;

  final Function(String) changeParentValue;
  final List<String> ListData;
  final Future Function(void  Function(int), void Function(List<String>)) LoadListData;

  RowFiltersButton({required this.labelltext, required this.initialltext, required this.changeParentValue, required this.ListData, required this.LoadListData});

  @override
  _RowFiltersButton createState() => _RowFiltersButton();


}

class _RowFiltersButton extends State<RowFiltersButton> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => FiltersModelView(widget.initialltext)),
        ChangeNotifierProvider<FiltersModelView>(
          create: (context) => FiltersModelView(widget.initialltext),
        ),
      ],
      child: FiltersViewRow(labelltext: widget.labelltext, initialltext: widget.initialltext, changeParentValue: widget.changeParentValue, ListData: widget.ListData, LoadListData: widget.LoadListData),
    );
  }
}

class FiltersViewRow extends StatefulWidget {
  final String labelltext;
  String initialltext;

  final Function(String) changeParentValue;
  final List<String> ListData;
  final Future Function(void  Function(int), void Function(List<String>)) LoadListData;

  FiltersViewRow({required this.labelltext, required this.initialltext, required this.changeParentValue, required this.ListData, required this.LoadListData});

  @override
  _FiltersViewRow createState() => _FiltersViewRow();
}

class _FiltersViewRow extends State<FiltersViewRow> {
  @override
  Widget build(BuildContext context) {
    var _valController = TextEditingController();
    var filterModelV = context.watch<FiltersModelView>();

    _valController.text = filterModelV.textValue;

    /*return new Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0)),
        child: new Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(children: [
              Flexible(
                  child: TextFormField(
                      controller: _valController,
                      decoration: new InputDecoration(
                        icon:
                            FiltersButton(controllervalue: widget.initialltext, changeParentValue: widget.changeParentValue),
                        labelText: widget.labelltext,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.0, color: Colors.white),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _valController.text = '';
                            widget.changeParentValue('');
                          },
                        ),
                      ),
                    onChanged: (text) {
                      filterModelV.setFilterValueonlyset(text);
                      widget.changeParentValue(text);
                      //print('widget text field: $text');
                    },
                  ))
            ])),
    );*/

    return new Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0
          )),
      child: new
      Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(
              children: [
                Expanded
                  (flex: 1,
                    child:
                         Container
                      (margin: EdgeInsets.only(right: 10.0),
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey),
                          color: Color.fromRGBO(100, 100, 150, 0.11),),
                        child: Row(
                          children: [
                             Expanded( // 1st use Expanded
                            child: Center(child:
                            FiltersButton(controllervalue: widget.initialltext, changeParentValue: widget.changeParentValue, ListData: widget.ListData, LoadListData: widget.LoadListData),
                            ))
                            /*                              new PopupMenuButton(
                                  itemBuilder: (context) =>[
                                    PopupMenuItem(
                                      value: "Все",
                                      child: Text("Все"),
                                    ),
                                    PopupMenuItem(
                                      value: "Доб",
                                      child: Text("Добавочный"),
                                   ),],
                                  onSelected: (value) {
                                    //_controllerTypePhone.text = value.toString();
                                  },
                                  icon: Icon
                                    (Icons.filter_list),
                                ),
*/
                          ],
                        ))),
                Expanded
                  (flex: 6,
                    child: TextFormField(
                      controller: _valController,
                      decoration: new InputDecoration(
                        labelText: widget.labelltext,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.0, color: Colors.white),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _valController.text = '';
                            widget.changeParentValue('');
                          },
                        ),
                      ),
                      onChanged: (text) {
                        filterModelV.setFilterValueonlyset(text);
                        widget.changeParentValue(text);
                        //print('widget text field: $text');
                      },
                    )),
              ]
          )),
    );


  }
}

class FiltersButton extends StatefulWidget {

  final List<String> ListData;
  final Future Function(void  Function(int), void Function(List<String>)) LoadListData;

  String controllervalue;
  final Function(String) changeParentValue;
  //Future<List> loaddataList;

  //FiltersButton({required this.controllervalue, required this.loaddataList});
  FiltersButton({required this.controllervalue, required this.changeParentValue, required this.ListData, required this.LoadListData});

  @override
  _FiltersButton createState() => _FiltersButton();
}

class _FiltersButton extends State<FiltersButton> {

  @override
  Widget build(BuildContext context) {

    var filterModelV = context.watch<FiltersModelView>();
    int typeV = filterModelV.filterView;
    List<String> lisCorp = filterModelV.listdata;

    if (typeV==0 && widget.ListData.length!=0) {
      filterModelV.setlistdataonlyset(widget.ListData);
      typeV=3;
      filterModelV.setFilterViewonlyset(3);
      lisCorp = widget.ListData;
    }
    else if (widget.ListData.length == 0 && typeV==0){
      typeV=1;
      filterModelV.setFilterViewonlyset(1);
    }

    //print('11-00 $typeV');

    if (typeV == 0) {
      return PopupMenuButton(

        icon: Icon(Icons.filter_list),

        itemBuilder: (BuildContext context) {
          return lisCorp
              .map((day) => PopupMenuItem(
                    child: Text(day),
                    value: day,
                  ))
              .toList();
        },
        onSelected: (value) {
          if (value == "Все") {
            filterModelV.setFilterValue('');
            widget.changeParentValue('');
          }
          else {
            widget.changeParentValue(value.toString());
            filterModelV.setFilterValue(value.toString());
          }
        },
      );
    }
    else if (typeV == 1) {
      return GestureDetector(
        onTap: () {
          filterModelV.setFilterView(2);
          Future f = widget.LoadListData(filterModelV.setFilterView, filterModelV.setlistdataonlyset);
        },
        child: SizedBox(width: 30, height: 30, child: Icon(Icons.filter_list))
          );

    }
    else if (typeV == 2) {
      return GestureDetector(
          onTap: () {
            //
          },
          child: SizedBox(width: 30, height: 30, child: CircularProgressIndicator()),);
    }
    else if (typeV == 3) {

       return PopupMenuButton(
        icon: SizedBox(width: 30, height: 30, child: Icon(Icons.filter_list, color: Colors.blue,)),
        itemBuilder: (BuildContext context) {
          return lisCorp
              .map((day) => PopupMenuItem(
            child: Text(day),
            value: day,
          ))
              .toList();
        },
        onSelected: (value) {
          if (value == "All") {
            filterModelV.setFilterValue('');
            widget.changeParentValue('');
          }
          else {
            widget.changeParentValue(value.toString());
            filterModelV.setFilterValue(value.toString());
          }
        },
      );

    }
    else  {
      return GestureDetector(
        onTap: () {
          filterModelV.setFilterView(2);
          widget.LoadListData(filterModelV.setFilterView, filterModelV.setlistdataonlyset);
          },
        child: SizedBox(width: 30, height: 30, child: Icon(Icons.error, color: Colors.blueGrey,)),);
    }

  }
}



/*
Future getCorporationList(void settypeV(int _val), void setlistdata(List<String> _list)) async {

  List listdate;
  //String ipLocalhost = "192.168.88.253:8000";
  try {
    var now1 = new DateTime.now();
    var uri = Uri.http(ipLocalhost, '/corporation/');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var now2 = new DateTime.now();
      // If the server did return a 200 OK response,
      // then parse the JSON.
      if (now2.millisecondsSinceEpoch - now1.millisecondsSinceEpoch < 500){
        await Future.delayed(Duration(milliseconds: 600));
      }
      listdate = jsonDecode(utf8.decode(response.bodyBytes));
      //listdate.map((s) => s as String).toList();
      setlistdata(listdate.map((s) => s as String).toList());
      settypeV(3);
      //print('list server'+listdate.length.toString());
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load contacts');
      listdate = [];
      settypeV(4);
      //print('CONTACTTS list server/ERROR-3');
    }
  }
  catch (e) {
    listdate = [];
    settypeV(4);
    //print('CONTACTTS list server/ERROR-4');
    print(e);
  }
  print('CONTACTTS list server DONE');
}

 */
