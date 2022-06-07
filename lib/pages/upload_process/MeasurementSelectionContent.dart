import 'package:Awoshe/common/app.data.dart';
import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/float_next_button/FloatNextButton.dart';
import 'package:Awoshe/components/option_list/OptionListItem.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/pages/measurement/CustomMeasurementCreationPage.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MeasurementSelectionContent extends StatefulWidget {
  final List<int> indexesSelected;
  final VoidCallback onBackCallback;
  final VoidCallback nextCallback;
  final VoidCallback saveAndExitCallback;

  const MeasurementSelectionContent({Key key,
    this.nextCallback, this.indexesSelected, this.onBackCallback,
    this.saveAndExitCallback}) : super(key: key);

  @override
  _MeasurementSelectionContentState createState() => _MeasurementSelectionContentState();
}

class _MeasurementSelectionContentState extends State<MeasurementSelectionContent> {

  //List<int> indexesSelected;
  final defaultStyle = textStyle.copyWith(fontFamily: 'Muli', fontSize: 20.0, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    UploadStore store = Provider.of<UploadStore>(context);

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
          margin: EdgeInsets.only(left: 16.0,right: 16.0, bottom: 30.0, top: 16.0),
          child: Row(
            children: <Widget>[

              Expanded(
                child: RichText(
                  textAlign: TextAlign.justify,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: '"Beauty comes in all shapes and sizes", we all love ',
                    style: textStyle2.copyWith(color: awBlack),

                    children: <TextSpan>[
                      TextSpan(
                        text: 'made to measure ',
                        style: textStyle2.copyWith(color: primaryColor),
                      ),

                      TextSpan(
                        text: 'designs. Provide the measurements needed for a perfect fit',
                        style: textStyle2.copyWith(color: awBlack),
                      )
                    ],
                  ),
                ),
              ),
            ],
            mainAxisSize: MainAxisSize.max,
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: GestureDetector(
            onTap: (){},
            // onTap: (){
            //   Navigator.push(context,
            //     MaterialPageRoute(
            //       builder: (_) => CustomMeasurementCreationPage()
            //     ),
            //   );
            // },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('Custom measurement needed',
                  maxLines: 2,
                  style: textStyle.copyWith(color: primaryColor),),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                      width: 60.0,
                      child: AwosheRaisedButton(
                        childWidget: Text(
                          Localization.of(context).help,
                          style: textStyle14sec,
                        ),
                        onTap: () {},
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        buttonColor: awYellowColor,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),

        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1, right:  MediaQuery.of(context).size.width*0.1, bottom:  MediaQuery.of(context).size.width*0.1),
            child: ListView.builder(
              shrinkWrap: true,

              itemBuilder: (context, int index) {
                if (index == AppData.MEASUREMENT_LIST.length)
                  return Container(height: 30.0,);

                String measurement = AppData.MEASUREMENT_LIST[index];

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 12.0),
                  child: Observer(
                    builder: (context) =>
                        OptionListItem(
                          title: measurement,titleStyle: TextStyle(fontSize: 17.0),
                          isSelected: (store.measurements.contains(measurement))
                              ? true
                              : false,
                          onTap: () {
                            (store.measurements.contains(measurement)) ?
                            store.removeMeasurement(measurement)
                                : store.addMeasurement(measurement);
                          },
                        ),
                  ),
                );
              },
              itemCount: AppData.MEASUREMENT_LIST.length + 1,
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

}
