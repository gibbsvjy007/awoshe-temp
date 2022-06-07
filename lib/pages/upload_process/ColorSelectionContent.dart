import 'package:Awoshe/components/float_next_button/FloatNextButton.dart';
import 'package:Awoshe/components/option_list/OptionListItem.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/pages/colors/customize_color_page.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ColorSelectionPage extends StatefulWidget {
  final List<int> selectedItems;
  final ValueChanged<bool> nextCallback;

  const ColorSelectionPage({Key key, this.nextCallback,
    this.selectedItems,}) : super(key: key);
  
  @override
  _ColorSelectionPageState createState() => _ColorSelectionPageState();
}

class _ColorSelectionPageState extends State<ColorSelectionPage> {
  UploadStore store;

  @override
  void initState() {
    super.initState();
    store = Provider.of<UploadStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {

    final body = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Container(
          margin: EdgeInsets.only(left: 16.0,right: 16.0, top: 12.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Select all colors available.',
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

        Container(
          margin: EdgeInsets.only(left: 16.0,right: 16.0, top: 16.0),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                
                builder: (_) => MultiProvider(
                  providers: [
                    Provider<UploadStore>.value(value: store), 
                    Provider<UserStore>.value(value: Provider.of<UserStore>(context, listen: false))
                  ],
                  child: CustomizeColorPage(),
                ),
              ) );
            },
            child: OutlineButton(
    color: primaryColor,

    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15)),
    child:  Text('Create custom color',
              textAlign: TextAlign.left,
              style: textStyle.copyWith(color: primaryColor), )
            )
          ),
        ),

        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(
              top:MediaQuery.of(context).size.width*0.05,
              //bottom:MediaQuery.of(context).size.width*0.15,
              left:MediaQuery.of(context).size.width*0.1, 
              right: MediaQuery.of(context).size.width*0.15
            ),

            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, int index) {
                if (index == store.allColorsName.length)
                  return Container(height: 30.0,);

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 12.0),
                  child: Observer(
                      builder: (context) {
                        return OptionListItem(
                            title: store.allColorsName[index],titleStyle: TextStyle(fontSize: 17.0),
                            isSelected: store.selectedColors.contains(
                                store.allColorsName[index]) ? true : false,
                            onTap: () {
                              store.selectedColors.contains(store.allColorsName[index])
                                  ? store.removeColor(store.allColorsName[index])
                                  : store.addColor(store.allColorsName[index]);
                            }
                        );
                      }
                  ),
                );
              },
              itemCount: store.allColorsName.length + 1,
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0
          ),
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
            if (widget.nextCallback != null)
              widget.nextCallback(store.selectedColors.isNotEmpty);
          }
      ),
    );
  }

}
