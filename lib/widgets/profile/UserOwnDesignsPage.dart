
import 'package:Awoshe/components/awsliverappbar.dart';
import 'package:Awoshe/components/closefab.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/pages/profile/profile_designs_tab.dart';
import 'package:flutter/material.dart';

class UserOwnDesignsPage extends StatelessWidget {
  final String designerId;
  const UserOwnDesignsPage({Key key, @required this.designerId}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          AwosheSliverAppBar(
            title: Localization.of(context).designs,
          ),

          DesignsTab(
            designerId: this.designerId,
            profileType: 'PRIVATE',
          ),
        ],
      ),

      floatingActionButton: AwosheCloseFab(
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
