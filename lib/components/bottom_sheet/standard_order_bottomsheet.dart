
import 'package:Awoshe/pages/product/product.standard.order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StandardOrderBottomSheet extends StatefulWidget {
  @override
  _StandardOrderBottomSheetState createState() => _StandardOrderBottomSheetState();
}

class _StandardOrderBottomSheetState extends State<StandardOrderBottomSheet> {


  @override
  Widget build(BuildContext context) {
    final radius = 16.0;
    final size = MediaQuery.of(context).size;
    final maxHeight =  size.height * .5;

    return SlidingUpPanel(
        color: Colors.white,

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
        panel: Column(
          children: <Widget>[
            _fakeDraggableWidget(),
            Container(
                margin: EdgeInsets.only(top: 10),
                height: maxHeight * .9,
                child: StandardOrder()
            ),
          ],
        ),
        onPanelClosed: () {
          if (Navigator.canPop(context))
            Navigator.pop(context);
        },
        minHeight: .0,
        maxHeight: maxHeight,
        defaultPanelState: PanelState.OPEN,

    );
  }

  Widget _fakeDraggableWidget() => Container(
    height: 20,
    child: Center(
        child: Container(
          width: 40,
          height: 4,
          child: Divider(
            thickness: 2,
            color: Colors.grey,
          ),
        )
    ),
  );
}
