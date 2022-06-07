import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';

class PlanItem extends StatefulWidget {
  final String title;
  final String price;
  final String period;
  final List<String> features;
  final VoidCallback onCheckout;
  final double width, height;

  const PlanItem({Key key,
    @required this.title, @required this.price,
    @required this.features, this.onCheckout,
    this.width, this.height, @required this.period,
  }) : super(key: key);


  @override
  _PlanItemState createState() => _PlanItemState();
}

class _PlanItemState extends State<PlanItem> with SingleTickerProviderStateMixin {

  bool isExpanded = false;
  final defaultMargin = 8.0;

  final titleStyle = TextStyle(
      fontSize: 24,
      color: awLightColor
  );

  final priceStyle = TextStyle(
    color: Colors.black,
    fontSize: 30,
    fontWeight: FontWeight.w500,

  );

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        child: Container(
          child: Scrollbar(
              child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildTitlePriceSection(),
                  buildSeparator(),
                  buildFeaturesSection(),
                  checkoutButton(),
                ],
              ),
            ),
          ),
        ),
    );
  }

  Widget buildSeparator() => Row(
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin * 2, vertical: defaultMargin),
          height: 1.5,
          color: awLightColor.withOpacity(.4),
        ),
      ),
    ],
  );

  Widget buildTitlePriceSection() =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin , vertical: defaultMargin),
        child: Column(
          children: <Widget>[
            Text('${widget.title} SUBSCRIPTION',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: titleStyle,
            ),

            Container(
              margin: EdgeInsets.only(top: defaultMargin),
              child: RichText(
                maxLines: 2,
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.price,
                      style: priceStyle
                    ),

                    TextSpan(
                      text: '/month',
                      style: DefaultTextStyle.of(context).style.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]
                ),
              ),
            ),

          ],
        ),
      );

  Widget buildFeaturesSection() =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin * 3, vertical: defaultMargin),
        child: Column(
          children: widget.features.map( (feature) => createFeatureWidget(feature) ).toList(),
        ),
      );

  Widget createFeatureWidget(String feature) =>
    Container(
      margin: EdgeInsets.only(bottom: defaultMargin),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            Container(
              height: 6,
              width: 6,
              margin: EdgeInsets.only(right: defaultMargin * 2),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100)
              ),
            ),
            Expanded(child: Text(feature, maxLines: 2,
              style: textStyle.copyWith(fontSize: 16),
              textAlign: TextAlign.start,)),
          ],

      ),
    );


    Widget checkoutButton() =>
        Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin * 4, vertical: defaultMargin),

          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[

              Expanded(
                child: AwosheButton(
                  buttonColor: primaryColor,
                  childWidget: Text('Checkout', style: textStyle.copyWith(color: Colors.white),),
                  onTap: widget.onCheckout,
                ),
              ),

            ],
          ),
        );
}
