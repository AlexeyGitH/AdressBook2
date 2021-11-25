import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ad_book_2/models/filters.dart';
import 'package:ad_book_2/models/database.dart';
import 'package:ad_book_2/models/PostContact.dart';
import 'package:ad_book_2/ConstSystemAD.dart';

List<String> lisCorp = [];

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Address book', style: Theme.of(context).textTheme.headline1),
        //backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/filters'),
          ),
          /*
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () => Navigator.pushNamed(context, '/test'),
          ),*/
        ],
      ),
      body: DataViewList(),

      /*
      Container(
        //color: Colors.yellow,
        child: Column(
          children: [
            /*
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: DataViewList(),
              ),
            ),
            */
            DataViewList(),
          ],
        ),
      ),
      */
    );
  }
}

class DataViewList extends StatefulWidget {
  @override
  _DataViewList createState() => _DataViewList();
}

class _DataViewList extends State<DataViewList> {
  @override
  Widget build(BuildContext context) {
    var filters = context.watch<FiltersModel>();

    DataBaseData dataBaseData = new DataBaseData(
        datalistcount: 0,
        database: new ContactServer(
            countlist: 0, contacts: new List<ContactItem>.empty()),
        blockrightarrow: false,
        viewResume: 0);

    return FutureBuilder(
        future: getContactList(filters),
        initialData: dataBaseData,
        builder: (BuildContext context, AsyncSnapshot<DataBaseData> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Center(
                    child: SizedBox(
                        width: 150,
                        height: 150,
                        child: CircularProgressIndicator()),
                  ),
                ),
                const Divider(height: 4, color: Colors.black),
                Text('Loading..', style: Theme.of(context).textTheme.headline5),
              ]);
            default:
              if (snapshot.hasError)
                return RefreshWidget(changeValueView: filters.setviewResume);
              else if (snapshot.data == null) {
                return RefreshWidget(changeValueView: filters.setviewResume);
              } else {
                DataBaseData? vDBD = snapshot.data;
                if (vDBD == null) {
                  return RefreshWidget(changeValueView: filters.setviewResume);
                } else {
                  if (vDBD.viewResume == 1) {
                    return ListPageList(
                        serverdata: vDBD.database.contacts,
                        blockrightarrow: vDBD.blockrightarrow,
                        limit_const: Limit_const,
                        count_data: vDBD.database.countlist,
                        changeCount: filters.contactsChangeRange
                    );
                  } else {
                    return RefreshWidget(
                        changeValueView: filters.setviewResume);
                  }
                }
                return Text('Result: ${snapshot.data}');
              }
          }

        });
  }
}

class RefreshWidget extends StatefulWidget {
  final Function(int) changeValueView;

  RefreshWidget({required this.changeValueView});

  @override
  _RefreshWidget createState() => _RefreshWidget();
}

class _RefreshWidget extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) {
    return new Column(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height / 1.3,
        child: Center(
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
            onPressed: () {
              widget.changeValueView(0);
            },
            child: Icon(
              Icons.refresh,
              size: 150,
            ),
          ),
        ),
      ),
    ]);
  }
}

class ListPageList extends StatefulWidget {
  List<ContactItem> serverdata;
  bool blockrightarrow;
  int limit_const;
  int count_data;
  final Function(int,int,int) changeCount;

  ListPageList({required this.serverdata, required this.blockrightarrow, required this.limit_const, required this.count_data, required this.changeCount});

  @override
  _ListPageList createState() => _ListPageList();
}

class _ListPageList extends State<ListPageList> {
  @override
  Widget build(BuildContext context) {
    //print('12345');
    // print('datalist  ;22; ${serverdata.database.contacts[0].firstname}');

    //  return Text('22131231212');

    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
          itemCount: widget.serverdata.length,
          itemBuilder: (context, index) {
            var postPone = widget.serverdata[index];
            return new Container(
                decoration: myBoxDecoration(),
                margin: const EdgeInsets.all(6.0),
                padding: const EdgeInsets.all(3.0),
                child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Image.network(
                              ipLocalhost + postPone.image.toString(),
                              fit: BoxFit.fitHeight,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/NoPhoto.png',
                                  height: 100,
                                  width: 100,
                                );
                                /*Container(
                          color: Colors.amber,
                          alignment: Alignment.center,
                          child: const Text(
                            'Whoops!',
                            style: TextStyle(fontSize: 30),
                          ),
                        );*/
                              },
                            )),
                      ),
                      Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              Row(children: [
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Статус: ',
                                            style: new TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: postPone.status
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color:
                                                          Colors.green[900])),
                                            ],
                                          ),
                                        ))),
                              ]),
                              Row(children: [
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          postPone.firstname.toString() +
                                              " " +
                                              postPone.middlename.toString() +
                                              " " +
                                              postPone.lastname.toString(),
                                          style: new TextStyle(
                                            //backgroundColor: Colors.blue,
                                            fontFamily: 'Quicksand',
                                            fontSize: 20.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ))),
                              ])
                            ],
                          )),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.all(3.0),
                      child: Column(
                        children: [
                          /////////
                          widgetADPropertyValue('Организация',
                              postPone.corporation.toString(), ''),
                          widgetADPropertyValue(
                              'Должность', postPone.position.toString(), ''),
                          widgetADPropertyValue('Подразделение',
                              postPone.department.toString(), ''),
                          widgetADPropertyValue('Дата рождения',
                              postPone.birthdate.toString(), ''),

                          widgetADPropertyValue('Рабочий тел.',
                              postPone.workphone.toString(), 'p'),
                          widgetADPropertyValue('Мобильный тел.',
                              postPone.mobilephone.toString(), 'p'),
                          widgetADPropertyValue(
                              'Почта', postPone.mail.toString(), 'e'),
                        ],
                      )),
                ]));
          },
        )),
        Divider(height: 1, color: Colors.blueGrey),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Row(
            children: [
              ArrowBottomWidget(0, false, widget.limit_const, widget.count_data, widget.changeCount),
              Spacer(),
              ArrowBottomWidget(1, widget.blockrightarrow, widget.limit_const, widget.count_data, widget.changeCount),
            ],
          ),
        ),
      ],
    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      color: Colors.black38, //                   <--- border color
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.6),
        spreadRadius: 3,
        blurRadius: 2,
        offset: Offset(2, 3), // changes position of shadow
      ),
    ],
    //
  );
}

widgetADPropertyValue(String sProperty, String sValue, String sIcon) {
  return Container(
      padding: EdgeInsets.only(top: 3),
      child: Row(
        children: [
          Expanded(
              flex: 10,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  sProperty,
                  style: new TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              )),
          Expanded(
              flex: 2,
              child: Align(
                alignment: AlignmentDirectional.center,
                child: _getIcon(sIcon),
              )),
          Expanded(
              flex: 20,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  sValue,
                  style:
                      new TextStyle(fontSize: 14.0, color: Colors.indigo[900]),
                ),
              )),
        ],
      ));
}

Widget _getIcon(sIcon) {
  if (sIcon == 'p')
    return Icon(
      Icons.call,
      color: Colors.green[900],
      size: 14.0,
    );
  else if (sIcon == 'e')
    return Icon(
      Icons.alternate_email,
      color: Colors.green[900],
      size: 14.0,
    );
  else
    return Text(':', style: new TextStyle(fontSize: 14.0, color: Colors.black));
}

class ArrowBottomWidget extends StatelessWidget {
  final int _kindButton;
  final bool _blockArrow;
  int limit_const;
  int total_count;
  final Function(int, int, int) changeCount;


  ArrowBottomWidget(this._kindButton, this._blockArrow, this.limit_const, this.total_count, this.changeCount);

  @override
  Widget build(BuildContext context) {
    Color? colorarrow;
    //Waiting spiner ... ... ..
    colorarrow = _blockArrow == true ? Colors.blueGrey[600] : Colors.blue;

    return new SizedBox(
      height: 40.0,
      width: 40.0,
      child: new IconButton(
          padding: new EdgeInsets.all(0.0),
          color: colorarrow,
          icon: _kindButton == 1
              ? new Icon(Icons.arrow_right, size: 40.0)
              : new Icon(Icons.arrow_left, size: 40.0),
          onPressed: () {
            if (_blockArrow != true) {
              changeCount(_kindButton, limit_const, total_count);
            }
          }),
    );
  }
}
