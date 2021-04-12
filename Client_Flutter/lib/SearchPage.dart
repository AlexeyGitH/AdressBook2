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

            new Row(children: [
          Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.cyan,
                  border: Border.all()),
              child: Row(children: [
                PopupMenuButton(
                  icon: Icon(Icons.arrow_drop_down),
                  itemBuilder: (BuildContext context) {
                    return <String>['All', 'One', 'Two', 'Free', 'Four']
                        .map((day) => PopupMenuItem(
                              child: Text(day),
                              value: day,
                            ))
                        .toList();
                  },
                  onSelected: (value) {
                    setState(() {
                      _currentSelectedValue = value;
                      /*var _curr = new CorporationList();
                          var _currentSelectedListf = _curr.getCorporation;
                          */
                    });
                    _controllerFIO.text = value;
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
                    setState(() {
                      dropdownValue = 'All';
                    });
                  },
                ),
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
                          /*
                items: <String>['All', 'One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                */

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
              ]))

/*
          Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
              child: FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 16.0),
                        hintText: 'Please select expense',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    isEmpty: _currentSelectedValue == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _currentSelectedValue,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _currentSelectedValue = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              )),
*/

/*
          new Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0)),
              child: new Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(children: [
                    PopupMenuButton(
                      icon: Icon(Icons.arrow_drop_down),
                      itemBuilder: (BuildContext context) {
                        return <String>['All', 'One', 'Two', 'Free', 'Four']
                            .map((day) => PopupMenuItem(
                                  child: Text(day),
                                  value: day,
                                ))
                            .toList();
                      },
                      onSelected: (value) {
                        setState(() {
                          _currentSelectedValue = value;
                          /*var _curr = new CorporationList();
                          var _currentSelectedListf = _curr.getCorporation;
                          */
                        });
                        _controllerFIO.text = value;
                      },
                    ),
                    Flexible(
                        child: TextFormField(
                      controller: _controllerFIO,
                      decoration: new InputDecoration(
                        //icon: Icon(Icons.arrow_drop_down),
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
                  ]))),

          //]*/
        ]));
  }
}

/*
PopupMenuButton(
            itemBuilder: (BuildContext bc) {
              return _options
                  .map((day) => PopupMenuItem(
                        child: Text(day),
                        value: day,
                      ))
                  .toList();
            },
            onSelected: (value) {
              setState(() {
                _selectedItem = value;
              });
            },
          ),

          */
Future<List<String>> _getData() async {
  var values = new List<String>();
  values.add("Horses");
  values.add("Goats");
  values.add("Chickens");
  values.add("Chickensdw");

  //throw new Exception("Danger Will Robinson!!!");

  await new Future.delayed(new Duration(seconds: 1));

  return values;
}

Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<String> values = snapshot.data;

  return new ListView.builder(
    itemCount: values.length,
    itemBuilder: (BuildContext context, int index) {
      print(index);

      return new Text(values[index]);
/*      
      return PopupMenuItem(
        child: Text(values[index]),
        value: values[index],
      );
*/
      // return Flexible(child: new Text('12345'));
/*
      return new Row(
        children: <Widget>[
          new ListTile(
            title: new Text(values[index]),
          ),
          new Divider(
            height: 2.0,
          ),
        ],
      );
      */
    },
  );
}

///https://www.russianfood.com/recipes/recipe.php?rid=125019

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
        )


        */
