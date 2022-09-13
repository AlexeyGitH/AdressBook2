import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:admin/models/mainStatesModel.dart';
import 'package:admin/models/database.dart';
import 'package:admin/ConstSystemAD.dart';
import 'package:hovering/hovering.dart';

class PC_List extends StatefulWidget {
  AppBar appBar;
  Size MainSize;
  ContactServer dataServer;

  PC_List(
      {required this.appBar, required this.MainSize, required this.dataServer});

  @override
  _PC_List createState() => _PC_List();
}

class _PC_List extends State<PC_List> {
  @override
  Widget build(BuildContext context) {
    // var mainConstModel = context.watch<MainConstModel>();

    double MainWidth = widget.MainSize.width * 0.95;
    double MainHeight = widget.MainSize.height;
    int height_app = widget.appBar.preferredSize.height.round();
    int height_header_table = 45;

    var widthTelephone = (MainWidth * (1 - 1.2 / 5) - 80) / 4;
    if (widthTelephone > 180) {
      widthTelephone = 180;
    }
    var widthFIO = (MainWidth - widthTelephone - 80) / 4 * 1.2;
    var widthElement = (MainWidth - widthFIO - widthTelephone - 80) / 3;

    //print('00:' + MainWidth.toString() + ' 1:' + widthTelephone.toString() + ' 3:' + widthElement.toString()+ ' 1:' + widthFIO.toString());

    return Scaffold(
      //backgroundColor: Colors.white,
        backgroundColor: Colors.grey[100],
        appBar: widget.appBar,
        body:

        //listW(widget.dataServer.contacts),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //color: Colors.lightBlueAccent,
              //color: Colors.white,
                color: Colors.grey[100],
                width: MainWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      //color: Colors.grey,
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent[100],
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        height: height_header_table.toDouble(),
                        width: MainWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: widthFIO + 80,
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                    child: Text(
                                      'ФИО',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Container(
                                width: widthElement,
                                decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          width: 0.3, color: (Colors.grey[600])!),
                                      left: BorderSide(
                                          width: 0.3, color: (Colors.grey[600])!),
                                    )),
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                    child: Text(
                                      'Организация',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Container(
                                width: widthElement,
                                decoration: BoxDecoration(
                                    border: Border(
                                      /*right: BorderSide(
                                      width: 1.0, color: Colors.grey),
                                  left: BorderSide(
                                      width: 1.0, color: Colors.grey),*/
                                    )),
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                    child: Text(
                                      'Подразделение',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Container(
                                width: widthElement,
                                decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          width: 0.3, color: (Colors.grey[600])!),
                                      left: BorderSide(
                                          width: 0.3, color: (Colors.grey[600])!),
                                    )),
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                    child: Text(
                                      'Должность',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Container(
                                width: widthTelephone,
                                decoration: BoxDecoration(
                                    border: Border(
                                      /*right: BorderSide(
                                      width: 1.0, color: Colors.grey),
                                  left: BorderSide(
                                      width: 1.0, color: Colors.grey),*/
                                    )),
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                    child: Text(
                                      'Телефон',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ])),
                    Container(
                      height: MainHeight - height_app - height_header_table,
                      child: listW(
                        contacts: widget.dataServer.contacts,
                        widthElement: widthElement,
                        widthFIO: widthFIO,
                        widthTelephone: widthTelephone,
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}

class listW extends StatefulWidget {
  List<ContactItem> contacts;
  var widthTelephone;
  var widthFIO;
  var widthElement;

  listW(
      {required this.contacts,
        required this.widthTelephone,
        required this.widthFIO,
        required this.widthElement});

  @override
  _listW createState() => _listW();
}

class _listW extends State<listW> {

  double height_card = 50;

  @override
  Widget build(BuildContext context) {
    var mainConstModel = context.watch<MainConstModel>();

    final ScrollController _firstControllerV = ScrollController(
      initialScrollOffset: mainConstModel.InitScrollOffset,
      keepScrollOffset: true,
    );

    final rows = <Widget>[];
    var color = Colors.transparent;
    var contacts = widget.contacts;

    bool scan = true;
    int index = 0;

    while (scan) {
      int _idRow = contacts[index].id;

      String FIO = contacts[index].firstname.toString() +
          " " +
          contacts[index].middlename.toString() +
          " " +
          contacts[index].lastname.toString();
      String sFIO = FIO;
      String sFIO_tooltip = FIO;
      int max_len_Str = 50;
      if (FIO.length > max_len_Str) {
        sFIO_tooltip = FIO;
      } else {
        sFIO_tooltip = '';
      }

      int max_len_val = 40;
      String sCorp_tooltip = contacts[index].corporation.toString();
      if (sCorp_tooltip.length <= max_len_val) {
        sCorp_tooltip = '';
      }

      String sDep_tooltip = contacts[index].department.toString();
      if (sDep_tooltip.length <= max_len_val) {
        sDep_tooltip = '';
      }

      String sPosit_tooltip = contacts[index].position.toString();
      if (sPosit_tooltip.length <= max_len_val) {
        sPosit_tooltip = '';
      }

      int max_len_val_ph = 40;
      String sPhone = '';
      String _phone_str1 = contacts[index].workphone == ''
          ? ''
          : 'Раб.:' + contacts[index].workphone;
      String _phone_str2 = contacts[index].additionalphone == ''
          ? ''
          : ' доб.' + contacts[index].additionalphone;
      sPhone = _phone_str1 + _phone_str2;
      String _phone_str3 = contacts[index].mobilephone == ''
          ? ''
          : (sPhone == '' ? '' : '\n') + 'Моб.:' + contacts[index].mobilephone;
      sPhone = sPhone + _phone_str3;
      String sPhone_tooltip = sPhone;
      if (sPhone_tooltip.length <= max_len_val_ph) {
        sPhone_tooltip = '';
      }

      double _InitScrollOffset = (height_card+4)*index;

      rows.add(GestureDetector(
          onLongPress: () {
            mainConstModel.setCurrentIdContact(_idRow.toString());
            mainConstModel.setCurrentPage("CardContact");
            //mainConstModel.setInitScrollOffset(_InitScrollOffset);
            mainConstModel.setInitScrollOffset(_firstControllerV.offset);
          },
          onDoubleTap: () {
            mainConstModel.setCurrentIdContact(_idRow.toString());
            mainConstModel.setCurrentPage("CardContact");
            //mainConstModel.setInitScrollOffset(_InitScrollOffset);
            mainConstModel.setInitScrollOffset(_firstControllerV.offset);

            //debugPrint('_firstControllerV '+_firstControllerV.offset.toString());

          },
          child: HoverContainer(
            height: 50,
            margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
            decoration: BoxDecoration(
                color: (Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            hoverDecoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  width: 80,
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: CircleAvatar(
                      radius: 20,
                      //backgroundColor: Colors.brown.shade800,
                      child: Image.network(
                        'http://' +
                            ipLocalhost +
                            '/static/img/default/male.png',
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
                      ))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: widget.widthFIO,
                    padding: const EdgeInsets.all(5),
                    child: Tooltip(
                      message: sFIO_tooltip,
                      child: Text(
                        sFIO,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              Container(
                width: widget.widthElement,
                decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(width: 0.3, color: Colors.grey),
                      left: BorderSide(width: 0.3, color: Colors.grey),
                    )),
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Tooltip(
                      message: sCorp_tooltip,
                      child: Text(
                        contacts[index].corporation.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              Container(
                width: widget.widthElement,
                decoration: BoxDecoration(
                    border: Border(
                      //right: BorderSide(width: 0.3, color: Colors.grey),
                      //left: BorderSide(width: 0.3, color: Colors.grey),
                    )),
                padding: const EdgeInsets.all(5),
                child: Center(
                    child: Tooltip(
                        message: sDep_tooltip,
                        child: Text(
                          contacts[index].department.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
              ),
              Container(
                width: widget.widthElement,
                decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(width: 0.3, color: Colors.grey),
                      left: BorderSide(width: 0.3, color: Colors.grey),
                    )),
                padding: const EdgeInsets.all(5),
                child: Center(
                    child: Tooltip(
                      message: sPosit_tooltip,
                      child: Text(
                        contacts[index].position.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
              Container(
                  width: widget.widthTelephone,
                  decoration: BoxDecoration(border: Border()),
                  padding: const EdgeInsets.all(5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Tooltip(
                      message: sPhone_tooltip,
                      child: Text(
                        sPhone,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),

            ]),
          )));

      index++;
      if (index >= contacts.length) {
        scan = false;
      }
    }

    return
      //  Scrollbar(
      ////thumbVisibility: true,
      // // trackVisibility: true,
      // controller: _firstControllerV,
      //  child:
      SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: _firstControllerV,
          child: Column(children: rows)
        //   )
      );
  }
}


