import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ad_book_2/models/filters.dart';
import 'package:ad_book_2/models/database.dart';
import 'package:ad_book_2/models/PostContact.dart';

List<String> lisCorp = [];

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Address book', style: Theme.of(context).textTheme.headline1),
        //backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/filters'),
          ),
          /*
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () => Navigator.pushNamed(context, '/test'),
          ),*/
        ],
      ),
      body: Container(
        //color: Colors.yellow,
        child: Column(
          children: [
            /*
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: DataViewList(),
              ),
            ),
            */
            DataViewList(),
          ],
        ),
      ),
    );
  }
}

class DataViewList extends StatefulWidget {
  @override
  _DataViewList createState() => _DataViewList();
}

class _DataViewList extends State<DataViewList> {

  @override
  Widget build(BuildContext context) {
    var filters = context.watch<FiltersModel>();

    DataBaseData dataBaseData = new DataBaseData(
        datalistcount: 0,
        database: new ContactServer(
            countlist: 0, contacts: new List<ContactItem>.empty()),
        blockrightarrow: false,);

    return FutureBuilder(
        future: getContactList(),
        initialData: dataBaseData,
        builder: (BuildContext context, AsyncSnapshot<DataBaseData> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Center(
                    child: SizedBox(
                        width: 150,
                        height: 150,
                        child: CircularProgressIndicator()),
                  ),
                ),
                const Divider(height: 4, color: Colors.black),
                Text('Loading..', style: Theme.of(context).textTheme.headline5),
              ]);
            default:
              if (snapshot.hasError)
                return RefreshWidget();
              else
                if (snapshot.data == null){
                  return RefreshWidget();
                }
                else{
                  return Text('Result: ${snapshot.data}');
                }



          }

          /*
        if (snapshot.hasData) {
          //return Text("non");
          //return ListPageList(serverdata: snapshot.data);
          DataBaseData? ret_value = snapshot.data;
          if (ret_value != null) {
            return Text('Address book');
            /*           body: ListPageList(serverdata: snapshot.data),
    //body: Text('body'),
    bottomNavigationBar: BottomAppBar(
    color: Colors.blue[700],
    child: Row(
    children: [
    LeftArrowBottomWidget(),
    Spacer(),
    RightArrowBottomWidget(),
    ],
    ),
    ),
    );
*/

          }
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        else {
          return Text("error");
        }

*/

          /*
    if (filters.viewResume != 0) {
      return new Column(children: [
        SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height / 1.3,
          child: Center(
            child: SizedBox(
                width: 150, height: 150, child: CircularProgressIndicator()),
          ),
        ),
        const Divider(height: 4, color: Colors.black),
        Text('Loading..', style: Theme
            .of(context)
            .textTheme
            .headline5),
      ]);
    }
    else{
      return Consumer<FiltersModel>(
          builder: (context, myModel, child) =>
          FutureBuilder<DataBaseData>(
            future: getContactList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //return Text("non");
                //return ListPageList(serverdata: snapshot.data);

                if (snapshot.data!.database.contacts.length == 0) {
                  return Text('ListPageError()');
                } else {

                  return Text('BodyList()');
                }
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Text('ListPageWaiting()');
            },
          ));
    }
    */

          /*
    return Column(children: [
      Text(filters.filters.controllerFIO),
      Text(filters.filters.controllerCorporation),
      Text(filters.filters.controllerDepartament),
      Text(filters.filters.controllerTypePhone),
      Text(filters.filters.controllerPhone),
    ]);

     */
        });
  }
}


class RefreshWidget extends StatefulWidget {
  @override
  _RefreshWidget createState() => _RefreshWidget();
}

class _RefreshWidget extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) {

    return new Column(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height / 1.3,
        child: Center(
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
            onPressed: () {
              setState(() {});
            },
            child: Icon(
              Icons.refresh,
              size: 150,
            ),
          ),
        ),
      ),
    ]);

  }
}
