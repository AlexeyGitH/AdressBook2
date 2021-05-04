import 'package:flutter/material.dart';
import 'package:ad_book_2/DataBase.dart';
import 'main.dart';
import 'DataBase.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final String title = 'Поиск контакта';

  final _controllerFIO = TextEditingController();
  final _controllerCorporation = TextEditingController();
  final _controllerDepartament = TextEditingController();
  final _controllerPhone = TextEditingController();
  final _controllerTypePhone = TextEditingController(text: "Все");

  //String dropdownValue = 'All';
  //var dropDownItemsMap = new Map();
  List<String> lisCorp = [];
  List<String> lisDep = [];
  //listtt.insert(0, 'fff');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: new Column(children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      // print('fffff-222');
                      //
                      /*
                      List _d = await SearchContacts().postContacts(
                          _controllerFIO.text,
                          _controllerCorporation.text,
                          _controllerDepartament.text,
                          _controllerPhone.text,
                          _controllerTypePhone.text);
                          */
                      //print(_d);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BasePage(title: "Address book")),
                      );
                    },
                    //color: Colors.blue,
                    //textColor: Colors.white,
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
                                  borderSide: BorderSide(
                                      width: 0.0, color: Colors.white),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      _controllerFIO.text = '';
                                    });
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
                                          return new Text(
                                              'Error: ${snapshot.error}');
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
                                            setState(() {
                                              if (value == "All")
                                                _controllerCorporation.text =
                                                    "";
                                              else
                                                _controllerCorporation.text =
                                                    value;
                                            });
                                          },
                                        );
                                    }
                                  },
                                ), //
                                //
                                //
                                labelText: 'Организация',
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.0, color: Colors.white),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      _controllerCorporation.text = '';
                                    });
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
                                            setState(() {
                                              if (value == "All")
                                                _controllerDepartament.text =
                                                    "";
                                              else
                                                _controllerDepartament.text =
                                                    value;
                                            });
                                          },
                                        );
                                    }
                                  },
                                ), //
                                //
                                //
                                labelText: 'Подразделение',
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.0, color: Colors.white),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      _controllerDepartament.text = '';
                                    });
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
                                      setState(() {
                                        _controllerPhone.text = '';
                                      });
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
                ]))));
  }
}

///https://www.russianfood.com/recipes/recipe.php?rid=125019
