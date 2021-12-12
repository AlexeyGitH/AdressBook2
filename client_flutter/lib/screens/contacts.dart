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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:
            Text('Address book', style: Theme.of(context).textTheme.headline1),
        //backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () =>
                //Navigator.pushReplacementNamed(context, '/filters'),
                Navigator.pushNamed(context, '/filters'),
          ),
          /*
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () => Navigator.pushNamed(context, '/test'),
          ),*/
        ],
      ),
      body: DataViewList(),

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

    var screenSize = MediaQuery.of(context).size;
    var cardNumber = (screenSize.width~/Width_card_const == 0) ? 1: screenSize.width~/Width_card_const;

    print('screenSize: '+ screenSize.width.toString());
    print('cardNumber (500): '+ cardNumber.toString());

    if (screenSize.width > 1000) {
      return DataViewListTwo(filters: filters, dataBaseData: dataBaseData, cardNumber: cardNumber);
    }else
    //{return DataViewListOne(filters: filters, dataBaseData: dataBaseData);}
    {return DataViewListTwo(filters: filters, dataBaseData: dataBaseData, cardNumber: cardNumber);}

  }
}

class DataViewListOne extends StatefulWidget {
  FiltersModel filters;
  DataBaseData dataBaseData;

  DataViewListOne({required this.filters, required this.dataBaseData});

  @override
  _DataViewListOne createState() => _DataViewListOne();
}

class _DataViewListOne extends State<DataViewListOne> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: getContactList(widget.filters),
        initialData: widget.dataBaseData,
        builder: (BuildContext context, AsyncSnapshot<DataBaseData> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return SingleChildScrollView(child:
              Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3 - 20,
                  child: Center(
                    child: SizedBox(
                        width: 150,
                        height: 150,
                        child: CircularProgressIndicator()),
                  ),
                ),
                const Divider(height: 4, color: Colors.black),
                Text('Loading..', style: Theme.of(context).textTheme.headline5),
              ])
              );
            default:
              if (snapshot.hasError)
                return RefreshWidget(changeValueView: widget.filters.setviewResume);
              else if (snapshot.data == null) {
                return RefreshWidget(changeValueView: widget.filters.setviewResume);
              } else {
                DataBaseData? vDBD = snapshot.data;
                if (vDBD == null) {
                  return RefreshWidget(changeValueView: widget.filters.setviewResume);
                } else {
                  if (vDBD.viewResume == 1) {
                    return
                      Column(
                        //mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(child :
                            ListPageList(
                              serverdata: vDBD.database.contacts,
                            )),
                            Divider(height: 1, color: Colors.blueGrey),
                            Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Row(
                                children: [
                                  ArrowBottomWidget(0, false, widget.filters.datalistcount, vDBD.database.countlist, widget.filters.contactsChangeRange),
                                  Spacer(),
                                  ArrowBottomWidget(1, vDBD.blockrightarrow, widget.filters.datalistcount, vDBD.database.countlist, widget.filters.contactsChangeRange),
                                ],
                              ),
                            ),                    ]);


                  } else {
                    return RefreshWidget(
                        changeValueView: widget.filters.setviewResume);
                  }
                }
                return Text('Result: ${snapshot.data}');
              }
          }

        });
  }
}

class DataViewListTwo extends StatefulWidget {
  FiltersModel filters;
  DataBaseData dataBaseData;
  int cardNumber;

  DataViewListTwo({required this.filters, required this.dataBaseData, required this.cardNumber});

  @override
  _DataViewListTwo createState() => _DataViewListTwo();
}

class _DataViewListTwo extends State<DataViewListTwo> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: getContactList(widget.filters),
        initialData: widget.dataBaseData,
        builder: (BuildContext context, AsyncSnapshot<DataBaseData> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return SingleChildScrollView(child:
              Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3 - 20,
                  child: Center(
                    child: SizedBox(
                        width: 150,
                        height: 150,
                        child: CircularProgressIndicator()),
                  ),
                ),
                const Divider(height: 4, color: Colors.black),
                Text('Loading..', style: Theme.of(context).textTheme.headline5),
              ])
              );
            default:
              if (snapshot.hasError)
                return RefreshWidget(changeValueView: widget.filters.setviewResume);
              else if (snapshot.data == null) {
                return RefreshWidget(changeValueView: widget.filters.setviewResume);
              } else {
                DataBaseData? vDBD = snapshot.data;
                if (vDBD == null) {
                  return RefreshWidget(changeValueView: widget.filters.setviewResume);
                } else {
                  if (vDBD.viewResume == 1) {
                    return
                      Column(
                        //mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(child :
                            GridPageList(
                            //  GridPageListCopy(
                                serverdata: vDBD.database.contacts, cardNumber:widget.cardNumber
                            ),
                            //ListPageList(serverdata: vDBD.database.contacts),

                             ),
                            Divider(height: 1, color: Colors.blueGrey),
                            Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Row(
                                children: [
                                  ArrowBottomWidget(0, false, widget.filters.datalistcount, vDBD.database.countlist, widget.filters.contactsChangeRange),
                                  Spacer(),
                                  ArrowBottomWidget(1, vDBD.blockrightarrow, widget.filters.datalistcount, vDBD.database.countlist, widget.filters.contactsChangeRange),
                                ],
                              ),
                            ),                    ]);


                  } else {
                    return RefreshWidget(
                        changeValueView: widget.filters.setviewResume);
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

class ItemCard{
  String name;
  String icon;
  String value;
  ItemCard({
    required this.name,
    required this.icon,
    required this.value,
  });
}

class ListPageList extends StatefulWidget {
  List<ContactItem> serverdata;
//  bool blockrightarrow;
//  int limit_const;
//  int count_data;
//  final Function(int,int,int) changeCount;

  //ListPageList({required this.serverdata, required this.blockrightarrow, required this.limit_const, required this.count_data, required this.changeCount});
  ListPageList({required this.serverdata});

  @override
  _ListPageList createState() => _ListPageList();
}

class _ListPageList extends State<ListPageList> {
  @override
  Widget build(BuildContext context) {
    //print('12345');
    // print('datalist  ;22; ${serverdata.database.contacts[0].firstname}');

    //  return Text('22131231212');



    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
          itemCount: widget.serverdata.length,
          itemBuilder: (context, index) {
            var postPone = widget.serverdata[index];

            List<ItemCard> cardContact = [];
            cardContact.add(ItemCard(name: "Организация", icon: '', value: postPone.corporation.toString()));
            cardContact.add(ItemCard(name: "Должность", icon: '', value: postPone.position.toString()));
            cardContact.add(ItemCard(name: "Подразделение", icon: '', value: postPone.department.toString()));
            cardContact.add(ItemCard(name: "Дата рождения", icon: '', value: postPone.birthdate.toString()));
            cardContact.add(ItemCard(name: "Рабочий тел.", icon: 'p', value: postPone.workphone.toString()));
            cardContact.add(ItemCard(name: "Мобильный тел.", icon: 'p', value: postPone.mobilephone.toString()));
            cardContact.add(ItemCard(name: "Почта", icon: 'e', value: postPone.mail.toString()));

            //print(ipLocalhost + postPone.photo.toString());
            return new Container(
                decoration: myBoxDecoration(),
                margin: const EdgeInsets.all(6.0),
                padding: const EdgeInsets.all(3.0),
                child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //Expanded(
                        //child:
                        new ConstrainedBox(
                            constraints: new BoxConstraints(
                              maxHeight: 310.0,
                            ),
                            child:

                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child:
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child:
                              Image.network(
                                'http://'+ipLocalhost + postPone.photo.toString(),
                                //'',
                                //fit: BoxFit.fitHeight,
                                errorBuilder: (context, error, stackTrace) {
                                  //print(error);
                                  return Image.asset(
                                    'assets/NoPhoto.png',
                                    //fit: BoxFit.fitHeight,
                                  );
                                },
                              )

                            )



                        )),
                     // ),
                      Expanded(
                          flex: 1,
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
                  ContactValues(cardContact),

                ]));
          },
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


class ContactValues extends StatelessWidget {
  List<ItemCard> cardContact;

  ContactValues(this.cardContact);

  @override
  Widget build(BuildContext context) {
    return Table(
      // textDirection: TextDirection.rtl,
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      //border:TableBorder.all(width: 1.0,color: Colors.red),
      columnWidths: {
        0: FixedColumnWidth(110.0), // fixed to 100 width
        1: FixedColumnWidth(25.0),
        2: FlexColumnWidth(), //fixed to 100 width
      },

      children: cardContact
          .map((itContact) => TableRow(
          /*        decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 0.1, color: Colors.blueGrey),
                  )
      ),*/
                  children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 3.0, top: 3.0),
                        child: Text(itContact.name,
                            style: new TextStyle(
                                fontSize: 14.0, color: Colors.black))),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Container(
                            padding: EdgeInsets.only(bottom: 3.0, top: 3.0),
                            child: Center(child: _getIcon(itContact.icon)))),
                    Container(
                        padding: EdgeInsets.only(bottom: 3.0, top: 3.0),
                        child: Text(itContact.value,
                            style: new TextStyle(
                                fontSize: 14.0, color: Colors.indigo[900]))),
                  ]))
          .toList(),
    );
  }
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
  int datalistcount;
  int total_count;
  final Function(int, int) changeCount;


  ArrowBottomWidget(this._kindButton, this._blockArrow, this.datalistcount, this.total_count, this.changeCount);

  @override
  Widget build(BuildContext context) {
    Color? colorarrow_r;
    Color? colorarrow_l;
    //Waiting spiner ... ... ..
    colorarrow_r = _blockArrow == true ? Colors.blueGrey[600] : Colors.blue;
    colorarrow_l = (total_count == 0 || datalistcount==0) ? Colors.blueGrey[600] : Colors.blue;

    return new SizedBox(
      height: 40.0,
      width: 40.0,
      child: new IconButton(
          padding: new EdgeInsets.all(0.0),
          color: _kindButton == 1 ? colorarrow_r : colorarrow_l,
          icon: _kindButton == 1
              ? new Icon(Icons.arrow_right, size: 40.0)
              : new Icon(Icons.arrow_left, size: 40.0),
          onPressed: () {
            //print(total_count.toString() + "//" +  datalistcount.toString());
            //if (_blockArrow != true) {
            if (_kindButton == 1 ? colorarrow_r == Colors.blue : colorarrow_l== Colors.blue) {
              changeCount(_kindButton, total_count);
            }
          }),
    );
  }
}






class GridPageListCopy extends StatefulWidget {
  List<ContactItem> serverdata;
  int cardNumber;
  GridPageListCopy({required this.serverdata, required this.cardNumber});

  @override
  _GridPageListCopy createState() => _GridPageListCopy();
}

class _GridPageListCopy extends State<GridPageListCopy> {
  @override
  Widget build(BuildContext context) {

    return GridView.count(crossAxisCount: widget.cardNumber,

        //childAspectRatio: MediaQuery.of(context).size.width /
        //    (MediaQuery.of(context).size.height / 1),
        childAspectRatio:1/2.5,

        controller: new ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,


        children:


        List.generate(widget.serverdata.length, (index) {
          var postPone = widget.serverdata[index];

          List<ItemCard> cardContact = [];
          cardContact.add(ItemCard(name: "Организация", icon: '', value: postPone.corporation.toString()));
          cardContact.add(ItemCard(name: "Должность", icon: '', value: postPone.position.toString()));
          cardContact.add(ItemCard(name: "Подразделение", icon: '', value: postPone.department.toString()));
          cardContact.add(ItemCard(name: "Дата рождения", icon: '', value: postPone.birthdate.toString()));
          cardContact.add(ItemCard(name: "Рабочий тел.", icon: 'p', value: postPone.workphone.toString()));
          cardContact.add(ItemCard(name: "Мобильный тел.", icon: 'p', value: postPone.mobilephone.toString()));
          cardContact.add(ItemCard(name: "Почта", icon: 'e', value: postPone.mail.toString()));



          return new




          Container(
              decoration: myBoxDecoration(),
              margin: const EdgeInsets.all(6.0),
              padding: const EdgeInsets.all(3.0),
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //Expanded(
                    //child:
                    new ConstrainedBox(
                        constraints: new BoxConstraints(
                          maxHeight: 310.0,
                        ),
                        child:

                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child:
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child:
                                Image.network(
                                  'http://'+ipLocalhost + postPone.photo.toString(),
                                  //'',
                                  //fit: BoxFit.fitHeight,
                                  errorBuilder: (context, error, stackTrace) {
                                    //print(error);
                                    return Image.asset(
                                      'assets/NoPhoto.png',
                                      //fit: BoxFit.fitHeight,
                                    );
                                  },
                                )

                            )



                        )),
                    // ),
                    Expanded(
                        flex: 1,
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
                ContactValues(cardContact),

              ]))













          ;
        }



        )

    );
  }
}













class GridPageList extends StatefulWidget {
  List<ContactItem> serverdata;
  int cardNumber;
  GridPageList({required this.serverdata, required this.cardNumber});

  @override
  _GridPageList createState() => _GridPageList();
}

class _GridPageList extends State<GridPageList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.serverdata.length,
        itemBuilder: (context, index) {
          var postPone = widget.serverdata[index];

          List<ItemCard> cardContact = [];
          cardContact.add(ItemCard(
              name: "Организация",
              icon: '',
              value: postPone.corporation.toString()));
          cardContact.add(ItemCard(
              name: "Должность",
              icon: '',
              value: postPone.position.toString()));
          cardContact.add(ItemCard(
              name: "Подразделение",
              icon: '',
              value: postPone.department.toString()));
          cardContact.add(ItemCard(
              name: "Дата рождения",
              icon: '',
              value: postPone.birthdate.toString()));
          cardContact.add(ItemCard(
              name: "Рабочий тел.",
              icon: 'p',
              value: postPone.workphone.toString()));
          cardContact.add(ItemCard(
              name: "Мобильный тел.",
              icon: 'p',
              value: postPone.mobilephone.toString()));
          cardContact.add(ItemCard(
              name: "Почта", icon: 'e', value: postPone.mail.toString()));

          //print(ipLocalhost + postPone.photo.toString());
          if (index%widget.cardNumber==0) {

          }

          List<Widget> wChildren = [];
          for (var i = 0; i < 2; i++)
            {
              List<Widget> d = [];
              for (var w = 0; w < 2; w++)

                {
     
                  d.add(Text((w+i).toString()));
                }
              wChildren.add(Row(children: d));
            }

return Column(children: wChildren);


          //  return Text('ff');

/*
          new ListView.builder
            (
              itemCount: litems.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return new Text(litems[index]);
              }


*/
        /*  return Column(
            children: [Row(children:[Text('1'), Text('2')]), Row(children:[Text('3'), Text('4')])]
          );*/


        });



  }
}
