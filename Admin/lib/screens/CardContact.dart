//import 'dart:html';

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
//import 'package:keyboard_actions/keyboard_actions.dart';
import 'dart:convert';
import 'dart:io';
//import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


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
      required this.changeFunctionHandler});
}

class CardContact extends StatefulWidget {
  @override
  _CardContact createState() => _CardContact();
}

class _CardContact extends State<CardContact> {
  ContactItem contactItemData = ContactItem(
      id: 0,
      status: '',
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


  XFile? image;
  String sImage = '';

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
                    var DataContact = vDBD.contacts[0];
                    ElementCardWidget _firstNameW = new ElementCardWidget(
                        nameElement: 'Имя',
                        valueElement: DataContact.firstname,
                        readOnlyElement: false);
                    ElementCardWidget _middleNameW = new ElementCardWidget(
                        nameElement: 'Отчество',
                        valueElement: DataContact.middlename,
                        readOnlyElement: false);
                    ElementCardWidget _lastNameW = new ElementCardWidget(
                        nameElement: 'Фамилия',
                        valueElement: DataContact.lastname,
                        readOnlyElement: false);
                    ElementCardWidget _corporationW = new ElementCardWidget(
                        nameElement: 'Организация',
                        valueElement: DataContact.corporation,
                        readOnlyElement: false,
                        typeWidget: 'TypeCorpotarion');
                    ElementCardWidget _departmentW = new ElementCardWidget(
                        nameElement: 'Подразделение',
                        valueElement: DataContact.department,
                        readOnlyElement: false);
                    ElementCardWidget _positionW = new ElementCardWidget(
                        nameElement: 'Должность',
                        valueElement: DataContact.position,
                        readOnlyElement: false);
                    ElementCardWidget _workphoneW = new ElementCardWidget(
                        nameElement: 'Раб. телефон',
                        valueElement: DataContact.workphone,
                        readOnlyElement: false);
                    ElementCardWidget _additionalphoneW = new ElementCardWidget(
                        nameElement: 'Доп. телефон',
                        valueElement: DataContact.additionalphone,
                        readOnlyElement: false);
                    ElementCardWidget _mobilephoneW = new ElementCardWidget(
                        nameElement: 'Моб. телефон',
                        valueElement: DataContact.mobilephone,
                        readOnlyElement: false);
                    ElementCardWidget _mailW = new ElementCardWidget(
                        nameElement: 'Почта',
                        valueElement: DataContact.mail,
                        readOnlyElement: false);
                    ElementCardWidget _birthDateW = new ElementCardWidget(
                        nameElement: 'День рождения',
                        valueElement: DataContact.birthdate,
                        readOnlyElement: true,
                        typeWidget: 'TypeDate');

                    ///ElementCardWidget _numW = new ElementCardWidget(nameElement: 'День рождения', valueElement: '11.22', readOnlyElement: false, typeWidget: 'TypeDecimal');

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
                                        print(_firstNameW.valueElement);
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
                                        mainConstModel
                                            .setCurrentPage("MainPage");
                                      },
                                    ),
                                  ],
                                ),
                                _firstNameW,
                                _middleNameW,
                                _lastNameW,
                                _corporationW,
                                _corporationW,
                                _birthDateW,
                                _departmentW,
                                _positionW,
                                _workphoneW,
                                _additionalphoneW,
                                _mobilephoneW,
                                _mailW,
                                _birthDateW,




                                if (image != null)
                                  Text(image!.path.toString())
                                else
                                  //const SizedBox(),
                                Text('fff'),

                                Container(
                                  child:
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      final ImagePicker _picker = ImagePicker();
                                      final img =
                                      await _picker.pickImage(source: ImageSource.gallery);
                                      setState(() {
                                        image = img;
                                      });
                                    },
                                    label: const Text('Choose Image'),
                                    icon: const Icon(Icons.image),
                                  ),
                                ),
                                Container(
                                  child:
                                  ElevatedButton.icon(
                                    onPressed: () async {


                                      await image!.readAsBytes().then((value) {
                                        Uint8List imageBytes;
                                        imageBytes = Uint8List.fromList(value);
                                        print('reading of bytes is completed');
                                        String baseimage = base64Encode(imageBytes);
                                        //debugPrint('baseimage: ' + baseimage);

                                          var resBody = {};
                                          resBody["Photo"] = baseimage;
                                          resBody["id_user"] = '';

                                          /*
                                          final response = http.post(
                                            Uri.http(ipLocalhost, '/uploadPhotoFile/'),
                                            body: jsonEncode(resBody),).timeout(const Duration(seconds: 3));*/

                                        http.post(
                                          Uri.http(ipLocalhost, '/uploadPhotoFile/'),
                                          body: jsonEncode(resBody),).timeout(const Duration(seconds: 3)).then((value) {
                                          if (value.statusCode == 200) {
                                            //setState(() {
                                            //  image = value.data.;
                                            //});
                                            //debugPrint('upload file xxx ');
                                            //debugPrint(value.body.toString());
                                            var jBody = jsonDecode(value.body);

                                            //debugPrint(jBody.toString());
                                            //debugPrint(jBody.Path_img);

                                            var img = jBody['Path_img'];

                                            debugPrint('upload file xxx ');


                                            setState(() {
                                              sImage = img;
                                            });

                                          }


                                        });



                                      //debugPrint('upload file xxx ');

                                      /*setState(() {
                                       // image = img;
                                      });*/
                                    });
          },
                                    label: const Text('Upload Image'),
                                    icon: const Icon(Icons.send_and_archive),
                                  ),
                                ),

                                CircleAvatar(
                                    radius: 28,
                                    backgroundColor: Colors.white,
                                    child:
                                    Image.network(
                                      'http://' +
                                          ipLocalhost +
                                          '/static/img/photo/'+sImage,
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
                                    )),


                              ],
                            ))));
                  } else {
                    return RefreshWidget();
                  }
                }
              }
          }
        });
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

  late FocusNode adFocusNode;
  @override
  void initState() {
    adFocusNode = FocusNode();
  }


  Widget build(BuildContext context) {
    _valController.text = widget.valueElement;

    _valController.selection = TextSelection.fromPosition(
        TextPosition(offset: _valController.text.length));

    bool _readOnly;
    _readOnly = widget.readOnlyElement;

    var _inputFormatters = [FilteringTextInputFormatter.deny(RegExp(r''))];
    var _TextType = TextInputType.multiline;
    int _minLines = 1;
    int _maxLines = 5;

    if (widget.typeWidget == 'TypeDecimal') {
      _inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ];
      _TextType = TextInputType.numberWithOptions(decimal: true);
      _maxLines = 1;
    } else if (widget.typeWidget == 'TypeInteger') {
      _inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
      ];
      _TextType = TextInputType.numberWithOptions(decimal: true);
      _maxLines = 1;
    }

    List<Widget> childrenRow = [];
    if (widget.typeWidget == 'TypeDate') {
      childrenRow.add(ElementButtonData(
        valueElement: _valController.text,
        changeFunctionHandler: (String val) {
          _valController.text = val;
          //widget.valueElement = val;
          /*setState(() {
            widget.valueElement = val;
          });*/
        },
      ));
    } else if (widget.typeWidget == 'TypeCorpotarion') {
      childrenRow.add(ElementFilterCorporation(
        changeFunctionHandler: (String val) {
          _valController.text = val;
          adFocusNode.requestFocus();
          //widget.valueElement = val;
          /*setState(() {
            widget.valueElement = val;
          });*/
        },
        chooseValueHandler:() {
          return _valController.text;
        },
      ));
    }

    childrenRow.add(Expanded(
        child: Focus(
            focusNode: adFocusNode,
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
                    borderSide:
                        BorderSide(width: 0.0, color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 0.0, color: Colors.transparent),
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
                  //setState(() {
                  widget.valueElement = text;
                  // });
                }))));

    return Container(
        padding: EdgeInsets.only(top: 2.0),
        margin: EdgeInsets.all(5.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.nameElement,
            style: TextStyle(
              fontSize: 14,
              //fontWeight: FontWeight.w400,
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
                  child: Row(children: childrenRow)))
        ]));
  }
}

class ElementButtonData extends StatefulWidget {
  String valueElement;
  void Function(String val) changeFunctionHandler;

  ElementButtonData(
      {required this.valueElement, required this.changeFunctionHandler});

  @override
  _ElementButtonData createState() => _ElementButtonData();
}

class _ElementButtonData extends State<ElementButtonData> {
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(0),
      icon: const Icon(Icons.calendar_today),
      onPressed: () async {
        var pickedDate = await showDatePicker(
            context: context,
            initialDate: (widget.valueElement == '')
                ? DateTime.now()
                : DateFormat('dd/MM/yyyy').parse(widget.valueElement),
            firstDate: DateTime(1900),
            lastDate: DateTime(2150));

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
          widget.changeFunctionHandler(formattedDate);
          /*setState(() {
            widget.valueElement =
                formattedDate; //set output date to TextField value.
          });*/
        } else {
          //print("Date is not selected");
        }
      },
    );
  }
}

class ElementFilterCorporation extends StatefulWidget {
  void Function(String val) changeFunctionHandler;
  String Function() chooseValueHandler;
  ElementFilterCorporation({required this.changeFunctionHandler, required this.chooseValueHandler});

  @override
  _ElementFilterCorporation createState() => _ElementFilterCorporation();
}

class _ElementFilterCorporation extends State<ElementFilterCorporation> {
  //List data_list = ['111', '222'];
  List data_list = [];
  int typebutton = 0;

  Future<List> _readCorporation() async {
    return await Future.delayed(
        const Duration(seconds: 2), () => ['123', '345']);
  }

  Widget build(BuildContext context) {
    //debugPrint('data_list.length:' + data_list.length.toString());

    return GestureDetector(
        onTap: () {


          showDialog(
            //barrierColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return

              ListPopupPage(
                data_list: data_list,
                changeFunctionHandlerList: (List val) {
                  data_list = val;
                },
                changeFunctionHandler: widget.changeFunctionHandler,
                chooseValueHandler: widget.chooseValueHandler,
              );

            },
          );

/*
          Navigator.push(
            context,
            PageRouteBuilder(
              barrierDismissible: true,
              opaque: false,
              pageBuilder: (_, anim1, anim2) => ListPopupPage(
                data_list: data_list,
                changeFunctionHandlerList: (List val) {
                  data_list = val;
                },
                changeFunctionHandler: widget.changeFunctionHandler,
                chooseValueHandler: widget.chooseValueHandler,
              ),
            ),
          );
*/
        },
        child: Container(
            //padding: EdgeInsets.only(left: 7.0),
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.filter_list,
              size: 25,
            )));
  }
}

class ListPopupPage extends StatefulWidget {
  List data_list;
  void Function(List val) changeFunctionHandlerList;
  void Function(String val) changeFunctionHandler;
  String Function() chooseValueHandler;

  ListPopupPage(
      {required this.data_list,
      required this.changeFunctionHandlerList,
      required this.changeFunctionHandler,
      required this.chooseValueHandler
      });

  @override
  _ListPopupPage createState() => _ListPopupPage();
}

class _ListPopupPage extends State<ListPopupPage> {
  Future<List> _readCorporation() async {
    return await Future.delayed(
        const Duration(seconds: 1), () => ['123', '345', '22 папа папа папапапа папа папапаппапапапа папа папапапапа папа', '33', '44', '55', '66', '77', '88', '99', '12', '13', '14', '15', '16', '22', '23', '24', '25', '26', '32', '33', '34', '35', '36']);
  }

  @override
  Widget build(BuildContext context) {

    Widget LP_const = ListPopup(
        widget.data_list, widget.chooseValueHandler, widget.changeFunctionHandler);

    Widget _FB() {
      return FutureBuilder(
        future: _readCorporation(),
        builder: (context, AsyncSnapshot<List> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator()))
                ],
              );
            default:
              if (snapshot.hasError)
                return RefreshWidget();
              else if (snapshot.data == null) {
                return RefreshWidget();
              } else {
                if (snapshot.data == null) {
                  return RefreshWidget();
                } else {
                  List? dataL = snapshot.data;
                  if (dataL != null) {
                    widget.changeFunctionHandlerList(dataL);
                    return ListPopup(
                        dataL, widget.chooseValueHandler, widget.changeFunctionHandler);
                  }
                  return RefreshWidget();
                }
              }
          }
        });}

    Widget _ADialog(Widget LP){
      return
        AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32)),
            content: SizedBox(
              //HERE THE SIZE YOU WANT
                height: MediaQuery.of(context).size.height * 2 / 10,
                width: MediaQuery.of(context).size.width * 1 / 10,
                //width: 500,
                //your content
                child: LP ));
    } ;



    if (!widget.data_list.isEmpty) {
      return _ADialog(LP_const);
    }

    return _ADialog(_FB());
  }
}

class ListPopup extends StatelessWidget {
  ListPopup(this.dataL, this.chooseValueHandler, this.changeFunctionHandler);

  List dataL;
  String Function() chooseValueHandler;
  void Function(String val) changeFunctionHandler;

  @override
  Widget build(BuildContext context) {
    //print('chooseValue '+ chooseValue);
    return ListView.builder(
        itemCount: dataL.length,
        itemBuilder: (context, index) {
          String list_value = dataL[index];


          return GestureDetector(
              onTap: () {
                changeFunctionHandler(list_value);
                Navigator.of(context).pop();
              },
              child:

              HoverContainer(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 220, 220, 220), width: 0.5),
                      color: chooseValueHandler() == dataL[index] ? Color.fromARGB(255, 240, 250, 240) : Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  hoverDecoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 220, 220, 220), width: 0.5),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey[200]),
                  child: Text(list_value)));






          return ListTile(
            title: Text(list_value),
            //tileColor: chooseValueHandler() == dataL[index] ? Colors.blue[100] : null,
            selected: chooseValueHandler() == dataL[index],
            onTap: () {
              changeFunctionHandler(list_value);
              //print(list_value);
              Navigator.of(context).pop();
            },
          );
        });
  }
}
