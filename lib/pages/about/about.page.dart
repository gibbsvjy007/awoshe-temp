import 'package:Awoshe/components/toprightclosefab.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/WidgetUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AboutPage extends StatelessWidget {

  Widget buildDivider() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Divider(
          height: 1.0,
        ),
      );

  Widget buildTrailingWidget() => SizedBox(
        width: 50.0,
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.arrow_forward_ios, color: awLightColor300)
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar: AwosheSimpleAppBar(
        title: 'About',
      ),*/
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(30.0),
        child: AwosheTopRightCloseFab(
          onPressed: () => Navigator.pop(context),

        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                title: Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Text('Copyright'.toUpperCase()),
                ),

                trailing: buildTrailingWidget(),
                onTap: () {
                  launchURL('CopyRight', 'copyright_url', context);
                },
              ),
              buildDivider(),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                title: Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Text('Terms & Conditions'.toUpperCase()),
                ),

                trailing: buildTrailingWidget(),
                onTap: () {
                  launchURL(
                      'Terms and Condition', 'terms_and_condition', context);
                },
              ),
              buildDivider(),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                title: Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Text('Privacy Policy'.toUpperCase()),
                ),

                trailing: buildTrailingWidget(),
                onTap: () {
                  launchURL('Privacy Policy', 'privacy_policy', context);
                },
              ),
              buildDivider(),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                title: Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Text('Rate App'.toUpperCase()),
                ),

                trailing: buildTrailingWidget(),
                onTap: () {},
              ),
              buildDivider(),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                title: Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Text('About Awoshe'.toUpperCase()),
                ),

                trailing: buildTrailingWidget(),
                onTap: () {},
              ),
              buildDivider(),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Text(
                  'v1.0.0',
                  style: TextStyle(color: awLightColor, fontSize: 12.0),
                ),
              )
            ],
          ),


        ],
      ),
        bottomNavigationBar: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Proudly made with', style: TextStyle( fontSize: 10.0),),

                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset('assets/svg/Icons/heartfilled.svg', height: 8, width: 8, color: Colors.red,),
                ),

                Text(' in ', style: TextStyle( fontSize: 10.0),),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset('assets/svg/swissflag.svg', height: 8, width: 8,),
                ),
              ],
            ))
    );
  }
}
