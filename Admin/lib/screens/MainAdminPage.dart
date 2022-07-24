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
    var postPone = widget.dataServer;

    var aa = dataKey.currentContext;
    if (aa != null){
      Scrollable.ensureVisible(aa);}


    final _appBar = AppBar(
      title: Text("Contact list"),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar,
        body:
        Column(children: [
          Container(
            //width: 1400,
              height: MediaQuery.of(context).size.height-_appBar.preferredSize.height.round()-MediaQuery.of(context).viewPadding.top,
              //height: 136,
              child:
              Scrollbar(
                //thumbVisibility: screenSize.width <= 600 ? true:false,
                  trackVisibility: screenSize.width <= 600 ? true:false,
                  controller: _firstController,
                  child:

                  SingleChildScrollView(
                      scrollDirection: Axis. horizontal,
                      controller: _firstController,
                      child:
                      Column(children: [

                        Text('privet'),

                      ],)
                  ))),
        ],)
    );
  }
}

