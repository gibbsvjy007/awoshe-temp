import 'dart:ui';

import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/theme/theme.dart';

import 'package:Awoshe/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectFabric extends StatefulWidget {
  final Product product;
  final Function callback;
  SelectFabric({this.product, this.callback});

  @override
  _SelectFabricState createState() => _SelectFabricState();
}

class _SelectFabricState extends State<SelectFabric> {
  int currentFabric = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Select Fabrics",
              style: TextStyle(
                color: awBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
              height: 60.0,
              padding: const EdgeInsets.only(left: 20.0, top: 10.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  if (widget.product.fabricTags.length > 0)
                    Row(
                    children: widget.product.fabricTags.map((fabric) {
                      return Stack(
                        children: <Widget>[
                          Center(
                            child: FutureBuilder<DocumentSnapshot>(
                                future: Firestore.instance
                                    .document("products/$fabric")
                                    .get(),
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null &&
                                      snapshot.data.data != null) {
                                    return InkWell(
                                      onTap: () {
                                        currentFabric = widget
                                            .product.fabricTags
                                            .indexOf(fabric);
                                        print(currentFabric);
                                        widget.callback(fabric);
                                        setState(() {});
                                        print(fabric.toString());
                                      },
                                      child: Container(
                                        width: 80.0,
                                        height: 40.0,
                                        margin: EdgeInsets.only(right: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                            image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data.data['images'][0]),
                                          fit: BoxFit.cover,
                                        )),
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Container(
                                          width: 80.0,
                                          height: 80.0,
                                          child: AwosheLoading(size: 20.0)),
                                    );
                                  }
                                }),
                          ),
                          currentFabric ==
                                  widget.product.fabricTags.indexOf(fabric)
                              ? Center(
                                  child: ClipRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 0.0, sigmaY: 0.0),
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10.0),
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          color:
                                              Colors.black87.withOpacity(0.5),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.check,
                                            size: 20.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      );
                    }).toList(),
                  )
                  else
                    Text("No fabric attached")
                ],
              )),
        ],
      ),
    );
  }
}
