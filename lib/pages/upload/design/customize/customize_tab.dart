  import 'dart:io';

import 'package:Awoshe/components/carousel/carousel.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_bloc_v2.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_details_form_bloc.dart';
import 'package:Awoshe/models/product/product.dart';

import 'package:Awoshe/pages/upload/design/customized_and_both.page.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CustomizeTab extends StatefulWidget {
  CustomizeTab(
      {Key key,
      this.designImages,
      this.productType,
      this.productData,
      //this.uploadDesignBloc,
      this.uploadDesignFormBloc
      })
      : super(key: key);
  final Product productData;
  final List<File> designImages;
  final ProductType productType;

  //final UploadDesignBloc uploadDesignBloc;
  final UploadDesignDetailsFormBloc uploadDesignFormBloc;

  @override
  _CustomizeTabState createState() => _CustomizeTabState();
}

class _CustomizeTabState extends State<CustomizeTab> {
  OrderType currentOrderType;
  UploadDesignBlocV2 _blocV2;

  @override
  void initState() {
    currentOrderType = OrderType.STANDARD;
    super.initState();
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    _blocV2 ??= Provider.of<UploadDesignBlocV2>(context);
  }
  _onTapped(index) {
    currentOrderType = index == 0 ? OrderType.STANDARD : OrderType.CUSTOM;
    setState(() {
    });
  }

  Map<int, Widget> ordersType = <int, Widget>{
    0: Text("Standard Order"),
    1: Text("Custom Order"),
  };

  Widget buildOrderType() => SizedBox(
        width: double.infinity,
        height: 30.0,
        child: CupertinoSegmentedControl<int>(
          children: ordersType,
          pressedColor: secondaryColor,
          onValueChanged: _onTapped,
          selectedColor: secondaryColor,
          borderColor: secondaryColor,
          groupValue: currentOrderType.index,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 200.0,
              width: double.infinity,
              child: Carousel(
                fromMemory: false,
                boxFit: BoxFit.cover,
                radius: Radius.circular(0.0),
                images: widget.designImages != null
                    ? widget.designImages.map((File _image) => _image.path).toList()
                    : [PLACEHOLDER_DESIGN_IMAGE],
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotColor: Colors.white,
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.transparent,
                borderRadius: false,
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  VerticalSpace(20.0),

                  buildOrderType(),
                  VerticalSpace(20.0),
                  Divider(
                    height: 3.0,
                    color: secondaryColor,
                  ),
                  VerticalSpace(15.0),

                  /// passing the order type here, Stanadard or Custom. Based on this type views will be rendered.
                  /// The reason to use this approach is to not write redundant codes.
                  Provider<UploadDesignBlocV2>.value(value: _blocV2,
                    child: CustomizedAndBothTab(
                      productData: _blocV2.product,
                      orderType: currentOrderType,
                      productType: widget.productType,
                      uploadDesignFormBloc: widget.uploadDesignFormBloc,
                      designImages: widget.designImages,
                    ),
                  )
                ],
              ),
            ),
          ]),
    );
  }
}
