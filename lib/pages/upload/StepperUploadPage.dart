import 'package:Awoshe/components/appbar/UploadAppBar.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:fa_stepper/fa_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class StepperUploadPage extends StatefulWidget {

  const StepperUploadPage({Key key,}) : super(key: key);

  @override
  _StepperUploadPageState createState() => _StepperUploadPageState();
}

class _StepperUploadPageState extends State<StepperUploadPage> {
  UploadStore uploadStore;
  PageController controller;

  @override
  void initState() {
    uploadStore = Provider.of<UploadStore>(context, listen: false);
    controller = PageController(initialPage: uploadStore.currentStep);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: UploadAppBar(
          title: uploadStore.processType == ProcessType.UPLOAD ? 'Upload' : 'Update',
          onBackPressed: (){
            if (uploadStore.currentStep > 0){
              controller.animateToPage(uploadStore.currentStep - 1,
                  duration: Duration(milliseconds: 400), curve: Curves.easeOut );
              return;
            }
            uploadStore.clearStore();
            Navigator.pop(context);
          },

        onSaveExitPressed: (uploadStore.processType == ProcessType.UPLOAD)
            ? () => uploadStore.saveAndExit(context) : null,
      ),

      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: size.height * .1,
            child: Observer(
              builder: (_) => Container(
                margin: EdgeInsets.only(right: 8.0),
                child: FAStepper(
                  editingColor: primaryColor,
                  disableColor: awLightColor,
                  lineColor: awLightColor,
                  steps: uploadStore.productType == ProductType.DESIGN ? _buildDesignSteps() : _buildFabricSteps(),
                  currentStep: uploadStore.currentStep,
                  onStepTapped: (index){
                    print('$index clicked');
                    controller.animateToPage(index,
                        duration: Duration(milliseconds: 400), curve: Curves.easeOut );
                  },
                  controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue, VoidCallback onStepCancel}) => Container(),

                  type: FAStepperType.horizontal,
                  physics: ClampingScrollPhysics(),

                ),
              ),
            ),
          ),

          Expanded(
            child: PageView(
              //allowImplicitScrolling: false,
              onPageChanged: (index){
                print('On Page Changed $index');
                uploadStore.setCurrentStep(index);
              },
              controller: controller,
              physics:  uploadStore.processType == ProcessType.UPLOAD ? NeverScrollableScrollPhysics() : ClampingScrollPhysics(),
              children: uploadStore.productType == ProductType.DESIGN ? _buildDesignWidgets() : _buildFabricWidgets(),

            ),
          ),
        ],
      ),

    );
  }


  FAStepstate _defineCurrentStepState(int index, ){

    if (uploadStore.currentStep == index)
      return FAStepstate.editing;

    if(uploadStore.currentStep > index)
      return FAStepstate.complete;

     else return (uploadStore.processType == ProcessType.UPLOAD) ? FAStepstate.disabled : FAStepstate.complete;

  }

  List<FAStep> _buildDesignSteps() => [
    FAStep(
      title: Text('Basic Info'),
      content: Container(),
      state: _defineCurrentStepState(0),
    ),
    FAStep(
      title: Text('Care Info'),
      content: Container(),

      state: _defineCurrentStepState(1),
    ),
    FAStep(
      title: Text('Category & Sizes'),
      content: Container(),
      state: _defineCurrentStepState(2)
    ),
    FAStep(
      title: Text('Colors'),
      content: Container(),
      state: _defineCurrentStepState(3)
    ),
    FAStep(
      title: Text('Fabrics'),
      content: Container(),
      state: _defineCurrentStepState(4)

    ),
    FAStep(
      title: Text('Occasion'),
      content: Container(),
      state: _defineCurrentStepState(5)

    ),
    FAStep(
      title: Text('Measurements'),
      content: Container(),
      state: _defineCurrentStepState(6),
    ),

    FAStep(
      title: Text('Video'),
      content: Container(),
      state: _defineCurrentStepState(7),
    ),
    FAStep(
      title: Text('Photos & Price'),
      content: Container(),
      state: _defineCurrentStepState(8)

    ),
  ];

  List<FAStep> _buildFabricSteps() => [
    FAStep(
      title: Text('Basic Info'),
      content: Container(),
      state: _defineCurrentStepState(0),
    ),
    FAStep(
      title: Text('Care Info'),
      content: Container(),
      state: _defineCurrentStepState(1)
    ),
    FAStep(
      title: Text('Colors'),
      content: Container(),
      state: _defineCurrentStepState(2),
    ),
    FAStep(
      title: Text('Occasion'),
      content: Container(),
      state: _defineCurrentStepState(3)
    ),

     FAStep(
       title: Text('Video'),
       content: Container(),
       state: _defineCurrentStepState(4),
     ),

    FAStep(
      title: Text('Photos & Price'),
      content: Container(),
      state: _defineCurrentStepState(5)
    ),
  ];

  List<Widget> _buildDesignWidgets() => [
    uploadStore.basicInfoWidget(context, controller),
    uploadStore.careWidget(context, controller),
    uploadStore.categoryAndSizeWidget(context, controller),
    uploadStore.colorsWidget(context, controller),
    uploadStore.fabricWidget(context, controller),
    uploadStore.occasionWidget(context, controller),
    uploadStore.measurementWidget(context, controller),
    uploadStore.videoWidget(context, controller),
    uploadStore.photoAndPriceWidget(context),
  ];

  List<Widget> _buildFabricWidgets() => [
    uploadStore.basicInfoWidget(context, controller),
    uploadStore.careWidget(context, controller),
    uploadStore.colorsWidget(context, controller),
    uploadStore.occasionWidget(context, controller),
    uploadStore.photoAndPriceWidget(context),
  ];
}
