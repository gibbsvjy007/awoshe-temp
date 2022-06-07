import 'package:Awoshe/components/TextFieldPageRoute.dart';
import 'package:Awoshe/components/TextFields/AlwaysDisableFocusNode.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/TextFields/text_field_page.dart';
import 'package:Awoshe/components/float_next_button/FloatNextButton.dart';
import 'package:Awoshe/components/product_care/CareOptionBoard.dart';
import 'package:Awoshe/components/product_care/CareOptionSection.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/product_care_assets.dart';
import 'package:Awoshe/widgets/awoshe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProductCarePage extends StatefulWidget {
  final UploadType uploadType;
  final VoidCallback onBackCallback;
  final ValueChanged<bool> nextCallback;
  final VoidCallback saveAndExitCallback;


  const ProductCarePage({Key key, this.onBackCallback,
    this.nextCallback, this.saveAndExitCallback,
    this.uploadType = UploadType.DESIGN})
      : super(key: key);
  @override
  _ProductCarePageState createState() => _ProductCarePageState();
}

class _ProductCarePageState extends State<ProductCarePage> {

  TextEditingController _careTipController;
  UploadStore store;

  @override
  void didChangeDependencies() {
    store ??= Provider.of<UploadStore>(context);
    _careTipController ??= TextEditingController(text: store.careTip);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final text = (store.productType == ProductType.DESIGN)
        ? 'design'
        : 'fabric';
    final body = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'How should customers wash or care'
                  ' for this awesome $text.',
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle2.copyWith(color: awBlack),
                ),
              ),
            ],
            mainAxisSize: MainAxisSize.max,
          ),
        ),

        _firstCareOptionsList(),

        _secondCareOptionList(),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: _productCareField(),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        ),
      ],
    );

    return Scaffold(
      body: SingleChildScrollView(child: body),

      floatingActionButton: FloatNextButton(
        title: Localization
            .of(context)
            .next,
        onPressed: () {
          if (widget.nextCallback != null) {
            widget.nextCallback(store.productCareInfo.isNotEmpty);
          }
        },
      ),
    );
  }

  Widget _productCareField() => InputFieldV2(
    hintText: Localization.of(context).productCare,
    obscureText: false,
    focusNode: AlwaysDisabledFocusNode(),
    onTap: (){
      Navigator.push(context,
        TextFieldPageRoute(
          page: TextFieldPage(
            title: Localization.of(context).productCare,
            initialText: store.careTip ?? '',
            hint: Localization.of(context).productCare,
            maxLines: 1,
            inputType: TextInputType.text,
            onDone: (data) {
              _careTipController.text = data;
              store.setCareTip(_careTipController.text);

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
    controller: _careTipController,
    radius: APP_INPUT_RADIUS,
    maxLines: 1,
    textFieldColor: textFieldColor,
    textAlign: TextAlign.left,
    bottomMargin: 15.0,
    leftPadding: 20.0,
  );

//      InputFieldV2(
//    hintText: Localization
//        .of(context)
//        .productCare,
//    obscureText: false,
//    hintStyle: TextStyle(color: awLightColor),
//    textInputType: TextInputType.text,
//    textStyle: textStyle,
//    controller: _careTipController,
//    textFieldColor: textFieldColor,
//    textAlign: TextAlign.left,
//    radius: APP_INPUT_RADIUS,
//    leftPadding: 20.0,
//    bottomMargin: 50.0,
//
//    onChanged: (data) => store.setCareTip(_careTipController.text),
//  );

  Widget _firstCareOptionsList() =>
      Container(
        height: 360,

        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),

          children: <Widget>[
            // machine wash board options
            Container(
                width: MediaQuery.of(context).size.width * .9,
                child: AwosheCard(
                  //elevation: 2.0,
                  child: CareOptionBoard(
                    categoryType: ProductCareCategory.MACHINE_WASH,
                    headerTitle: 'Machine Wash',
                    sections: [

                      _newCreateSection(
                        title: 'Temperature',
                        options: [ProductCareType.MWT_COLD,ProductCareType.MWT_WARM, ProductCareType.MWT_HOT ]
                      ),

                      _newCreateSection(
                          title: 'Cycle',
                          options: [ProductCareType.MWC_NORMAL, ProductCareType.MWC_PERMANENT_PRESS,ProductCareType.MWC_DELICATE ]
                      ),

                      _newCreateSection(
                          title: 'Special',
                          options: [ProductCareType.MWS_HAND_WASH,ProductCareType.MWS_DO_NOT_WASH ]
                      ),

                    ],
                  ),
                ),
              ),

            Container(width: 6.0,),

            // Dryer board options
            Container(
              width: MediaQuery.of(context).size.width * .9,
              child: AwosheCard(
                //elevation: 2.0,
                child: CareOptionBoard(
                  categoryType: ProductCareCategory.DRYER,
                  headerTitle: 'Dryer',
                  sections: [

                    _newCreateSection(
                        title: 'Temperature',
                        options: [ProductCareType.DRT_LOW,
                          ProductCareType.DRT_MEDIUM, ProductCareType.DRT_HIGH,]
                    ),

                    _newCreateSection(
                      title: 'Cycle',
                      options: [ProductCareType.DRC_NORMAL,
                        ProductCareType.DRC_PERMANENT_PRESS, ProductCareType.DRC_DELICATE,]
                    ),

                    _newCreateSection(title: 'Special',
                        options: [ProductCareType.DRS_DO_NOT_DRY_IN_DRYER]
                    )
                  ],
                ),
              ),
            ),

            Container(width: 6.0,),
            // Iron board options
            Container(
              width: MediaQuery.of(context).size.width * .9,
              child: AwosheCard(
                //elevation: 2.0,
                child: CareOptionBoard(
                  categoryType: ProductCareCategory.IRON,
                  headerTitle: 'Iron',
                  sections: [
                    _newCreateSection(
                      title: 'Temperature',
                      options: [
                        ProductCareType.IRT_LOW,
                        ProductCareType.IRT_MEDIUM,
                        ProductCareType.IRT_HIGH,
                      ],
                    ),

                    _newCreateSection(title: 'Special',
                        options: [ProductCareType.IRS_DO_NOT_IRON_STEAM,
                          ProductCareType.IRS_IRON_STREAM,ProductCareType.IRS_DO_NOT_IRON,
                        ]
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _secondCareOptionList() => Container(
    height: 210,

    child: ListView(
      scrollDirection: Axis.horizontal,
      //shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),

      children: <Widget>[
        // Bleach options
        Container(
          width: MediaQuery.of(context).size.width * .9,
          child: AwosheCard(
            //elevation: 2.0,
            child: CareOptionBoard(
              categoryType: ProductCareCategory.BLEACH,
              headerTitle: 'Bleach',

              sections: [
                _newCreateSection(
                    orientation: Axis.horizontal,
                    options: [
                      ProductCareType.BL_DO_NOT_BLEACH,
                      ProductCareType.BL_NON_CHLORINE_BLEACH,
                      ProductCareType.BL_BLEACH_WHEN_NEEDED,
                    ],
                ),
              ],
            ),
          ),
        ),

        Container(width: 6.0,),

        // Dry options
        Container(
          width: MediaQuery.of(context).size.width * .9,
          child: AwosheCard(
            //elevation: 2.0,
            child: CareOptionBoard(
              categoryType: ProductCareCategory.DRY,
              headerTitle: 'Dry',
              sections: [
                _newCreateSection(
                  orientation: Axis.horizontal,
                  options: [
                    ProductCareType.DY_HANG,
                    ProductCareType.DY_DO_NOT_WRING,
                    ProductCareType.DY_FLAT,
                  ]
                ),

              ],
            ),
          ),
        ),

        Container(width: 6.0,),

        // Dry clean
        Container(
          width: MediaQuery.of(context).size.width * .9,
          child: AwosheCard(
            //elevation: 2.0,
            child: CareOptionBoard(
              categoryType: ProductCareCategory.DRY_CLEAN,
              headerTitle: 'Dry clean',

              sections: [
                _newCreateSection(
                  orientation: Axis.horizontal,
                  options: [
                    ProductCareType.DYC_DRY_CLEAN,
                    ProductCareType.DYC_DO_NOT_DRY_CLEAN,
                  ],
                ),

              ],
            ),
          ),
        ),

      ],
    ),
  );

  Widget _newCreateSection({
    String title,
    Axis orientation,
    List<ProductCareType> options}){
    return Observer(
      builder: (_) =>
          CareOptionSection(
            types: options,
            sectionTitle: title,
            selectedType: _verifyItemSelected(options),
            orientation: orientation,
            itemSelectionChange: _itemSelectionChange,
          ),
      );
  }

  void _itemSelectionChange(ProductCareType previous, ProductCareType current){
    store.removeCareOption(previous);

    if (current != null)
      store.addCareOption(current);

    print('Our list now ${store.productCareInfo}');
  }

  ProductCareType _verifyItemSelected(List<ProductCareType> options){

    ProductCareType type;

    for(var i=0; i < options.length; i++){
      if  (this.store.productCareInfo.contains( options[i] )){
        type = options[i];
        break;
      }
    }

    return type;
  }


}
