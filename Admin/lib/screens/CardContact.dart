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
import 'package:keyboard_actions/keyboard_actions.dart';

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
          //widget.valueElement = val;
          /*setState(() {
            widget.valueElement = val;
          });*/
        },
        chooseValue: _valController.text,
      ));
    }

    childrenRow.add(Expanded(
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
  String chooseValue;
  ElementFilterCorporation({required this.changeFunctionHandler, required this.chooseValue});

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
                chooseValue: widget.chooseValue,
              ),
            ),
          );
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
  String chooseValue;

  ListPopupPage(
      {required this.data_list,
      required this.changeFunctionHandlerList,
      required this.changeFunctionHandler,
      required this.chooseValue
      });

  @override
  _ListPopupPage createState() => _ListPopupPage();
}

class _ListPopupPage extends State<ListPopupPage> {
  Future<List> _readCorporation() async {
    return await Future.delayed(
        const Duration(seconds: 2), () => ['123', '345']);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.data_list.isEmpty) {
      return AlertDialog(
          content: SizedBox(
              //HERE THE SIZE YOU WANT
              height: MediaQuery.of(context).size.height * 2 / 3,
              width: MediaQuery.of(context).size.width * 1 / 5,
              //your content
              child: ListPopup(
                  widget.data_list, widget.chooseValue, widget.changeFunctionHandler)));
    }

    return AlertDialog(
      content: SizedBox(
        //HERE THE SIZE YOU WANT
        height: MediaQuery.of(context).size.height * 2 / 3,
        width: MediaQuery.of(context).size.width * 1 / 5,
        //your content
        child: FutureBuilder(
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
                            dataL, widget.chooseValue, widget.changeFunctionHandler);
                      }
                      return RefreshWidget();
                    }
                  }
              }
            }),
      ),
    );
  }
}

class ListPopup extends StatelessWidget {
  ListPopup(this.dataL, this.chooseValue, this.changeFunctionHandler);

  List dataL;
  String chooseValue;
  void Function(String val) changeFunctionHandler;

  @override
  Widget build(BuildContext context) {
    print('chooseValue '+ chooseValue);
    return ListView.builder(
        itemCount: dataL.length,
        itemBuilder: (context, index) {
          String list_value = dataL[index];
          return ListTile(
            title: Text(list_value),
            tileColor: chooseValue == dataL[index] ? Colors.blue : null,
            onTap: () {
              changeFunctionHandler(list_value);
              //print(list_value);
              Navigator.of(context).pop();
            },
          );
        });
  }
}
