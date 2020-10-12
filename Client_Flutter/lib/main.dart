import 'package:flutter/material.dart';
import 'PostContact.dart';

void main() {
  runApp(MyApp());
}

/////////11

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Address book'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _postPoneVM = PostPoneViewModel();
  List<PostContact> postPoneItems;
  @override
  void initState() {
    super.initState();
    postPoneItems = _postPoneVM.getPostPone();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new ListView.builder(
          itemCount: postPoneItems.length,
          itemBuilder: (context, index) {
            var postPone = postPoneItems[index];
            return new Container(
                decoration: myBoxDecoration(),
                margin: const EdgeInsets.all(6.0),
                padding: const EdgeInsets.all(3.0),
                child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          postPone.image.toString(),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Expanded(
                          flex: 5,
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
                                    child: Text(
                                  postPone.contact.toString(),
                                  style: new TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                              ])
                            ],
                          )),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.all(3.0),
                      child: Column(
                        children: [
                          /////////
                          widgetADPropertyValue('Организация',
                              postPone.corporation.toString(), ''),
                          widgetADPropertyValue(
                              'Должность', postPone.position.toString(), ''),
                          widgetADPropertyValue('Подразделение',
                              postPone.department.toString(), ''),
                          widgetADPropertyValue('Дата рождения',
                              postPone.birthdate.toString(), ''),

                          widgetADPropertyValue('Рабочий тел.',
                              postPone.workphone.toString(), 'p'),
                          widgetADPropertyValue('Мобильный тел.',
                              postPone.mobilephone.toString(), 'p'),
                          widgetADPropertyValue(
                              'Почта', postPone.mail.toString(), 'e'),
                        ],
                      )),
                ]));
          },
        ));
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

widgetADPropertyValue(String sProperty, String sValue, String sIcon) {
  return Container(
      padding: EdgeInsets.only(top: 3),
      child: Row(
        children: [
          Expanded(
              flex: 10,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  sProperty,
                  style: new TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              )),
          Expanded(
              flex: 2,
              child: Align(
                alignment: AlignmentDirectional.center,
                child: _getIcon(sIcon),
              )),
          Expanded(
              flex: 20,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  sValue,
                  style:
                      new TextStyle(fontSize: 14.0, color: Colors.indigo[900]),
                ),
              )),
        ],
      ));
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

class PostPoneViewModel {
  List<PostContact> postPoneItems;
  PostPoneViewModel({this.postPoneItems});
  getPostPone() => <PostContact>[
        PostContact(
            status: 'Работа',
            contact:
                'Иванов Иван Иваныч ываы аыпавпвлдпл вапвапв 111 222 333 44444',
            image: 'http://192.168.88.234:3000/img/default/male.png',
            department: 'Подразделение 1',
            corporation: 'ГК Организация Примера',
            position: 'Должность Менеджер',
            workphone: '333-333-33 доб. 444',
            mobilephone: '1(111)111-11-11',
            birthdate: '2 января',
            mail: 'ававав@mfsdf.com'),
        PostContact(
            status: 'Отпуск',
            contact: 'Петров Петр 1',
            image: 'http://192.168.88.234:3000/img/default/female.png',
            department: 'Подразделение 121',
            corporation: 'ГК Организация Примера',
            position: 'Должность Менеджер',
            workphone: '333-333-33 доб. 444',
            mobilephone: '1(111)111-11-11',
            birthdate: '2 января',
            mail: 'ававав@mfsdf.com'),
        PostContact(
            status: 'Отпуск',
            contact: 'Петров Петр 2',
            image: 'http://192.168.88.234:3000/img/default/female.png',
            department: 'Подразделение 121',
            corporation: 'ГК Организация Примера',
            position: 'Должность Менеджер',
            workphone: '333-333-33 доб. 444',
            mobilephone: '1(111)111-11-11',
            birthdate: '2 января',
            mail: 'ававав@mfsdf.com'),
        PostContact(
            status: 'Отпуск',
            contact: 'Петров Петр 3',
            image: 'http://192.168.88.234:3000/img/default/male.png',
            department: 'Подразделение 121',
            corporation: 'ГК Организация Примера',
            position: 'Должность Менеджер',
            workphone: '333-333-33 доб. 444',
            mobilephone: '1(111)111-11-11',
            birthdate: '2 января',
            mail: 'ававав@mfsdf.com'),
        PostContact(
            status: 'Отпуск',
            contact: 'Петров Петр 4',
            image: 'http://192.168.88.234:3000/img/default/male.png',
            department: 'Подразделение 121',
            corporation: 'ГК Организация Примера',
            position: 'Должность Менеджер',
            workphone: '333-333-33 доб. 444',
            mobilephone: '1(111)111-11-11',
            birthdate: '2 января',
            mail: 'ававав@mfsdf.com'),
        PostContact(
            status: 'Отпуск',
            contact: 'Петров Петр 5',
            image: 'http://192.168.88.234:3000/img/default/male.png',
            department: 'Подразделение 121',
            corporation: 'ГК Организация Примера',
            position: 'Должность Менеджер',
            workphone: '333-333-33 доб. 444',
            mobilephone: '1(111)111-11-11',
            birthdate: '2 января',
            mail: 'ававав@mfsdf.com'),
        PostContact(
            status: 'Отпуск',
            contact: 'Петров Петр 6',
            image: 'http://192.168.88.234:3000/img/default/female.png',
            department: 'Подразделение 121',
            corporation: 'ГК Организация Примера',
            position: 'Должность Менеджер',
            workphone: '333-333-33 доб. 444',
            mobilephone: '1(111)111-11-11',
            birthdate: '2 января',
            mail: 'ававав@mfsdf.com'),
        PostContact(
            status: 'Отпуск',
            contact: 'Петров Петр 7',
            image: 'http://192.168.88.234:3000/img/default/male.png',
            department: 'Подразделение 121',
            corporation: 'ГК Организация Примера',
            position: 'Должность Менеджер',
            workphone: '333-333-33 доб. 444',
            mobilephone: '1(111)111-11-11',
            birthdate: '2 января',
            mail: 'ававав@mfsdf.com'),
        PostContact(
            status: 'Отпуск',
            contact: 'Петров Петр 8',
            image: 'http://192.168.88.234:3000/img/default/female.png',
            department: 'Подразделение 121',
            corporation: 'ГК Организация Примера',
            position: 'Должность Менеджер',
            workphone: '333-333-33 доб. 444',
            mobilephone: '1(111)111-11-11',
            birthdate: '2 января',
            mail: 'ававав@mfsdf.com'),
        PostContact(
            status: 'Отпуск',
            contact: 'Петров Петр 9',
            image: 'http://192.168.88.234:3000/img/default/male.png',
            department: 'Подразделение 121',
            corporation: 'ГК Организация Примера',
            position: 'Должность Менеджер',
            workphone: '333-333-33 доб. 444',
            mobilephone: '1(111)111-11-11',
            birthdate: '2 января',
            mail: 'ававав@mfsdf.com'),
        PostContact(
            status: 'Отпуск',
            contact: 'Петров Петр 10',
            image: 'http://192.168.88.234:3000/img/default/male.png',
            department: 'Подразделение 121',
            corporation: 'ГК Организация Примера',
            position: 'Должность Менеджер',
            workphone: '333-333-33 доб. 444',
            mobilephone: '1(111)111-11-11',
            birthdate: '2 января',
            mail: 'ававав@mfsdf.com'),
        PostContact(
            status: 'Отпуск',
            contact: 'Петров Петр 11',
            image: 'http://192.168.88.234:3000/img/default/female.png',
            department: 'Подразделение 121',
            corporation: 'ГК Организация Примера',
            position: 'Должность Менеджер',
            workphone: '333-333-33 доб. 444',
            mobilephone: '1(111)111-11-11',
            birthdate: '2 января',
            mail: 'ававав@mfsdf.com'),
        PostContact(
            status: 'Отпуск',
            contact: 'Петров Петр 12',
            image: 'http://192.168.88.234:3000/img/default/male.png',
            department: 'Подразделение 121',
            corporation: 'ГК Организация Примера',
            position: 'Должность Менеджер',
            workphone: '333-333-33 доб. 444',
            mobilephone: '1(111)111-11-11',
            birthdate: '2 января',
            mail: 'ававав@mfsdf.com'),
        PostContact(
            status: 'Отпуск',
            contact: 'Петров Петр 13',
            image: 'http://192.168.88.234:3000/img/default/female.png',
            department: 'Подразделение 121',
            corporation: 'ГК Организация Примера',
            position: 'Должность Менеджер',
            workphone: '333-333-33 доб. 444',
            mobilephone: '1(111)111-11-11',
            birthdate: '2 января',
            mail: 'ававав@mfsdf.com'),
      ];
}
