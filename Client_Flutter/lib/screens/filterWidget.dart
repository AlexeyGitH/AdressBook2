import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ad_book_2/models/filterWidget.dart';


class RowFiltersButton extends StatefulWidget {
  final String labelltext;
  String initialltext;

 // VoidCallback onChangeTextCallBack;
 //RowFiltersButton({required this.labelltext, required this.initialltext, required this.onChangeTextCallBack});
  RowFiltersButton({required this.labelltext, required this.initialltext});

  @override
  _RowFiltersButton createState() => _RowFiltersButton();


}

class _RowFiltersButton extends State<RowFiltersButton> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => FiltersModelView()),
        ChangeNotifierProvider<FiltersModelView>(
          create: (context) => FiltersModelView(),
        ),
      ],
      child: FiltersViewRow(labelltext: widget.labelltext, initialltext: widget.initialltext),
    );
  }
}

class FiltersViewRow extends StatefulWidget {
  final String labelltext;
  String initialltext;

  FiltersViewRow({required this.labelltext, required this.initialltext});

  @override
  _FiltersViewRow createState() => _FiltersViewRow();
}

class _FiltersViewRow extends State<FiltersViewRow> {
  @override
  Widget build(BuildContext context) {
    var _valController = TextEditingController();

    var filterModelV = context.watch<FiltersModelView>();
    var typeV = filterModelV.filterView;

    _valController.text = widget.initialltext;

    //filterModelV.setFilterValue(widget.initialltext);

    //_valController.text = filterModelV.textValue;

    return new Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0)),
        child: new Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(children: [
              Flexible(
                  child: TextFormField(
                      controller: _valController,
                      decoration: new InputDecoration(
                        icon:
                            FiltersButton(controllervalue: widget.initialltext),
                        labelText: widget.labelltext,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.0, color: Colors.white),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _valController.text = '';
                          },
                        ),
                      ),
                    onChanged: (text) {
                      filterModelV.setFilterValueonlyset(text);
                      widget.initialltext = text;
                      //print('widget text field: $widget.initialltext');
                    },
                  ))
            ])));
  }
}

class FiltersButton extends StatefulWidget {
  String controllervalue;

  FiltersButton({required this.controllervalue});

  @override
  _FiltersButton createState() => _FiltersButton();
}

class _FiltersButton extends State<FiltersButton> {
  List<String> lisCorp = [];

  @override
  Widget build(BuildContext context) {

    var filterModelV = context.watch<FiltersModelView>();
    int typeV = filterModelV.filterView;

    if (typeV == 0) {
      return PopupMenuButton(
        icon: Icon(Icons.filter_list),
        itemBuilder: (BuildContext context) {
          lisCorp = [];
          lisCorp.insert(0, "no..no..");
          return lisCorp
              .map((day) => PopupMenuItem(
                    child: Text(day),
                    value: day,
                  ))
              .toList();
        },
        onSelected: (value) {
          filterModelV.setFilterView(1);
          if (value == "All")
            filterModelV.setFilterValue("");
          else
            widget.controllervalue = value.toString();
            filterModelV.setFilterValue(value.toString());
        },
      );
    } else if (typeV == 1) {
      return PopupMenuButton(
        icon: Icon(Icons.wifi),
        itemBuilder: (BuildContext context) {
          lisCorp = [];
          lisCorp.insert(0, "All");
          return lisCorp
              .map((day) => PopupMenuItem(
                    child: Text(day),
                    value: day,
                  ))
              .toList();
        },
        onSelected: (value) {
          filterModelV.setFilterView(3);

          if (value == "All")
            filterModelV.setFilterValue("");
          else
            filterModelV.setFilterValue(value.toString());
        },
      );
    } else {


      return GestureDetector(
          onTap: () {
            filterModelV.setFilterView(0);
            },
          child: CircularProgressIndicator(), );


    }
  }
}
