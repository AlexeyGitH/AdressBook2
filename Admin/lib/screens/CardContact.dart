import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/models/mainStatesModel.dart';
import 'dart:async';
import 'package:admin/models/database.dart';
import 'package:admin/ConstSystemAD.dart';
import 'package:admin/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:hovering/hovering.dart';
import 'package:flutter/services.dart';
import  'package:keyboard_actions/keyboard_actions.dart';

class DataContactParams {
  String nameParam;
  String valParam;
  bool readOnly;
  String valType;
  void Function(String val) changeFunctionHandler;

  DataContactParams(
      {required this.nameParam,
      required this.valParam,
      required this.readOnly,
      this.valType = 'String',
      required this.changeFunctionHandler
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

   void changeFunctionHandler(String val,String text){
     val = (text==null) ? '': text;
    };



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

                    var DataContact = vDBD.contacts[0];
                    Widget _firstNameW = new ElementCardWidget(nameElement: 'First name', valueElement: DataContact.firstname, readOnlyElement: false);

                    return
                      GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: Scaffold(
                              backgroundColor: Colors.white,
                              appBar: AppBar(
                                title: Text("Contact card"),
                              ),
                              body: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton.icon(
                                            icon: Icon(
                                              Icons.save,
                                              color: Colors.green[200],
                                              size: 40.0,
                                            ),
                                            label: const Text('Сохранить'),
                                            onPressed: () {
                                              //widget.saveFunction();
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
                                            label: const Text('Отменить'),
                                            onPressed: () {
                                              mainConstModel.setCurrentPage("MainPage");
                                            },
                                          ),
                                        ],
                                      ),

                                      _firstNameW
                                    ],
                                  ))));



  /*
                    List<DataContactParams> Data = [];

                    //contactItemData.firstname = vDBD.contacts[0].firstname;
                    //debugPrint('First Name:' + vDBD.contacts[0].firstname);

                    for (var element in vDBD.contacts) {
                      Data.add(DataContactParams(
                          nameParam: 'First name',
                          valParam: element.firstname.toString(),
                          //changeFunctionHandler: changeFunctionHandler,
                          changeFunctionHandler: (String val) {
                            element.firstname = (val==null) ? '': val;
                          },
                          readOnly: false));

                      Data.add(DataContactParams(
                          nameParam: 'Last name',
                          valParam: element.lastname.toString(),
                          changeFunctionHandler: (String val) {
                          element.lastname = (val==null) ? '': val;
                          },
                          readOnly: false));



/*
                      Data.add(DataContactParams(
                          nameParam: 'Middle name',
                          valParam: element.middlename.toString(),
                          changeFunction: (String val) {
                            contactItemData.firstname = (val==null) ? '': val;
                          },
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


                    );*/
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
         // textInputAction: TextInputAction.done,
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
            label: const Text('Сохранить'),
            onPressed: () {
              widget.saveFunction();
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
            label: const Text('Отменить'),
            onPressed: () {
              mainConstModel.setCurrentPage("MainPage");
            },
          ),
        ],
      ),
    );

    _data.add(ElementCardWidgetData(
        nameElement: 'Birth date',
        valueElement: '12-12-2020',
        readOnlyElement: true,
        changeFunction: (f) {
          f;
        }));

    for (var element in widget.dataServer) {
      //if (element.nameParam == 'First name') {
        _data.add(ElementCardWidgetString(
          nameElement: element.nameParam,
          valueElement: element.valParam,
          readOnlyElement: element.readOnly,
          changeFunctionHandler: element.changeFunctionHandler
        ));
/*      } else {
        _data.add(ElementCardContact(
            nameElement: element.nameParam,
            valueElement: element.valParam,
            readOnlyElement: element.readOnly,
            changeFunction: element.changeFunction));
      }*/
    }

    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text("Contact card"),
            ),
            body: SingleChildScrollView(
                child: Column(
              children: _data,
            ))));
  }
}

class ElementCardWidgetData extends StatefulWidget {
  String nameElement;
  String valueElement;
  bool readOnlyElement;
  final Function(String) changeFunction;

  ElementCardWidgetData(
      {required this.nameElement,
      required this.valueElement,
      required this.readOnlyElement,
      required this.changeFunction});

  @override
  _ElementCardWidgetData createState() => _ElementCardWidgetData();
}

class _ElementCardWidgetData extends State<ElementCardWidgetData> {
  TextEditingController _valController = TextEditingController();

  MaterialColor colorBord = Colors.grey;
  Color colorFocus = Colors.white;

  Widget build(BuildContext context) {
    _valController.text = widget.valueElement;

    bool _readOnly;
    _readOnly = widget.readOnlyElement;

    return Container(
        margin: EdgeInsets.all(5.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.nameElement,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: colorBord,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 2.0),
              decoration: BoxDecoration(
                  border: Border.all(color: colorFocus, width: 2.0),
                  borderRadius: BorderRadius.circular(12.0)),
              child: HoverContainer(
                  //color: Colors.white,
                  //hoverColor: Colors.grey[200],
                  decoration: BoxDecoration(
                      border: Border.all(color: colorBord),
                      borderRadius: BorderRadius.circular(10.0)),
                  hoverDecoration: BoxDecoration(
                      //border: Border.all(color: Colors.blueAccent, width: 1.0),
                      border: Border.all(color: colorBord, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200]),
                  child: Row(children: [
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        var pickedDate = await showDatePicker(
                            context: context,
                            //initialDate: DateTime.now(),
                            initialDate: (widget.valueElement == '')
                                ? DateTime.now()
                                : DateFormat('dd-MM-yyyy')
                                    .parse(widget.valueElement),
                            firstDate: DateTime(1900),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2150));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
//you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            widget.valueElement =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          //print("Date is not selected");
                        }
                      },
                    ),
                    Expanded(
                        child: Focus(
                            onFocusChange: (f) {
                              if (f) {
                                //print('focus true');
                                setState(() {
                                  colorFocus = Colors.blue;
                                  colorBord = Colors.blue;
                                });
                              } else {
                                //print('focus false');
                                setState(() {
                                  colorFocus = Colors.white;
                                  colorBord = Colors.grey;
                                });
                              }
                            },
                            child: TextFormField(
                              readOnly: widget.readOnlyElement,
                              controller: _valController,

                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.w200,
                              ),
                              decoration: new InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.0, color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.0, color: Colors.transparent),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      widget.valueElement = '';
                                      //set output date to TextField value.
                                    });

                                    //_valController.text = '';
                                    // widget.changeParentValue('');
                                  },
                                ),
                              ),
                            )))
                  ])))
        ]));
  }
}

class ElementCardWidgetString extends StatefulWidget {
  String nameElement;
  String valueElement;
  bool readOnlyElement;
  void Function(String) changeFunctionHandler;

  ElementCardWidgetString(
      {required this.nameElement,
      required this.valueElement,
      required this.readOnlyElement,
      required this.changeFunctionHandler
      });

  @override
  _ElementCardWidgetString createState() => _ElementCardWidgetString();
}

class _ElementCardWidgetString extends State<ElementCardWidgetString> {
  MaterialColor colorBord = Colors.grey;
  Color colorFocus = Colors.white;

  fun1(String vv){}

  Widget build(BuildContext context) {
    TextEditingController _valController = TextEditingController();
    _valController.text = widget.valueElement;
    _valController.selection = TextSelection.fromPosition(
        TextPosition(offset: _valController.text.length));

    bool _readOnly;
    _readOnly = widget.readOnlyElement;

    return Container(
        margin: EdgeInsets.all(5.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.nameElement,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: colorBord,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 2.0),
              decoration: BoxDecoration(
                  border: Border.all(color: colorFocus, width: 2.0),
                  borderRadius: BorderRadius.circular(12.0)),
              child: HoverContainer(
                    decoration: BoxDecoration(
                      border: Border.all(color: colorBord),
                      borderRadius: BorderRadius.circular(10.0)),
                  hoverDecoration: BoxDecoration(
                      border: Border.all(color: colorBord, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200]),
                  child: Row(children: [
                    Expanded(
                        child: Focus(
                            onFocusChange: (f) {
                              if (f) {
                                setState(() {
                                  colorFocus = Colors.blue;
                                  colorBord = Colors.blue;
                                  widget.valueElement = _valController.text;
                                });
                              } else {
                                setState(() {
                                  colorFocus = Colors.white;
                                  colorBord = Colors.grey;
                                  widget.valueElement = _valController.text;
                                });
                              }
                            },
                            child: TextFormField(
                                readOnly: widget.readOnlyElement,
                                controller: _valController,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 5,

                                /*
                                keyboardType: TextInputType.numberWithOptions(decimal:true),
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),],
                              */
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.0, color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.0, color: Colors.transparent),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        widget.valueElement = '';
                                      });
                                   },
                                  ),
                                ),
                                onChanged: (text) {
                                  widget.changeFunctionHandler(text);
                                },
                                )))
                  ])))
        ]));
  }
}

class ElementCardWidgetNumerial extends StatefulWidget {
  String nameElement;
  String valueElement;
  bool readOnlyElement;
  int decemialElement;
  final Function(String) changeFunction;

  ElementCardWidgetNumerial(
      {required this.nameElement,
        required this.valueElement,
        required this.readOnlyElement,
        this.decemialElement = 0,
        required this.changeFunction});

  @override
  _ElementCardWidgetNumerial createState() => _ElementCardWidgetNumerial();
}

class _ElementCardWidgetNumerial extends State<ElementCardWidgetNumerial> {
  MaterialColor colorBord = Colors.grey;
  Color colorFocus = Colors.white;

  var _inputFormatters = [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),];

  Widget build(BuildContext context) {
    TextEditingController _valController = TextEditingController();
    _valController.text = widget.valueElement;
    _valController.selection = TextSelection.fromPosition(
        TextPosition(offset: _valController.text.length));

    bool _readOnly;
    _readOnly = widget.readOnlyElement;

    if(widget.decemialElement == 2)
    {_inputFormatters = [FilteringTextInputFormatter.allow(RegExp(r'^\d+')),];}


    return Container(
        margin: EdgeInsets.all(5.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.nameElement,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: colorBord,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 2.0),
              decoration: BoxDecoration(
                  border: Border.all(color: colorFocus, width: 2.0),
                  borderRadius: BorderRadius.circular(12.0)),
              child: HoverContainer(
                  decoration: BoxDecoration(
                      border: Border.all(color: colorBord),
                      borderRadius: BorderRadius.circular(10.0)),
                  hoverDecoration: BoxDecoration(
                      border: Border.all(color: colorBord, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200]),
                  child: Row(children: [
                    Expanded(
                        child: Focus(
                            onFocusChange: (f) {
                              if (f) {
                                setState(() {
                                  colorFocus = Colors.blue;
                                  colorBord = Colors.blue;
                                  widget.valueElement = _valController.text;
                                });
                              } else {
                                setState(() {
                                  colorFocus = Colors.white;
                                  colorBord = Colors.grey;
                                  widget.valueElement = _valController.text;
                                });
                              }
                            },
                            child: TextFormField(
                                readOnly: widget.readOnlyElement,
                                controller: _valController,
                                keyboardType: TextInputType.numberWithOptions(decimal:true),
                                inputFormatters: _inputFormatters,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.0, color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.0, color: Colors.transparent),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        widget.valueElement = '';
                                      });
                                    },
                                  ),
                                ),
                                onChanged: (text) {
                                  widget.changeFunction(text);
                                })))
                  ])))
        ]));
  }
}

class ElementCardWidget extends StatefulWidget {
  String nameElement;
  String valueElement;
  bool readOnlyElement;
  String typeWidget;

  ElementCardWidget(
      {required this.nameElement,
        required this.valueElement,
        required this.readOnlyElement,
        this.typeWidget = 'TypeString'});

  @override
  _ElementCardWidget createState() => _ElementCardWidget();
}

class _ElementCardWidget extends State<ElementCardWidget> {
  TextEditingController _valController = TextEditingController();

  MaterialColor colorBord = Colors.grey;
  Color colorFocus = Colors.white;

  String getValue(){
    return _valController.text;
  }

  Widget build(BuildContext context) {
    _valController.text = widget.valueElement;

    bool _readOnly;
    _readOnly = widget.readOnlyElement;


    var _inputFormatters = [FilteringTextInputFormatter.allow(RegExp(r'^\*+')),];
    var _TextType = TextInputType.multiline;
    int _minLines = 1;
    int _maxLines = 5;

    if(widget.typeWidget == 'TypeDecimal')
      {_inputFormatters = [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),];
       _TextType = TextInputType.numberWithOptions(decimal:true);
       _maxLines = 1;
      }
    else if(widget.typeWidget == 'TypeInteger')
      {_inputFormatters = [FilteringTextInputFormatter.allow(RegExp(r'^\d+')),];
       _TextType = TextInputType.numberWithOptions(decimal:true);
       _maxLines = 1;
      }

    return Container(
        margin: EdgeInsets.all(5.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.nameElement,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: colorBord,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 2.0),
              decoration: BoxDecoration(
                  border: Border.all(color: colorFocus, width: 2.0),
                  borderRadius: BorderRadius.circular(12.0)),
              child: HoverContainer(
                  decoration: BoxDecoration(
                      border: Border.all(color: colorBord),
                      borderRadius: BorderRadius.circular(10.0)),
                  hoverDecoration: BoxDecoration(
                      border: Border.all(color: colorBord, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200]),
                  child: Row(children: [
                    (widget.typeWidget == 'TypeDate') ? new ElementButtonData(valueElement: _valController.text) : new Container(),
                    Expanded(
                        child: Focus(
                            onFocusChange: (f) {
                              if (f) {
                                setState(() {
                                  colorFocus = Colors.blue;
                                  colorBord = Colors.blue;
                                  widget.valueElement = _valController.text;
                                });
                              } else {
                                setState(() {
                                  colorFocus = Colors.white;
                                  colorBord = Colors.grey;
                                  widget.valueElement = _valController.text;
                                });
                              }
                            },
                            child: TextFormField(
                                readOnly: widget.readOnlyElement,
                                controller: _valController,
                                keyboardType: _TextType,
                                minLines: _minLines,
                                maxLines: _maxLines,
                                inputFormatters: _inputFormatters,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.0, color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.0, color: Colors.transparent),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        widget.valueElement = '';
                                      });
                                    },
                                  ),
                                ),

                            )))
                  ])))
        ]));
  }
}

class ElementButtonData extends StatefulWidget {

  String valueElement;

  ElementButtonData(
      { required this.valueElement});

  @override
  _ElementButtonData createState() => _ElementButtonData();
}

class _ElementButtonData extends State<ElementButtonData> {
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.calendar_today),
      onPressed: () async {
        var pickedDate = await showDatePicker(
            context: context,
            initialDate: (widget.valueElement == '')
                ? DateTime.now()
                : DateFormat('dd-MM-yyyy').parse(widget.valueElement),
            firstDate: DateTime(1900),
            lastDate: DateTime(2150));

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          setState(() {
            widget.valueElement =
                formattedDate; //set output date to TextField value.
          });
        } else {
          //print("Date is not selected");
        }
      },
    );
  }
}