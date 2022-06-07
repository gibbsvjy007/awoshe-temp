import 'package:Awoshe/components/float_next_button/FloatNextButton.dart';
import 'package:Awoshe/components/video/awoshe_video_palyer.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class VideoSelection extends StatelessWidget {
  final VoidCallback onBackCallback;
  final VoidCallback nextCallback;

  //final VideoSelectionStore selectionStore = VideoSelectionStore();

  VideoSelection({Key key, this.onBackCallback, this.nextCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UploadStore store = Provider.of<UploadStore>(context);

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(child: textSection()),
          videoSection(store),
          
        ],
      ),
      floatingActionButton: FloatNextButton(
        title: Localization.of(context).next,
        onPressed: nextCallback,
      ),
    );
  }

  Widget textSection() => Container(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: RichText(
                textAlign: TextAlign.justify,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text:
                      "You can provide a single video sample of your design to improve users experience.",
                  style: textStyle2.copyWith(color: awBlack),
                ),
              ),
            ),
          ],
          mainAxisSize: MainAxisSize.max,
        ),
      );

  Widget videoSection(UploadStore store) => Observer(
        builder: (context) {
          var widget;
          //print('Video setup statis ${store.videoSetupStatus}');

          switch(store.videoSetupStatus){
            case VideoStatus.NONE:
              widget = Expanded(child: videoSelectionPanel(store));
              break;
            case VideoStatus.ANALISING:
              widget = Expanded(child: loadingWidget());
              break;
            case VideoStatus.DONE:
              print('DONE');
              widget = SingleChildScrollView(child: miniPlayerWidget(store));
              break;
            case VideoStatus.ERROR:
              widget = Expanded(child: videoSelectionPanel(store));
              Future.delayed( Duration(milliseconds: 500 ), 
                () => ShowFlushToast(context, ToastType.ERROR, 
                  store.videoSelectionError, callback: () {
                    store.clearVideoSelected();
                  }
                ), 
              ).then( (_) => store.clearVideoSelected() );
              break;
          }

          return widget;
        },
  );


  Widget miniPlayerWidget(UploadStore store) => Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 32.0),
        child: AwosheStepVideoPlayer(
          controller: store.videoPlayerController,
          width: 250,
          height: 250,

        ),
      ),

      CupertinoButton(
        child: Text('Remove', style: textStyle1.copyWith(
          color: primaryColor,
          fontFamily: 'Muli'
        ),),

        onPressed: () => store.removeProductVideo(),
      ),
    ],
  );
  Widget loadingWidget () => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Center(
        child: AwosheLoadingV2(),
      ),
    ],
  );
  
  Widget videoSelectionPanel(UploadStore store) => Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Column(
                  //   children: <Widget>[
                  //     IconButton(
                  //       icon: Icon(Icons.camera),
                  //       onPressed: (){},
                  //       iconSize: 52,
                  //     ),

                  //     Text('Camera', style: textStyle1,),
                  //   ],
                  // ),

                  Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.video_library),
                        iconSize: 62,
                        onPressed: () {
                          store.chooseVideo();
                        },
                      ),
                      Text(
                        'Select a video',
                        style: textStyle1,
                      ),
                    ],
                  ),
                ],
              ),
            ],
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
          );
}
