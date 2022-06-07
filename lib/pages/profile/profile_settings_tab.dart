import 'package:Awoshe/components/appBar.dart';
import 'package:Awoshe/components/currency_selector/currency_selector.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/pages/profile/profile_address.dart';
import 'package:Awoshe/pages/profile/profile_measurement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileAddressMeasurements extends StatefulWidget {
  final ProfileStore profileStore;
  final UserStore userStore;
  ProfileAddressMeasurements({Key key, this.userStore, this.profileStore}) : super(key: key);

  @override
  _ProfileAddressMeasurementsState createState() => new _ProfileAddressMeasurementsState();
}

class _ProfileAddressMeasurementsState extends State<ProfileAddressMeasurements> {
  dynamic deviceSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AwosheSimpleAppBar(
        title: "Address & Measurements",
      ),
      body: ListView(
            children: <Widget>[
              ProfileMeasurement(profileStore: widget.profileStore, userStore: widget.userStore,),
              ProfileAddress(profileStore: widget.profileStore, userStore: widget.userStore,),
              CurrencySelector(
                defaultCurrency: widget.userStore.details.currency,)
            ],

      ),
    );
  }
}
