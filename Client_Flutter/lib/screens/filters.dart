import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ad_book_2/models/filters.dart';

class Filters extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    var filters = context.watch<FiltersModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Search contact',
            style: Theme.of(context).textTheme.headline1),
        //backgroundColor: Colors.white,
      ),
      body: Container(
        //color: Colors.yellow,
        child: Column(
          children: [

            ElevatedButton.icon(
              onPressed: () async {
                //modelDateBase.contactsForward();
                //print('fffff-222');
                //
                //setFilters
/*
                      List _d = await SearchContacts().postContacts(
                          _controllerFIO.text,
                          _controllerCorporation.text,
                          _controllerDepartament.text,
                          _controllerPhone.text,
                          _controllerTypePhone.text);
*/
                //print(_d);
/*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BasePage(title: "Address book")),
                      );
                      */
              },
              //color: Colors.blue,
              //textColor: Colors.white,
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blue),
              ), //
              icon: Icon(Icons.search),
              label: Text('Найти'),
            ),



            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text("fliters buuu 2"),
              ),
            ),
            const Divider(height: 4, color: Colors.black),
            Text(filters.filters.controllerFIO),
            /*TextFormField(
              controller: filters.controllerFIO,
              decoration: new InputDecoration(
                //icon: Icon(Icons.arrow_drop_down),
                //
                labelText: 'ФИО',
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.0, color: Colors.white),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    //setState(() {
                    filters.controllerFIO.text = '';
                    //});
                  },
                ),
              ),
              onSaved: (String value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
                filters.setFilters(filters.controllerFIO.text);
              },
              validator: (String value) {
                return value.contains('@') ? 'Do not use the @ char.' : null;
              },
            ),*/
          ],
        ),
      ),
    );
  }
}
