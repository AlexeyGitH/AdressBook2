import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:admin/models/mainStatesModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'package:admin/models/database.dart';
import 'package:admin/ConstSystemAD.dart';
import 'package:admin/main.dart';

class MainAdminPage extends StatefulWidget {
  @override
  _MainAdminPage createState() => _MainAdminPage();
}

class _MainAdminPage extends State<MainAdminPage> {


  Widget build(BuildContext context) {


    final _storage = const FlutterSecureStorage();

    Future<ContactServer> _readContactsData() async {
      String? val = await _storage.read(key: session_token_name);
      String t_s = val ?? '';
      var _resp = await getContacts(t_s);
      return _resp;
    }


    return FutureBuilder(
        future: _readContactsData(),
        builder: (context, AsyncSnapshot<ContactServer> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return  Center(
                child: SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator()),
              );
            default:
              if (snapshot.hasError)
                return RefreshWidget();
              else if (snapshot.data == null) {
                return RefreshWidget();
              } else {
                ContactServer? vDBD = snapshot.data;
                if (vDBD == null) {
                  return RefreshWidget();
                } else {
                  if (vDBD.authServer == true) {
                    return TableMainArea(dataServer: vDBD);
                  } else {return RefreshWidget();}
          }}
        }}

    );


  }
}

class TableMainArea extends StatefulWidget {
  ContactServer dataServer;
  TableMainArea({required this.dataServer});

  @override
  _TableMainArea createState() => _TableMainArea();
}

class _TableMainArea extends State<TableMainArea> {

  final ScrollController _firstController = ScrollController();
  final ScrollController _firstControllerV = ScrollController();

  final dataKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;
    double MainWidth = MediaQuery.of(context).size.width*0.95;

    AppBar _appBar = AppBar(
      title: Text("Contact list"),
    );



    if (screenSize.width > 1000) {
      return PC_List(appBar: _appBar, MainWidth: MainWidth) ;
    }else
    {return Text('Mobile view');}


    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar,
        body:

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children:[
        Container(
        color: Colors.lightBlueAccent,
        width: MainWidth,
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[

            Text('privet'),

          ],
        ))],
        )


    );
  }
}

class PC_List extends StatefulWidget {
  AppBar appBar;
  double MainWidth;

  PC_List({required this.appBar, required this.MainWidth});

  @override
  _PC_List createState() => _PC_List();
}

class _PC_List extends State<PC_List> {

  @override
  Widget build(BuildContext context) {
    var widthTelephone = (widget.MainWidth*(1-1.2/5)-80)/4;
    if (widthTelephone > 170) {widthTelephone = 170;}
    var widthFIO = (widget.MainWidth-widthTelephone-80)/4*1.2;
    var widthElement = (widget.MainWidth-widthFIO-widthTelephone-80)/3;

    print('00:' + widget.MainWidth.toString() + ' 1:' + widthTelephone.toString() + ' 3:' + widthElement.toString()+ ' 1:' + widthFIO.toString());

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: widget.appBar,
        body:

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Container(
                color: Colors.lightBlueAccent,
                width: widget.MainWidth,
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [




                          Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child:

                                  CircleAvatar(
                                    radius: 30,

                                    //backgroundColor: Colors.brown.shade800,
                                    child:
                                  Image.network(
                                    'http://'+ipLocalhost + '/static/img/default/male.png',
                                    //'http://'+ipLocalhost,
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



                          ),







                      Container(
                        width: widthFIO,
                padding: const EdgeInsets.all(5),
          child:  Center(child:Text('ФИО',style: TextStyle(fontWeight: FontWeight.bold),)),
        ),
                      Container(
                        width: widthElement,
                        decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  width: 1.0, color: Colors.grey),
                              left: BorderSide(
                                  width: 1.0, color: Colors.grey),
                            )
                        ),

                        padding: const EdgeInsets.all(5),
                        child:  Center(child:Text('Организация',style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                      Container(
                        width: widthElement,
                        decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  width: 1.0, color: Colors.grey),
                              left: BorderSide(
                                  width: 1.0, color: Colors.grey),
                            )
                        ),

                        padding: const EdgeInsets.all(5),
                        child:  Center(child:Text('Подразделение',style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                      Container(
                        width: widthElement,
                        decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  width: 1.0, color: Colors.grey),
                              left: BorderSide(
                                  width: 1.0, color: Colors.grey),
                            )
                        ),

                        padding: const EdgeInsets.all(5),
                        child:  Center(child:Text('Должность',style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                      Container(
                        width: widthTelephone,
                        decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  width: 1.0, color: Colors.grey),
                              left: BorderSide(
                                  width: 1.0, color: Colors.grey),
                            )
                        ),

                        padding: const EdgeInsets.all(5),
                        child:  Center(child:Text('Телефон',style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),


                    ]),





                    //listview
                    Text('privet'),

                  ],
                ))],
        )


    );
  }
}