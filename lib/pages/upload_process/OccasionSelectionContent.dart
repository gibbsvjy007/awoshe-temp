import 'package:Awoshe/common/app.data.dart';
import 'package:Awoshe/components/float_next_button/FloatNextButton.dart';
import 'package:Awoshe/components/option_list/OptionListItem.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class OccasionSelectionContent extends StatefulWidget {

  final List<int> indexesSelected;
  final VoidCallback onBackCallback;
  final VoidCallback nextCallback;
  final VoidCallback saveAndExitCallback;

  const OccasionSelectionContent({Key key, this.nextCallback,
    this.indexesSelected, this.onBackCallback,
    this.saveAndExitCallback}) : super(key: key);

  @override
  _OccasionSelectionContentState createState() => _OccasionSelectionContentState();
}

class _OccasionSelectionContentState extends State<OccasionSelectionContent> {

  UploadStore store;

  @override
  void didChangeDependencies() {
    store = Provider.of<UploadStore>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO add to localization file!
    final text = (store.productType == ProductType.DESIGN)
        ? 'design'
        : 'fabric';

    final body = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
//        Align(
//          alignment: Alignment.topLeft,
//          child: Container(
//            height: 4.0,
//            width: (MediaQuery
//                .of(context)
//                .size
//                .width / store.totalSteps) * store.currentStep,
//            color: Colors.amberAccent,
//            //alignment: Alignment.topRight,
//          ),
//        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                  child: Text(
                    'Where do you excpect customers to '
                        'take this $text?',
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
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Text('Select occasions', style: textStyle.copyWith(color: primaryColor),),
            ),
          ],
        ),

        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1, right:  MediaQuery.of(context).size.width*0.1, bottom:  MediaQuery.of(context).size.width*0.1),
            child: ListView.builder(
              shrinkWrap: true,

              itemBuilder: (context, int index) {
                if (index == AppData.OCCASION_LIST.length)
                  return Container(height: 30.0,);

                String occasion = AppData.OCCASION_LIST[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 12.0),
                  child: Observer(
                    builder: (context) =>
                        OptionListItem(
                          title: occasion,titleStyle: TextStyle(fontSize: 17.0),
                          isSelected: (store.occasions.contains(occasion))
                              ? true
                              : false,
                          onTap: () {
                            (store.occasions.contains(occasion)) ?
                            store.remoteOccasion(occasion) :
                            store.addOccasion(occasion);
                          },
                        ),
                  ),
                );
              },
              itemCount: AppData.OCCASION_LIST.length + 1,
            ),
          ),
        ),

      ],
    );

    return Scaffold(
//      appBar: UploadAppBar(
//        title: 'Upload',
//        onBackPressed: widget.onBackCallback,
//        onSaveExitPressed: widget.saveAndExitCallback,
//      ),

      body: body,

      floatingActionButton: FloatNextButton(
        title: Localization
            .of(context)
            .next,
        onPressed: widget.nextCallback,
      ),
    );
  }



//  Widget _nextButton() => AwosheButton(
//    onTap: widget.nextCallback,
//    childWidget:
//    Text(Localization.of(context).next, style: buttonTextStyle),
//    buttonColor: primaryColor,
//  );
}
