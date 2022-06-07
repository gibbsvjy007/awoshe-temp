import 'package:Awoshe/components/bottom_sheet/custom_order_bottom_sheet.dart';
import 'package:Awoshe/components/bottom_sheet/offer_bottom_sheet.dart';
import 'package:Awoshe/logic/stores/product/product_store.dart';
import 'package:Awoshe/models/offer/Offer.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


enum CustomizeBodyType {DEFAULT, CUSTOM_ORDER, OFFER }

class CustomizeBottomSheet extends StatefulWidget {
  final Color backgroundColor;
  final ValueChanged<int> onIndexSelected;
  final ViewMode viewMode;
  final Offer offer;

  const CustomizeBottomSheet(
      {Key key, this.backgroundColor, this.onIndexSelected,
        this.viewMode = ViewMode.DEFAULT, this.offer})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomizeBottomSheetState();
}


class _CustomizeBottomSheetState extends State<CustomizeBottomSheet> {
  static const DEFAULT_HEIGHT = 220.0;
  final radius = 16.0;

  CustomizeBodyType bodyType;
  double containerHeight = DEFAULT_HEIGHT;

  @override
  void initState() {

    switch(widget.viewMode){

      case ViewMode.CHECKING_OFFER:
        bodyType = CustomizeBodyType.OFFER;
        containerHeight = (widget.viewMode == ViewMode.CHECKING_OFFER) ? 420 : 380;
        break;

      case ViewMode.ORDERING_OFFER:
        bodyType = CustomizeBodyType.CUSTOM_ORDER;
        containerHeight = 450;
        break;

      default:
        bodyType = CustomizeBodyType.DEFAULT;
        break;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).copyWith(
        canvasColor: Colors.transparent, backgroundColor: Colors.white);

    return Theme(
      data: themeData,
      child: getBody(),
    );
  }

  Widget getBody() {
    var widget;
    var panelBody;
    switch (bodyType) {
      case CustomizeBodyType.DEFAULT:
        widget = buildDefaultBody();
        break;

      case CustomizeBodyType.CUSTOM_ORDER:
        panelBody = Container(
          margin: EdgeInsets.only(top: 30),
          child: CustomOrderBottomSheet(
            product: Provider.of<ProductStore>(context).product,
            viewMode: this.widget.viewMode ?? ViewMode.DEFAULT,
            offer: this.widget.offer,
          ),
        );

        widget = buildAnimatedPanel(panelChild: panelBody);
        break;

      case CustomizeBodyType.OFFER:
        panelBody = Container(
          margin: EdgeInsets.only(top: 30),
          child: OfferBottomSheet(
            viewMode: this.widget.viewMode ?? ViewMode.DEFAULT,
            offer: this.widget.offer,
          ),
        );

        widget = buildAnimatedPanel(panelChild: panelBody);
        break;
    }
    return widget;
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

  Widget buildDefaultBody() => AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        height: containerHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _fakeDraggableWidget(),
            ListTile(
              leading: SvgIcon(
                Assets.customize,
                size: 35.0,
                color: awBlack,
              ),
              title: Text('Custom order with measurements',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: awBlack)),
              onTap: () {
                var measurements = Provider.of<ProductStore>(context)
                    .product
                    .customMeasurements;
                if (measurements == null || measurements.isEmpty) {
                  ShowFlushToast(context, ToastType.WARNING,
                      "This item is available in only standard sizes");
                } else {
                  setState(() {
                    bodyType = CustomizeBodyType.CUSTOM_ORDER;
                    containerHeight = 450;
//
                  });
                }
              },
            ),
            ListTile(
              leading: SvgIcon(
                Assets.offer,
                size: 35.0,
                color: awBlack,
              ),
              title: Text('Request an offer',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: awBlack)),
              onTap: () async {
                setState(() {
                  bodyType = CustomizeBodyType.OFFER;
                  containerHeight = (widget.viewMode == ViewMode.CHECKING_OFFER) ? 410 : 380;
                });
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0.0),
              width: double.infinity,
              height: 1,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.05),
                  borderRadius: BorderRadius.circular(radius)),
            ),
            ListTile(
              leading: SvgIcon(
                Assets.cancel,
                size: 35.0,
                color: awBlack,
              ),
              title: Text('Cancel', style: TextStyle(color: awBlack)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      );

  Widget buildAnimatedPanel({@required Widget panelChild}) => AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeIn,
    height: containerHeight,
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius), // default 16.0
          topRight: Radius.circular(radius)),
    ),

    child: SlidingUpPanel(
      color: Colors.white,
      maxHeight: containerHeight,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
      panel: Stack(
        children: <Widget>[
          _fakeDraggableWidget(),
          panelChild
        ],
      ),
      onPanelClosed: () {
        if (Navigator.canPop(context))
          Navigator.pop(context);
      },
      minHeight: .0,
      defaultPanelState: PanelState.OPEN,
    ),
  );
}
