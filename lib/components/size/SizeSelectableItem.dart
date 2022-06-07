import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';

typedef OnPressed = void Function();
class SizeSelectableItem extends StatelessWidget {
  final bool isSelected;
  final List<String> headers;
  final List< String > values;
  final OnPressed onPressed;

  const SizeSelectableItem({Key key, this.isSelected = false,
    @required this.headers, @required this.values,
    this.onPressed}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,

      children: <Widget>[
        InputChip(
          shape: CircleBorder(),
          onPressed:() {
            if (onPressed != null)
              onPressed();
          },
          backgroundColor: (isSelected) ? awYellowColor : awLightColor,
          label: Icon(Icons.done, color: Colors.black,),
        ),

        Expanded(
          child: Table(
            border: TableBorder.all(color: Colors.black),
            children: _buildTableRows(),
          ),
        ),
      ],
    );
  }

  TableCell _createHeaderCell(String headerData) =>
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.top,
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Text(headerData, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      );

  TableCell _createDataCell(String cellData) =>
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(child: Text(cellData,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                ),
              )),
            ],
          ),
        ),
      );

  List<TableRow> _buildTableRows() {
    List<TableRow> rows = [];

    for (var i=0 ; i < headers.length; i++){
      var headerCell = _createHeaderCell( headers[i] );
      var dataCell = _createDataCell( values[i] );

      rows.add(
        TableRow(
          decoration: BoxDecoration(color: Colors.white,),
          children: <Widget>[
            headerCell,
            dataCell
          ]
        ),
      );
    }

    return rows;
  }

}
