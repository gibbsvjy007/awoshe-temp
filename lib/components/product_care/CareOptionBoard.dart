import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/product_care_assets.dart';
import 'package:Awoshe/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class CareOptionBoard extends StatelessWidget {

  final ProductCareCategory categoryType;
  final String headerTitle;
  final List<Widget> sections;

  const CareOptionBoard({Key key,
    @required this.categoryType,
    @required this.sections, this.headerTitle,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final widgets = sections.map<Widget>( (section) {
      return Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            section,
            //_separator(),
          ],
        ),
      );
    } ).toList();


    return Column(
      children: <Widget>[
        _buildHeader(),

        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widgets,
          ),
        ),

      ],
    );
  }

//  Widget _separator() =>
//      Container(
//        width: 2,
//        color: Colors.grey,
//      );

  Widget _buildHeader() =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          SvgIcon(
            getProductCareCategoryIconPath(categoryType),
            size: 52.0,
          ),

          Text(headerTitle ?? '', style: textStyle,),

          Container(
            color: awLightColor,
            margin: EdgeInsets.symmetric(horizontal: 24.0,vertical: 4.0),
            height: 2,
          ),
        ],

      );
}
