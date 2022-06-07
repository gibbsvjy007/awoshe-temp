import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';

class ProductInfoExpansionTile extends StatelessWidget {
  final String title;
  final Widget child;

  //final String infoData;

  ProductInfoExpansionTile(this.title, {this.child} /*{this.infoData}*/);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15.0),
      child: ExpansionTile(
        title: Text(""),
        leading: Text(
          title,
          style: TextStyle(
              color: awBlack,
              fontSize: 18.0,
              fontWeight: FontWeight.w600),
        ),
        //trailing: Text("Description"),
        backgroundColor: Colors.white,
        initiallyExpanded: false,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                child: Column(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                     child: child ?? Container(),
                   ),
                 ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
