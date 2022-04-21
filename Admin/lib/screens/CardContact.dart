import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/models/mainStatesModel.dart';
import 'dart:async';
import 'package:admin/models/database.dart';
import 'package:admin/ConstSystemAD.dart';
import 'package:admin/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class DataContactParams {
  String nameParam;
  String valParam;
  bool readOnly;
  void changeVoid;
  final Function(String) changeFunction;

  DataContactParams(
      {required this.nameParam,
      required this.valParam,
      required this.readOnly,
      required this.changeFunction
      });
}

class CardContact extends StatefulWidget {
  @override
  _CardContact createState() => _CardContact();
}

class _CardContact extends State<CardContact> {

  ContactItem contactItemData
  =
    new ContactItem(
        id: 0,
        status:'',
        firstname: '',
        middlename: '',
        lastname: '',
        photo: '',
        department: '',
        corporation: '',
        position: '',
        workphone: '',
        mobilephone: '',
        birthdate: '',
        mail: '',
        additionalphone: '');


  Widget build(BuildContext context) {
    var mainConstModel = context.watch<MainConstModel>();

    final _storage = const FlutterSecureStorage();

    Future<ContactServer> _readContactsData() async {
      String? val = await _storage.read(key: session_token_name);
      String t_s = val ?? '';
      var _resp =
          await getContacts(t_s, id_contact: mainConstModel.currentIdContact);
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
                    List<DataContactParams> Data = [];

                    //contactItemData.firstname = vDBD.contacts[0].firstname;
                    //debugPrint('First Name:' + vDBD.contacts[0].firstname);

                    for (var element in vDBD.contacts) {
                      Data.add(DataContactParams(
                          nameParam: 'First name',
                          valParam: element.firstname.toString(),
                          changeFunction: (String val) {
                            contactItemData.firstname = (val==null) ? '': val;
                            //debugPrint('First Name:' + firstName);
                          },
                          readOnly: false));

                      Data.add(DataContactParams(
                          nameParam: 'Last name',
                          valParam: element.firstname.toString(),
                          changeFunction: (String val) {
                            contactItemData.firstname = (val==null) ? '': val;
                            //debugPrint('First Name:' + firstName);
                          },
                          readOnly: false));




/*
                      Data.add(DataContactParams(
                          nameParam: 'Middle name',
                          valParam: element.middlename.toString(),
                          readOnly: false));

                      Data.add(DataContactParams(
                          nameParam: 'Last name',
                          valParam: element.lastname.toString(),
                          readOnly: false));

                      Data.add(DataContactParams(
                          nameParam: 'Corporation',
                          valParam: element.corporation.toString(),
                          readOnly: false));

                      Data.add(DataContactParams(
                          nameParam: 'Department',
                          valParam: element.department.toString(),
                          readOnly: false));

                      Data.add(DataContactParams(
                          nameParam: 'Position',
                          valParam: element.position.toString(),
                          readOnly: false));

                      Data.add(DataContactParams(
                          nameParam: 'Work phone',
                          valParam: element.workphone.toString(),
                          readOnly: false));

                      Data.add(DataContactParams(
                          nameParam: 'Additional phone',
                          valParam: element.additionalphone.toString(),
                          readOnly: false));

                      Data.add(DataContactParams(
                          nameParam: 'Mobile phone',
                          valParam: element.mobilephone.toString(),
                          readOnly: false));

                      Data.add(DataContactParams(
                          nameParam: 'Birth date',
                          valParam: element.birthdate.toString(),
                          readOnly: false));

                      Data.add(DataContactParams(
                          nameParam: 'E-mail',
                          valParam: element.mail.toString(),
                          readOnly: false));
                    */

                    }

                    return BodyCard(dataServer: Data,
                                    saveFunction: (){

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: new Text("Alert!!"),
                              //content: new Text(firstName),//new Text('firstname'),
                                content: new Text(contactItemData.firstname),
                                actions: <Widget>[
                                new TextButton(
                                  child: new Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );   }


                    );
                  } else {
                    return RefreshWidget();
                  }
                }
              }
          }
        });
  }
}

class ElementCardContact extends StatefulWidget {
  String nameElement;
  String valueElement;
  bool readOnlyElement;
  final Function(String) changeFunction;

  ElementCardContact(
      {required this.nameElement,
      required this.valueElement,
      required this.readOnlyElement,
      required this.changeFunction
      });

  @override
  _ElementCardContact createState() => _ElementCardContact();
}

class _ElementCardContact extends State<ElementCardContact> {
  Widget build(BuildContext context) {
    var _valController = TextEditingController();

    _valController.text = widget.valueElement;

    bool _readOnly;
    _readOnly = widget.readOnlyElement;
    //_readOnly = true;

    return Container(
        margin: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          readOnly: _readOnly,
          controller: _valController,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 5,
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue,
            fontWeight: FontWeight.w200,
          ),
          decoration: new InputDecoration(
            fillColor: _readOnly ? Colors.grey[50] : Colors.white,
            filled: true,
            hoverColor: Colors.grey[200],

            labelText: widget.nameElement,
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),

            floatingLabelBehavior: FloatingLabelBehavior.always,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.blue),
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _valController.text = '';
                // widget.changeParentValue('');
              },
            ),
          ),
          onChanged: (text) {
            widget.changeFunction(text);

            //filterModelV.setFilterValueonlyset(text);
            //widget.changeParentValue(text);
            //print('widget text field: $text');
          },
        ));
  }
}

class BodyCard extends StatefulWidget {
  List<DataContactParams> dataServer;
  final Function() saveFunction;

  BodyCard({required this.dataServer, required this.saveFunction,});

  @override
  _BodyCard createState() => _BodyCard();
}

class _BodyCard extends State<BodyCard> {
  TextEditingController dateinput = TextEditingController();
  @override
  Widget build(BuildContext context) {


    var mainConstModel = context.watch<MainConstModel>();
    final _data = <Widget>[];
    _data.add(new Container(
      height: 10,
    ));

    _data.add(

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          ElevatedButton.icon(
            icon: Icon(
              Icons.save,
              color: Colors.green[200],
              size: 40.0,
            ),
            label: Text('Сохранить'),
            onPressed: () {widget.saveFunction();
              //mainConstModel.setCurrentPage("MainPage");
         },

          ),
          Container(
            width: 20,
          ),
          ElevatedButton.icon(
            icon: Icon(
              Icons.cancel,
              color: Colors.red[50],
              size: 40.0,
            ),
            label: Text('Отменить'),
            onPressed: () {
              mainConstModel.setCurrentPage("MainPage");
            },

          ),

      ],),
    );

    _data.add(
 /*

      Container(
          margin: const EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          child:
          TextField
            (
            controller: dateinput, //editing controller of this TextField
            decoration: InputDecoration
              (
                icon: Icon
                  (
                    Icons.calendar_today), //icon of text field
                labelText: 'Enter Date'
              //label text of field
            )
            ,
            readOnly: true
            , //set it true, so that user will not able to edit text
            onTap: () async {
              var pickedDate = await showDatePicker(
                  context: context, initialDate: DateTime.now(),
                  firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101)
              );

              if (pickedDate != null) {
                print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                print(formattedDate); //formatted date output using intl package =>  2021-03-16
//you can implement different kind of Date Format here according to your requirement

                setState(() {
                  dateinput.text =
                      formattedDate; //set output date to TextField value.
                });

              } else {
                print("Date is not selected");
              }
            }
            ,
          )),
*/

        Container(
            margin: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              readOnly: true,
              controller: dateinput,


              onTap: () async {
                var pickedDate = await showDatePicker(
                    context: context, initialDate: DateTime.now(),
                    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101)
                );

                if (pickedDate != null) {
                  print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(formattedDate); //formatted date output using intl package =>  2021-03-16
//you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    dateinput.text =
                        formattedDate; //set output date to TextField value.
                  });

                } else {
                  print("Date is not selected");
                }
              },


              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.w200,
              ),
              decoration: new InputDecoration(
                fillColor: true ? Colors.grey[50] : Colors.white,
                filled: true,
                hoverColor: Colors.grey[200],

                 labelText: 'widget.nameElement',
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),


                floatingLabelBehavior: FloatingLabelBehavior.always,

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0, color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0),
                ),

                prefixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    var pickedDate = await showDatePicker(
                        context: context, initialDate: DateTime.now(),
                        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101)
                    );

                    if (pickedDate != null) {
                      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
//you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateinput.text =
                            formattedDate; //set output date to TextField value.
                      });

                    } else {
                      print("Date is not selected");
                    }



                  },
                ),


                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    dateinput.text = '';
                    // widget.changeParentValue('');
                  },
                ),
              ),

            ))




    );

    for (var element in widget.dataServer) {
      _data.add(ElementCardContact(
          nameElement: element.nameParam,
          valueElement: element.valParam,
          readOnlyElement: element.readOnly,
          changeFunction: element.changeFunction
      ));
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Contact card"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: _data,
        )));
  }
}


