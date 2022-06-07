import 'package:Awoshe/components/float_next_button/FloatNextButton.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/bloc/upload/SelectSizeBloc.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/models/size/SizeSelectionInfo.dart';
import 'package:Awoshe/pages/upload/selectcat.dart';
import 'package:Awoshe/pages/upload/selectsize.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CategorySizeContent extends StatelessWidget {
  final VoidCallback onBackCallback;
  final ValueChanged<bool> nextCallback;
  final VoidCallback saveAndExitCallback;

  const CategorySizeContent({Key key, this.nextCallback,
    this.onBackCallback, this.saveAndExitCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UploadStore store = Provider.of<UploadStore>(context);

    final body = Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: <Widget>[

              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Which category of design is this one'
                            ' and what sizes are available?',
                        maxLines: 3,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle2.copyWith(color: awBlack),
                      ),
                    ),
                  ),
                ],
                mainAxisSize: MainAxisSize.max,
              ),

            ],
          ),
        ),


        Container(
          child: _categoryField(context, store),
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        ),

        Container(
          //child: _nextButton(context),
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        ),
      ],
    );

    return Scaffold(
      body: body,

      floatingActionButton: FloatNextButton(
        title: Localization
            .of(context)
            .next,
        onPressed: () {
          if (nextCallback != null) {
            nextCallback(true);
          }
        },
      ),
    );

  }


  Widget _categoryField(BuildContext context, UploadStore store) =>
      Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            _openSelectCat(context);
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: awLightColor),
                borderRadius: BorderRadius.circular(APP_INPUT_RADIUS)
            ),
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Observer(
                  builder: (context) =>
                      Text(
                        store.categoriesLabel ?? 'Select Category and Sizes',
                        style: TextStyle(
                            color: awLightColor, fontWeight: FontWeight.w600),
                      ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 20.0,
                  color: awLightColor,
                )
              ],
            ),
          ),
        ),
      );

  void _openSelectCat(BuildContext context) async {
    UploadStore store = Provider.of<UploadStore>(context);

    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<bool>(
        fullscreenDialog: true,
        builder: (BuildContext context) =>
            SelectCat(
                store.mainCategory?.toLowerCase(),
                store.subCategory?.toLowerCase(),
                displaySubCategoriesMenu: true,
                callback: (mainCategory, subcategory) async {
                  if (subcategory.isNotEmpty) {
                    if ((mainCategory != store.mainCategory) &&
                        (subcategory != store.subCategory))
                      store.setSizeInfo(null);

                    store.setMainCategory(mainCategory);
                    store.setSubCategory(subcategory);

                    await _openSizesSelectionPage(context, mainCategory,
                        subcategory, store);
                  }

                  Navigator.pop(context);
                }
            ),
      ),
    );
  }

  Future _openSizesSelectionPage(BuildContext context,
      String mainCategory, String subcategory, UploadStore store) async {
    return Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<bool>(
        builder: (BuildContext context) =>
            Provider<SelectSizeBloc>(
              builder: (context) {
                var bloc = SelectSizeBloc();

                // before pass the sizesSelected to bloc we've to make sure if
                // the current category & subcategory selected is matching the sizes selected
                bloc.init(context, mainCategory, subcategory,
                  availableSizes: store.sizeInfo,
                );
                return bloc;
              },
              dispose: (context, bloc) {
                print('SelectSizeBloc dispose()');
                bloc.dispose();
              },

              child: SelectSizePage(
                store.mainCategory.toLowerCase(),
                store.subCategory?.toLowerCase(),

                callback: (SizeSelectionInfo sizeSelectionData) {
                  print('Size Selected $sizeSelectionData');
                  store.setSizeInfo(sizeSelectionData);
                },
              ),
            ),
      ),
    );
  }
}
