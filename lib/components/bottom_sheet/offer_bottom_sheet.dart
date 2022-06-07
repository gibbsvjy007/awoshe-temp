import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/TextFieldPageRoute.dart';
import 'package:Awoshe/components/TextFields/AlwaysDisableFocusNode.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/TextFields/text_field_page.dart';
import 'package:Awoshe/components/checkbox/AwosheCircleCheckBox.dart';
import 'package:Awoshe/components/dropdown/awoshe_dropdown.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/currency/currency_store.dart';
import 'package:Awoshe/logic/stores/product/product_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/offer/Offer.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/PriceUtils.dart';
import 'package:Awoshe/utils/WidgetUtils.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';

class OfferBottomSheet extends StatefulWidget {

  final ViewMode viewMode;
  final Offer offer;

  const OfferBottomSheet({Key key,this.viewMode = ViewMode.DEFAULT, this.offer,}) : super(key: key);


  @override
  _OfferBottomSheetState createState() => _OfferBottomSheetState();
}

class _OfferBottomSheetState extends State<OfferBottomSheet> {
  bool measurementSelection = false;
  bool fabricSelection = false;
  bool wasRequested = false;

  DateTime selectedDate;

  final horizontalSpacer = SizedBox(width: 16,);
  final double iconSize = 52.0;
  final TextEditingController commentsController = TextEditingController();
  TextEditingController priceController;
  ProductStore productStore;
  UserStore userStore;
  String currentCurrency;
  final CurrencyStore currencyStore = CurrencyStore();

  @override
  void initState() {

    productStore = Provider.of<ProductStore>(context, listen: false);
    userStore = Provider.of<UserStore>(context, listen: false);

    if (widget.viewMode == ViewMode.CHECKING_OFFER) {
      commentsController.text = widget.offer.comment;
      selectedDate = widget.offer.deliveryDate;
      measurementSelection = widget.offer.measurement;
      fabricSelection = widget.offer.fabric;

      currentCurrency = productStore.product.currency;

      priceController = MoneyMaskedTextController(
          initialValue: PriceUtils.formatPriceToDouble(
              productStore.product.price ?? '0'),
          decimalSeparator: '.',
          thousandSeparator: ',');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final verticalSpacer = SizedBox(height: 10.0,);

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
        child: Stack(

          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                Container(
                  child: Text("I'd like to customize", textAlign: TextAlign.center,),
                ),

                // measure and fabric section
                measurementsAndFabricSection(),
                optionSeparatorWidget(verticalMargin: 2.0),

                // deliver section
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SvgIcon(Assets.deliver, size: iconSize,),
                            SizedBox(width: 4.0,),
                            Text('Delivered by:', style: TextStyle(color: awBlack),),
                          ],
                        ),

                        (selectedDate == null) ?
                        Container() :
                        Flexible(child: Text('${selectedDate.day}. '
                            '${selectedDate.month}. ${selectedDate.year}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700, color: awBlack
                          ),
                        )),

                        Material(
                          color: Colors.transparent,
                            child: IconButton(
                              onPressed: (){
                                var timeNow = DateTime.now();
                                DatePicker.showDatePicker(
                                  context,
                                  minTime: timeNow,
                                  //locale: LocaleType.de,
                                  currentTime: selectedDate ?? timeNow,
                                  onConfirm: (DateTime time){
                                    print(time);
                                    setState(()  => selectedDate = time);
                                  },
                                );
                              },

                              icon: Icon(Icons.date_range),
                              color: awBlack,
                              iconSize: 28,
                              padding: EdgeInsets.all(4.0),
                            ),
                        ),
                      ],
                    ),

                  ],
                ),

                optionSeparatorWidget(verticalMargin: 2.0),
                verticalSpacer,

                // comments section
                commentsSection(),
                optionSeparatorWidget(verticalMargin: 2.0),
                verticalSpacer,


                (widget.viewMode == ViewMode.CHECKING_OFFER) ? priceSection() : Container(),

                Align(
                  alignment: Alignment.bottomRight,
                  child: RoundedButton(
                    height: 30,
                    width: 100,
                    buttonColor: primaryColor,
                    borderWidth: .0,
                    buttonName: 'Send',
                    onTap: (){
                      if (widget.viewMode == ViewMode.DEFAULT)
                        requestOffer();
                      else
                        approveOffer();
                    },
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget measurementsAndFabricSection() =>
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SvgIcon(
                  Assets.customize,
                  size: iconSize,
                ),
                // space
                Text('Measurements', style: TextStyle(color: awBlack),),
                horizontalSpacer,
                AwosheCircleCheckBox(
                  onTap: () {
                    setState(() {
                      measurementSelection = !measurementSelection;
                    });
                  },
                  isSelected: measurementSelection,
                  defaultColor: awLightColor,
                  iconSize: 24,
                ),
              ],
            ),
          ),

          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Fabric',style: TextStyle(color: awBlack),),

                AwosheCircleCheckBox(
                  onTap: () {
                    setState(() {
                      fabricSelection = !fabricSelection;
                    });
                  },
                  isSelected: fabricSelection,
                  defaultColor: awLightColor,
                  iconSize: 24,
                ),
              ],
            ),
          ),
        ],
      );

  Widget commentsSection() => Row(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SvgIcon(
        Assets.comments,
        size: iconSize,
      ),

      Expanded(
        child: InputFieldV2(
          hintText: 'Type comments here...',
          obscureText: false,
          focusNode: AlwaysDisabledFocusNode(),
          onTap: (){
            Navigator.push(context,
                TextFieldPageRoute(
                    page: TextFieldPage(
                      title: 'Comments',
                      initialText: commentsController.text,
                      hint: 'Type comments here...',
                      maxLines: 4,
                      inputType: TextInputType.text,
                      onDone: (data) {
                        setState(() {
                          commentsController.text = data;
                        });

                        Navigator.pop(context);
                      },
                      fieldDecoration: FieldDecoration.ROUNDED,
                    ),
                ),
            );
          },
          hintStyle: TextStyle(color: awLightColor),
          textInputType: TextInputType.text,
          textStyle: textStyle,
          controller: commentsController,
          radius: APP_INPUT_RADIUS,
          leftPadding: 20.0,
          maxLines: 4,
          textFieldColor: textFieldColor,
          textAlign: TextAlign.left,
          bottomMargin: 15.0,
        ),
      ),
    ],
  );


  Widget priceSection() => Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SvgIcon(Assets.price,
        size: iconSize,
      ),

      Container(width: 20,),

      Text('Price: ', ),

      Container(width: 10,),

      Expanded(
        child: Container(
          child: InputFieldV2(
            obscureText: false,
            focusNode: AlwaysDisabledFocusNode(),
            onTap: (){
              Navigator.push(context,
                TextFieldPageRoute(
                  page: TextFieldPage(
                    title: 'Price',
                    hint: 'Price',
                    maxLines: 1,
                    initialText: priceController.text,
                    inputType: TextInputType.number,
                    onDone: (data) {
                      setState(() {
                        priceController.text = data;
                      });

                      Navigator.pop(context);
                    },

                  ),
                ),
              );
            },
            hintStyle: TextStyle(color: awLightColor),
            textInputType: TextInputType.text,
            textStyle: textStyle,
            controller: priceController,
            radius: APP_INPUT_RADIUS,
            leftPadding: 20.0,
            maxLines: 1,
            textFieldColor: textFieldColor,
            textAlign: TextAlign.left,
            bottomMargin: 15.0,
          ),
        ),
      ),

      Expanded(
        child: _currencyDropButton(),
      ),


    ],
  );


  bool validate() {
    if (selectedDate == null){
      showToast('You must provide a date');
      return false;
    }

    if(commentsController.text.isEmpty){
      showToast('You must provide comments');
      return false;
    }

    if (widget.viewMode == ViewMode.CHECKING_OFFER){
      if (priceController.text.isEmpty){
        showToast('You must provide the price');
        return false;
      }
    }

    return true;
  }

  void requestOffer(){
    if ( validate() ){
      try {
        if (this.wasRequested){
          showToast('Offer already requested',
              type: ToastType.WARNING
          );
          return;
        }

        productStore.offerService.requestAnOffer(
          userId: userStore.details.id,
          productId: productStore.product.id,
          offer: Offer(
              comment: commentsController.text,
              fabric: fabricSelection,
              measurement: measurementSelection,
              deliveryDate: selectedDate,
              productImageUrl: productStore.product.imageUrl,
              productName: productStore.product.title
          ),
        );

        wasRequested = true;
        ShowFlushToast(context, ToastType.SUCCESS, 'Order resquested',
            callback: (){
              Navigator.pop(context);
            }
        );

      }
      catch(ex){
        showToast('Was not possible request the offer!',
            type: ToastType.ERROR
        );
      }
    }

  }

  void approveOffer(){
    print('Approve offer');
    if ( validate() ){
      try {
        productStore.offerService.approveOffer(

          userId: userStore.details.id,
          productId: productStore.product.id,

          offer: Offer(
              comment: commentsController.text,
              fabric: fabricSelection,
              measurement: measurementSelection,
              deliveryDate: selectedDate,
              productImageUrl: productStore.product.imageUrl,
              productName: productStore.product.title,
              price: priceController.text,
              requestedBy: widget.offer.requestedBy
          ),
        );

        wasRequested = true;
        ShowFlushToast(context, ToastType.SUCCESS, 'Order requested',
            callback: (){
              Navigator.pop(context);
            }
        );

      }
      catch(ex){
        showToast('Was not possible request the offer!',
            type: ToastType.ERROR
        );
      }
    }
  }

  void showToast(String msg, {ToastType type}) =>
      ShowFlushToast(context, type ?? ToastType.WARNING, msg,);

  Widget _currencyDropButton() =>
      Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),

        child:Container(
          margin: EdgeInsets.only(bottom: 15.0,),

          child: AwosheDropdown(
            color: Colors.white,
            options: CURRENCIES,
            radius: APP_INPUT_RADIUS,
            hintStyle: hintStyle,
            selectedValue: currentCurrency,
            disableHint: currentCurrency,

//            onChange: (currency){
//              setState(() {
//
//                double value = PriceUtils.formatPriceToDouble(priceController.text);
//                  currencyStore.convertValue(value: value, from: currentCurrency, to: currency);
//
//                currentCurrency = currency;
//
//                priceController.text = PriceUtils.formatPriceToString(value);
//              });
//              },
          ),
        ),
      );

}
