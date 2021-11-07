import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ad_book_2/models/filters.dart';
import 'package:ad_book_2/models/database.dart';
import 'package:ad_book_2/screens/filterWidget.dart';




class Filters extends StatelessWidget {
  final _controllerFIO = TextEditingController();
  final _controllerCorporation = TextEditingController();
  final _controllerDepartament = TextEditingController();
  final _controllerPhone = TextEditingController();
  final _controllerTypePhone = TextEditingController(text: "Все");

  //String _textsample = 'init FGH';
  //late Future<List> futuregetCorporation;



  List<String> lisCorp = [];
  List<String> lisDep = [];
  List<String> emp_list = [];
  //List<String> emp_list = ['dssd1', 'dssd2'];

  @override
  Widget build(BuildContext context) {
    var filters = context.watch<FiltersModel>();
    //var filterView = context.watch<FiltersModelView>();

    _controllerCorporation.text = filters.filters.controllerCorporation;
    //_controllerCorporation.text = 'init FGH';

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
              new Container(
              margin: const EdgeInsets.only(top: 10.0),
              child :ElevatedButton.icon(
                  onPressed: () async {
                    //modelDateBase.contactsForward();
                    //var p;
                    //p = filters.filters.controllerCorporation;
                    //print('5757657657: $_textsample');
                    //print('controllerCorporation: $p');
                    //filters.setFilters(
                    //    _controllerFIO.text, _controllerCorporation.text);
                    filters.setFilters(
                        _controllerFIO.text, filters.filters.controllerCorporation);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ), //
                  icon: Icon(Icons.search),
                  label: Text('Найти'),
                ),
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
                            onSaved: (value) {
                              // This optional block of code can be used to run
                              // code when the user saves the form.
                            },
                            validator: (value) {
                              return value.toString().contains('@')
                                  ? 'Do not use the @ char.'
                                  : null;
                            },
                          )),
                        ]))),

                RowFiltersButton(labelltext:'Организация', initialltext: _controllerCorporation.text, changeParentValue: filters.setFilter, ListData: emp_list, LoadListData: getCorporationList),
                RowFiltersButton(labelltext:'Подразделение', initialltext: _controllerDepartament.text, changeParentValue: filters.setFilter, ListData: emp_list, LoadListData: getDepartmentList),






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
                                        _controllerTypePhone.text = value.toString();
                                        // print('value-value-value' + value);
                                      },
                                      icon: Icon(Icons.filter_list),
                                    ),
                                    Expanded(
                                        child: TextFormField(
                                      enabled: false,
                                      controller: _controllerTypePhone,
                                      //initialValue: 'Все',
                                      onSaved: (value) {
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
                              onSaved: (value) {
                                // This optional block of code can be used to run
                                // code when the user saves the form.
                              },
                              validator: (value) {
                                return value.toString().contains('@')
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
