//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:admin/models/mainStatesModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'package:admin/models/database.dart';
import 'package:admin/ConstSystemAD.dart';
import 'package:admin/main.dart';
import 'package:hovering/hovering.dart';
import 'package:admin/screens/MainAdminPage_PC.dart';
import 'package:admin/screens/MainAdminPage_Mb.dart';

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
              return Center(
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
                  } else {
                    return RefreshWidget();
                  }
                }
              }
          }
        });
  }
}

class TableMainArea extends StatefulWidget {
  ContactServer dataServer;

  TableMainArea({required this.dataServer});

  @override
  _TableMainArea createState() => _TableMainArea();
}

class _TableMainArea extends State<TableMainArea> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double MainWidth = MediaQuery.of(context).size.width * 0.95;

    AppBar _appBar = AppBar(
      title: Text("Contact list"),
    );

    if (screenSize.width > 1000) {
      return PC_List(
        appBar: _appBar,
        MainSize: screenSize,
        dataServer: widget.dataServer,
      );
    } else {
      return Mb_List(
        appBar: _appBar,
        MainSize: screenSize,
        dataServer: widget.dataServer,
      );
    }
  }
}

