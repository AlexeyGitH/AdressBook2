import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ad_book_2/models/filters.dart';
import 'package:ad_book_2/models/database.dart';

class Filters extends StatelessWidget {
  final _controllerFIO = TextEditingController();
  final _controllerCorporation = TextEditingController();
  final _controllerDepartament = TextEditingController();
  final _controllerPhone = TextEditingController();
  final _controllerTypePhone = TextEditingController(text: "Все");

  List<String> lisCorp = [];
  List<String> lisDep = [];

  @override
  Widget build(BuildContext context) {
    var filters = context.watch<FiltersModel>();

    _controllerCorporation.text = filters.filters.controllerCorporation;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search contact',
            style: Theme.of(context).textTheme.headline1),
        //backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: new Column(children: [
                //RightArrowBottomWidgetSearch(),

                ElevatedButton.icon(
                  onPressed: () async {
                    //modelDateBase.contactsForward();
                    filters.setFilters(
                        _controllerFIO.text, _controllerCorporation.text);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ), //
                  icon: Icon(Icons.search),
                  label: Text('Найти'),
                ),

                new Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: new Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(children: [
                          Flexible(
                              child: TextFormField(
                            controller: _controllerFIO,
                            decoration: new InputDecoration(
                              //icon: Icon(Icons.arrow_drop_down),
                              //
                              //
                              //
                              //
                              labelText: 'ФИО',
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 0.0, color: Colors.white),
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  /*setState(() {
                                        _controllerFIO.text = '';
                                      }
                                      );*/
                                },
                              ),
                            ),
                            onSaved: (String value) {
                              // This optional block of code can be used to run
                              // code when the user saves the form.
                            },
                            validator: (String value) {
                              return value.contains('@')
                                  ? 'Do not use the @ char.'
                                  : null;
                            },
                          )),
                        ]))),











                new Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: new Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(children: [
                          Flexible(
                              child: TextFormField(
                                  controller: _controllerCorporation,
                                  decoration: new InputDecoration(
                                    //icon: Icon(Icons.arrow_drop_down),
                                    //
                                    icon:

                                    IconButton(
                                      icon: const Icon(Icons.filter_list),
                                      tooltip: 'Increase volume by 10',
                                      onPressed: () {

                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                            title: const Text('AlertDialog Title'),
                                            content: const Text('AlertDialog description'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'OK'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );

                                      },
                                    ),


                                    labelText: 'Организация',
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 0.0, color: Colors.white),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        _controllerCorporation.text = '';
                                      },
                                    ),

                                  )))
                        ]))),


















                new Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: new Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(children: [
                          Flexible(
                              child: TextFormField(
                            controller: _controllerCorporation,
                            decoration: new InputDecoration(
                              //icon: Icon(Icons.arrow_drop_down),
                              //
                              icon: new FutureBuilder(
                                // future: _getData(),

                                future: CorporationList().getCorporation,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                    case ConnectionState.waiting:
                                      //return new Text('loading...');
                                      return CircularProgressIndicator();
                                    default:
                                      if (snapshot.hasError)
                                      //return new Text('No signal..');
                                      {
                                        lisCorp = [];
                                        lisCorp.insert(0, "no..");
                                        return PopupMenuButton(
                                          //captureInheritedThemes: false,
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
                                            if (value == "All")
                                              _controllerCorporation.text = "";
                                            else
                                              _controllerCorporation.text =
                                                  value;
                                          },
                                        );
                                      }
                                      /*
                                              return
                                              new Text(
                                                'Error: ${snapshot.error}');
                                              */
                                      else
                                        //lisCorp = new List();
                                        lisCorp = [];

                                      snapshot.data.forEach((branchItem) {
                                        //listItemNames.add(branchItem.itemName);
                                        int index =
                                            snapshot.data.indexOf(branchItem);
                                        // dropDownItemsMap[index] = branchItem;

                                        lisCorp.insert(
                                            index, branchItem.toString());
                                        //listtt.insert(0, 'fff');
                                      });

                                      return PopupMenuButton(
                                        //captureInheritedThemes: false,
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
                                          if (value == "All")
                                            _controllerCorporation.text = "";
                                          else
                                            _controllerCorporation.text = value;
                                        },
                                      );
                                  }
                                },
                              ),
                              //
                              //
                              //
                              labelText: 'Организация',
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 0.0, color: Colors.white),
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _controllerCorporation.text = '';
                                },
                              ),
                            ),
                            onSaved: (String value) {
                              // This optional block of code can be used to run
                              // code when the user saves the form.
                            },
                            validator: (String value) {
                              return value.contains('@')
                                  ? 'Do not use the @ char.'
                                  : null;
                            },
                          )),
                        ]))),
                new Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: new Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(children: [
                          Flexible(
                              child: TextFormField(
                            controller: _controllerDepartament,
                            decoration: new InputDecoration(
                              //icon: Icon(Icons.arrow_drop_down),
                              //
                              icon: new FutureBuilder(
                                // future: _getData(),

                                future: DepartmentList().getDepartment,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                    case ConnectionState.waiting:
                                      //return new Text('loading...');
                                      return CircularProgressIndicator();
                                    default:
                                      if (snapshot.hasError)
                                        return new Text(
                                            'Error: ${snapshot.error}');
                                      else
                                        //lisDep = new List();
                                        lisDep = [];

                                      snapshot.data.forEach((branchItem) {
                                        //listItemNames.add(branchItem.itemName);
                                        int index =
                                            snapshot.data.indexOf(branchItem);
                                        // dropDownItemsMap[index] = branchItem;

                                        lisDep.insert(
                                            index, branchItem.toString());
                                        //listtt.insert(0, 'fff');
                                      });

                                      return PopupMenuButton(
                                        //captureInheritedThemes: false,
                                        icon: Icon(Icons.filter_list),
                                        itemBuilder: (BuildContext context) {
                                          return lisDep
                                              .map((day) => PopupMenuItem(
                                                    child: Text(day),
                                                    value: day,
                                                  ))
                                              .toList();
                                        },
                                        onSelected: (value) {
                                          /*setState(() {
                                                if (value == "All")
                                                  _controllerDepartament.text =
                                                  "";
                                                else
                                                  _controllerDepartament.text =
                                                      value;
                                              });*/
                                        },
                                      );
                                  }
                                },
                              ),
                              //
                              //
                              //
                              labelText: 'Подразделение',
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 0.0, color: Colors.white),
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  /*setState(() {
                                        _controllerDepartament.text = '';
                                      });*/
                                },
                              ),
                            ),
                            onSaved: (String value) {
                              // This optional block of code can be used to run
                              // code when the user saves the form.
                            },
                            validator: (String value) {
                              return value.contains('@')
                                  ? 'Do not use the @ char.'
                                  : null;
                            },
                          )),
                        ]))),
                new Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: new Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                                margin: EdgeInsets.only(right: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(color: Colors.grey),
                                  color: Color.fromRGBO(100, 100, 150, 0.11),
                                ),
                                child: Row(
                                  children: [
                                    new PopupMenuButton(
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: "Все",
                                          child: Text("Все"),
                                        ),
                                        PopupMenuItem(
                                          value: "Доб",
                                          child: Text("Добавочный"),
                                        ),
                                        PopupMenuItem(
                                          value: "Раб",
                                          child: Text("Рабочий"),
                                        ),
                                        PopupMenuItem(
                                          value: "Моб",
                                          child: Text("Мобильный"),
                                        ),
                                      ],
                                      onSelected: (value) {
                                        _controllerTypePhone.text = value;
                                        // print('value-value-value' + value);
                                      },
                                      icon: Icon(Icons.filter_list),
                                    ),
                                    Expanded(
                                        child: TextFormField(
                                      enabled: false,
                                      controller: _controllerTypePhone,
                                      //initialValue: 'Все',
                                      onSaved: (String value) {
                                        // This optional block of code can be used to run
                                        // code when the user saves the form.
                                      },
                                    )),
                                  ],
                                ))),
                        Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _controllerPhone,
                              decoration: new InputDecoration(
//
                                //
                                //
                                labelText: 'Телефон',
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.0, color: Colors.white),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    /*setState(() {
                                      _controllerPhone.text = '';
                                    });*/
                                  },
                                ),
                              ),
                              onSaved: (String value) {
                                // This optional block of code can be used to run
                                // code when the user saves the form.
                              },
                              validator: (String value) {
                                return value.contains('@')
                                    ? 'Do not use the @ char.'
                                    : null;
                              },
                            ))
                      ])),
                ),
              ]))),
    );
  }
}
