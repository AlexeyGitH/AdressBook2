import 'package:flutter/material.dart';
import 'package:ad_book_2/DataBase.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final String title = 'Поиск контакта';

  final _controllerFIO = TextEditingController();
  final _controllerPhone = TextEditingController();

  //String dropdownValue = 'All';
  //var dropDownItemsMap = new Map();
  List<String> listtt = [];
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
                              controller: _controllerFIO,
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
                                        return new Text('loading...');
                                      default:
                                        if (snapshot.hasError)
                                          return new Text(
                                              'Error: ${snapshot.error}');
                                        else
                                          listtt = new List();

                                        snapshot.data.forEach((branchItem) {
                                          //listItemNames.add(branchItem.itemName);
                                          int index =
                                              snapshot.data.indexOf(branchItem);
                                          // dropDownItemsMap[index] = branchItem;

                                          listtt.insert(
                                              index, branchItem.toString());
                                          //listtt.insert(0, 'fff');
                                        });

                                        return PopupMenuButton(
                                          captureInheritedThemes: false,
                                          icon: Icon(Icons.filter_list),
                                          itemBuilder: (BuildContext context) {
                                            return listtt
                                                .map((day) => PopupMenuItem(
                                                      child: Text(day),
                                                      value: day,
                                                    ))
                                                .toList();
                                          },
                                          onSelected: (value) {
                                            setState(() {
                                              _controllerFIO.text = value;
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
                              controller: _controllerFIO,
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
                                        return new Text('loading...');
                                      default:
                                        if (snapshot.hasError)
                                          return new Text(
                                              'Error: ${snapshot.error}');
                                        else
                                          listtt = new List();

                                        snapshot.data.forEach((branchItem) {
                                          //listItemNames.add(branchItem.itemName);
                                          int index =
                                              snapshot.data.indexOf(branchItem);
                                          // dropDownItemsMap[index] = branchItem;

                                          listtt.insert(
                                              index, branchItem.toString());
                                          //listtt.insert(0, 'fff');
                                        });

                                        return PopupMenuButton(
                                          captureInheritedThemes: false,
                                          icon: Icon(Icons.filter_list),
                                          itemBuilder: (BuildContext context) {
                                            return listtt
                                                .map((day) => PopupMenuItem(
                                                      child: Text(day),
                                                      value: day,
                                                    ))
                                                .toList();
                                          },
                                          onSelected: (value) {
                                            setState(() {
                                              _controllerFIO.text = value;
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
                              child: Row(children: [
                                Icon(Icons.clear),
                                TextFormField(
                                  controller: _controllerPhone,
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
                                            return new Text('loading...');
                                          default:
                                            if (snapshot.hasError)
                                              return new Text(
                                                  'Error: ${snapshot.error}');
                                            else
                                              listtt = new List();

                                            snapshot.data.forEach((branchItem) {
                                              //listItemNames.add(branchItem.itemName);
                                              int index = snapshot.data
                                                  .indexOf(branchItem);
                                              // dropDownItemsMap[index] = branchItem;

                                              listtt.insert(
                                                  index, branchItem.toString());
                                              //listtt.insert(0, 'fff');
                                            });

                                            return PopupMenuButton(
                                              captureInheritedThemes: false,
                                              icon: Icon(Icons.filter_list),
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return listtt
                                                    .map((day) => PopupMenuItem(
                                                          child: Text(day),
                                                          value: day,
                                                        ))
                                                    .toList();
                                              },
                                              onSelected: (value) {
                                                setState(() {
                                                  _controllerPhone.text = value;
                                                });
                                              },
                                            );
                                        }
                                      },
                                    ), //
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
                                )
                              ]),
                            ),
                          ]))),
                ]))));
  }
}

///https://www.russianfood.com/recipes/recipe.php?rid=125019
