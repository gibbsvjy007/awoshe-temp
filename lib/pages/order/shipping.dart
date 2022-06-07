import 'package:Awoshe/common/address_change_dialog.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/address/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:provider/provider.dart';

class ShippingOrder extends StatefulWidget {
  ShippingOrder();

  @override
  ShippingOrderState createState() => new ShippingOrderState();
}

class ShippingOrderState extends State<ShippingOrder> {
  bool isBillingExpanded = true;
  bool isShippingExpanded = true;
  UserStore _userStore;

  @override
  didChangeDependencies() {
    _userStore ??= Provider.of<UserStore>(context);
    super.didChangeDependencies();
  }

  Widget renderAddress(Address address, type) => Container(
        margin: const EdgeInsets.only(left: 20.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(address.fullName,
                style: TextStyle(color: secondaryColor, fontSize: 16.0)),
            Text(address.street, style: TextStyle(color: awLightColor)),
            Text(address.city + ', ' + address.zipCode,
                style: TextStyle(color: awLightColor)),
            Text(address.state, style: TextStyle(color: awLightColor)),
            Text(address.country, style: TextStyle(color: awLightColor)),
            // Text(doc['zipCode'], style: TextStyle(color: awLightColor)),
            SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(
                    Icons.edit,
                    color: secondaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (BuildContext context) =>
                            AddressDialog(type: type),
                      ),
                    );
                  },
                  label: Text(
                    "Edit",
                    style: TextStyle(color: secondaryColor),
                  ),
                )
              ],
            ),
          ],
        ),
      );

  Widget addAddress(int type) => Center(
        child: Column(
          children: <Widget>[
            Text("No address specified. Please add an address"),
            SizedBox(height: 10.0),

            FlatButton.icon(
              icon: Icon(
                Icons.add,
                color: secondaryColor,
              ),

              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(fullscreenDialog: true,
                      builder: (BuildContext context) =>
                          AddressDialog(type: type)
                  ),
                );
              },

              label: Text(
                "Add Address",
                style: TextStyle(color: secondaryColor),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ExpansionTile(
          key: Key("1"),
          initiallyExpanded: true,
          title: Text('Shipping Address', style: textStyle1),
          backgroundColor: Colors.white,
          trailing: isShippingExpanded
              ? Icon(
                  Icons.keyboard_arrow_down,
                  size: 28.0,
                )
              : Icon(Icons.keyboard_arrow_right, size: 28.0),
          onExpansionChanged: (bool expanding) =>
              setState(() => this.isShippingExpanded = expanding),
          children: <Widget>[
            (_userStore.details.address1 == null)
                ? addAddress(0)
                : Column(
                    children: <Widget>[
                      renderAddress(_userStore.details.address1, 0)
                    ],
                  ),
          ],
        ),
        ExpansionTile(
          key: Key("2"),
          initiallyExpanded: true,
          title: Text('Billing Address', style: textStyle1),
          backgroundColor: Colors.white,
          trailing: isBillingExpanded
              ? Icon(
                  Icons.keyboard_arrow_down,
                  size: 28.0,
                )
              : Icon(Icons.keyboard_arrow_right, size: 28.0),
          onExpansionChanged: (bool expanding) {
            setState(() => this.isBillingExpanded = expanding);
          },
          children: <Widget>[
            (_userStore.details.address2 == null)
                ? addAddress(1)
                : Column(
                    children: <Widget>[
                      renderAddress(_userStore.details.address2, 1)
                    ],
                  ),
          ],
        ),
        SizedBox(height: 30.0),
      ],
    );
  }
}
