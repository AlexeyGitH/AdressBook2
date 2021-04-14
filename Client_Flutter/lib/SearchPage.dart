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

  String _currentSelectedValue;
  List _currentSelectedList;
/*
  void initState() {
    super.initState();

    // Start listening to changes.
    _controller.addListener(_controller);
  }
*/

  String dropdownValue = 'All';
  var dropDownItemsMap = new Map();
  List<String> listtt = [];
  //listtt.insert(0, 'fff');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body:
/*      
      new FutureBuilder(
        // future: _getData(),

        future: CorporationList().getCorporation,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return new Text('loading...');
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return createListView(context, snapshot);
          }
        },
      ),
*/
            new Container(
                margin: const EdgeInsets.all(16.0),
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
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  return new Text('loading...');
                                default:
                                  if (snapshot.hasError)
                                    return new Text('Error: ${snapshot.error}');
                                  else
                                    //return createListView(context, snapshot);
                                    listtt = new List();

                                  snapshot.data.forEach((branchItem) {
                                    //listItemNames.add(branchItem.itemName);
                                    int index =
                                        snapshot.data.indexOf(branchItem);
                                    dropDownItemsMap[index] = branchItem;

                                    //print("listtt " + branchItem.toString());
                                    //print("index " + index.toString());

                                    listtt.insert(index, branchItem.toString());
                                    //listtt.insert(0, 'fff');
                                  });

                                  return PopupMenuButton(
                                    icon: Icon(Icons.arrow_downward),
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
                                        _currentSelectedValue = value;
                                        dropdownValue = value;
                                        /*var _curr = new CorporationList();
                          var _currentSelectedListf = _curr.getCorporation;
                          */
                                      });
                                      _controllerFIO.text = value;
                                    },
                                  );
                              }
                            },
                          ), //
                          //
                          //
                          labelText: 'ФИО',
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, color: Colors.white),
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

/*
                new FutureBuilder(
                  // future: _getData(),

                  future: CorporationList().getCorporation,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return new Text('loading...');
                      default:
                        if (snapshot.hasError)
                          return new Text('Error: ${snapshot.error}');
                        else
                          //return createListView(context, snapshot);
                          listtt = new List();

                        snapshot.data.forEach((branchItem) {
                          //listItemNames.add(branchItem.itemName);
                          int index = snapshot.data.indexOf(branchItem);
                          dropDownItemsMap[index] = branchItem;

                          //print("listtt " + branchItem.toString());
                          //print("index " + index.toString());

                          listtt.insert(index, branchItem.toString());
                          //listtt.insert(0, 'fff');
                        });

                        return DropdownButton<String>(
                          icon: Icon(Icons.arrow_downward),
                          value: dropdownValue,
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: listtt
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        );
                    }
                  },
                ),
*/
                    ]))));
  }
}

Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<String> values = snapshot.data;

  return new ListView.builder(
    itemCount: values.length,
    itemBuilder: (BuildContext context, int index) {
      print(index);

      return new Text(values[index]);
    },
  );
}

///https://www.russianfood.com/recipes/recipe.php?rid=125019
