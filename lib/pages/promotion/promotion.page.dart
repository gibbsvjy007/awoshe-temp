import 'package:Awoshe/components/closefab.dart';
import 'package:Awoshe/services/auth.service.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:flutter/material.dart';

import '../../router.dart';

class PromotionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AwosheCloseFab(
        onPressed: () async {
          await AuthenticationService.instance.signOut();
          AppRouter.router.navigateTo(context, Routes.login);
        },
        putThere: Alignment.bottomRight,
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Assets.awosheLogo,
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
              ),
              SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Thanks for the  Registration",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                    "We are creating the largest inventory of contemporary fashion items from Africa. Designers can email info@awoshe.com to join. we can't wait to hear from you.  ",
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300)),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                    "World class fashion shopping experience awaits all other users. We'll be right back!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.0,
                        color: awLightColor,
                        fontWeight: FontWeight.w300)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
