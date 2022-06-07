import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';

class ReviewMessageWidget extends StatelessWidget {
  final String productDescription;
  final String date;
  final String productImagePath;

  ReviewMessageWidget({this.productDescription, this.date, this.productImagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(179, 193, 201, 0.3), borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Row(children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(height: 70.0, width: 70.0, child: Image.network(this.productImagePath))),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                    ),
                    Expanded(flex: 2, child: Text(productDescription))
                  ]),
                ),
              ),
              Container(
                color: secondaryColor,
                height: 50.0,
                width: 1.0,
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              ),
              Expanded(
                flex: 1,
                child: Text('Received on $date', style: TextStyle(color: Color.fromRGBO(179, 193, 201, 1.0))),
              )
            ],
          ),
          Divider(color: secondaryColor,),
          Row(
            children: <Widget>[
              Text(
                'Your review includes',
                style: boldText,
              ),
            ],
          ),
          Text(
            'Rating of the item, the use of the app, '
                'and the communication with the designer. '
                'This will help us improve the user experience '
                'and help other users who would like to buy this '
                'item as well',
            style: lightText,
          ),
          Divider(color: secondaryColor,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text('No Thanks'),
              ),
              AwosheButton(
                  onTap: () {
                    print("write review");
                  },
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  childWidget: Text(
                    'Write a Review',
                    style: buttonTextStyle,
                  ),
                  buttonColor: primaryColor)
            ],
          )
        ],
      ),
    );
  }
}
