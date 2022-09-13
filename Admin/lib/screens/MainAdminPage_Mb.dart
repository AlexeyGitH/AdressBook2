import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:admin/models/mainStatesModel.dart';
import 'package:admin/models/database.dart';
import 'package:admin/ConstSystemAD.dart';


class Mb_List extends StatefulWidget {
  AppBar appBar;
  Size MainSize;
  ContactServer dataServer;

  Mb_List(
      {required this.appBar, required this.MainSize, required this.dataServer});

  @override
  _Mb_List createState() => _Mb_List();
}

class _Mb_List extends State<Mb_List> {
  @override
  Widget build(BuildContext context) {
    // var mainConstModel = context.watch<MainConstModel>();

    double MainWidth = widget.MainSize.width * 0.95;
    double MainHeight = widget.MainSize.height;
    int height_app = widget.appBar.preferredSize.height.round();
    int height_header_table = 45;


    //print('00:' + MainWidth.toString() + ' 1:' + widthTelephone.toString() + ' 3:' + widthElement.toString()+ ' 1:' + widthFIO.toString());

    return Scaffold(
      //backgroundColor: Colors.white,
        backgroundColor: Colors.grey[200],
        appBar: widget.appBar,
        body:

        //listW(widget.dataServer.contacts),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //color: Colors.lightBlueAccent,
              //color: Colors.white,
               // color: Colors.grey[100],
                width: MainWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Expanded(
                      child: listM(
                        contacts: widget.dataServer.contacts,
                        MainWidth: MainWidth,
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}



class listM extends StatefulWidget {
  List<ContactItem> contacts;
  var MainWidth;


  listM(
      {required this.contacts,
        required this.MainWidth,});

  @override
  _listM createState() => _listM();
}

class _listM extends State<listM> {
  /*final ScrollController _firstControllerV = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );*/



  double height_card = 120;

  @override
  Widget build(BuildContext context) {
    var mainConstModel = context.watch<MainConstModel>();
   // var WidthElement = widget.MainWidth;

    final ScrollController _firstControllerV = ScrollController(
      initialScrollOffset: mainConstModel.InitScrollOffset,
      keepScrollOffset: true,
    );

    debugPrint("InitScrollOffset: " + mainConstModel.InitScrollOffset.toString());

    final rows = <Widget>[];
    //var color = Colors.transparent;
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
      String _phone_str1 = contacts[index].workphone;
      String _phone_str2 = contacts[index].additionalphone == ''
          ? ''
          : ' доб.' + contacts[index].additionalphone;
      sPhone = _phone_str1 + _phone_str2;

      double _InitScrollOffset = (height_card+10)*index;

      rows.add(GestureDetector(
          onLongPress: () {
            mainConstModel.setCurrentIdContact(_idRow.toString());
            mainConstModel.setCurrentPage("CardContact");
            //mainConstModel.setInitScrollOffset(_InitScrollOffset);
            mainConstModel.setInitScrollOffset(_firstControllerV.offset);
            //debugPrint("onLongPress InitScrollOffset: " + _InitScrollOffset.toString());
          },
          onDoubleTap: () {
            mainConstModel.setCurrentIdContact(_idRow.toString());
            mainConstModel.setCurrentPage("CardContact");
            //mainConstModel.setInitScrollOffset(_InitScrollOffset);
            mainConstModel.setInitScrollOffset(_firstControllerV.offset);
            //debugPrint("onDoubleTap InitScrollOffset: " + _InitScrollOffset.toString());

          },
          child: Container(
            height: height_card,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            decoration: BoxDecoration(
                color: (Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  width: 80,
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child:


                  CircleAvatar(
                      radius: 39,
                      backgroundColor: Colors.blue,
                      child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.white,
                          child:


                  CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child:
                      Image.network(
                        'http://' +
                            ipLocalhost +
                            '/static/img/default/male.png',
                        //'http://'+ipLocalhost,
                        //'',
                        //fit: BoxFit.fitHeight,
                        errorBuilder: (context, error, stackTrace) {
                          //print(error);
                          return Container(
                              width: 54,
                              //height: 120,
                              child: Image.asset('assets/NoPhoto.png'));
                        },
                      ))
                      ))




              ),
            Container(
                width: widget.MainWidth - 80,
                child:
                Column(
                children: [
                  Container(
                      height: 25,
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Tooltip(
                      message: sFIO_tooltip,
                      child: Text(
                        sFIO,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
                  Container(
                      height: 15,
                      padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child:

                        Row(children: [
                          Container(
                              width: 84,
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child:
                          Align(
                              alignment: Alignment.centerLeft,
                              child:
                          Text(
                            'Организация',
                            style: TextStyle(fontSize: 11, color: Colors.indigo[900]),
                          ))),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                  child:
                  Text(':', style: TextStyle(fontSize: 11, color: Colors.indigo[900]),),),
                        Flexible(
                        child:
                        Container(
                    child:
                          Align(
                            alignment: Alignment.centerLeft,
                            child:

                        Tooltip(
                          message: sCorp_tooltip,
                          child:
                          Text(
                            contacts[index].corporation.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                          )),
                        ))),
                        ],)

                      ),
                  Container(
                      height: 15,
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child:

                      Row(children: [
                        Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            width: 84,
                            child:
                            Align(
                                alignment: Alignment.centerLeft,
                                child:
                                Text(
                                  'Должность',
                                  style: TextStyle(fontSize: 11, color: Colors.indigo[900]),
                                ))),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                          child:
                          Text(':', style: TextStyle(fontSize: 11, color: Colors.indigo[900]),),),
                        Flexible(
                            child:
                            Container(
                                child:
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child:

                                  Tooltip(
                                      message: sDep_tooltip,
                                      child:
                                      Text(
                                        contacts[index].department.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                                      )),
                                ))),
                      ],)

                  ),


                  Container(
                      height: 15,
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child:

                      Row(children: [
                        Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            width: 84,
                            child:
                            Align(
                                alignment: Alignment.centerLeft,
                                child:
                                Text(
                                  'Подразделение',
                                  style: TextStyle(fontSize: 11, color: Colors.indigo[900]),
                                ))),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                          child:
                          Text(':', style: TextStyle(fontSize: 11, color: Colors.indigo[900]),),),
                        Flexible(
                            child:
                            Container(
                                child:
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child:

                                  Tooltip(
                                      message: sDep_tooltip,
                                      child:
                                      Text(
                                        contacts[index].position.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                                      )),
                                ))),
                      ],)

                  ),


                  Container(
                      height: 15,
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child:

                      Row(children: [
                        Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            width: 84,
                            child:
                            Align(
                                alignment: Alignment.centerLeft,
                                child:
                                Text(
                                  'Раб. телефон',
                                  style: TextStyle(fontSize: 11, color: Colors.indigo[900]),
                                ))),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                          child:
                          Text(':', style: TextStyle(fontSize: 11, color: Colors.indigo[900]),),),
                        Flexible(
                            child:
                            Container(
                                child:
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child:
                                      Text(
                                        sPhone,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                                      ),
                                ))),
                      ],)

                  ),

                  Container(
                      height: 15,
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child:

                      Row(children: [
                        Container(
                            width: 84,
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child:
                            Align(
                                alignment: Alignment.centerLeft,
                                child:
                                Text(
                                  'Моб. телефон',
                                  style: TextStyle(fontSize: 11, color: Colors.indigo[900]),
                                ))),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                          child:
                          Text(':', style: TextStyle(fontSize: 11, color: Colors.indigo[900]),),),
                        Flexible(
                            child:
                            Container(
                                child:
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child:
                                  Text(
                                    contacts[index].mobilephone,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                                  ),
                                ))),
                      ],)

                  ),
                  Container(
                      height: 15,
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child:

                      Row(children: [
                        Container(
                            width: 84,
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child:
                            Align(
                                alignment: Alignment.centerLeft,
                                child:
                                Text(
                                  'Почта',
                                  style: TextStyle(fontSize: 11, color: Colors.indigo[900]),
                                ))),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                          child:
                          Text(':', style: TextStyle(fontSize: 11, color: Colors.indigo[900]),),),
                        Flexible(
                            child:
                            Container(
                                child:
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child:
                                  Text(
                                    contacts[index].mail,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                                  ),
                                ))),
                      ],)

                  ),






              /*
              Container(
                width: WidthElement,
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
                //width: widget.widthElement,
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
                //width: widget.widthElement,
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
                  //width: widget.widthTelephone,
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
                  )),*/

                ],
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

