import 'package:Awoshe/components/size/SizeListWidget.dart';
import 'package:Awoshe/components/leftclosefab.dart';
import 'package:Awoshe/logic/bloc/upload/SelectSizeBloc.dart';
import 'package:Awoshe/models/category/ClotheCategory.dart';
import 'package:Awoshe/models/size/SizeSelectionInfo.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef OnSizeSelected = void Function(SizeSelectionInfo info);

class SelectSizePage extends StatefulWidget {
  final OnSizeSelected callback;

  final String mainCategoryTitle;
  final String subcategoryTitle;

  SelectSizePage(this.mainCategoryTitle, this.subcategoryTitle, {this.callback});

  @override
  _SelectSizePageState createState() => _SelectSizePageState();
}

class _SelectSizePageState extends State<SelectSizePage> {
  SelectSizeBloc bloc;
  static const double heightBase = 50;

  @override
  void didChangeDependencies() {

    if (bloc == null){
      bloc = Provider.of<SelectSizeBloc>(context);
      bloc.loadSizes(widget.mainCategoryTitle, widget.subcategoryTitle, null);
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: AwosheLeftCloseFab(
          onPressed: () {
            print('Sizes selected info ${bloc.getSelectedSizesInfo()}');
            if (widget.callback != null)
              widget.callback( bloc.getSelectedSizesInfo() );

            print('Time to pop');
            Navigator.pop(context);
          }),

      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          margin: EdgeInsets.only(top: 32.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                StreamBuilder<ClotheSize>(
                  stream: bloc.sizeStream,
                  builder: (context, snapshot){
                    print('data ${snapshot.data}');
                    if (!snapshot.hasData){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: AwosheDotLoading(),
                          ),
                        ],
                      );
                    }
                    return ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(widget.mainCategoryTitle.toUpperCase(),
                          style: TextStyle(
                              color: secondaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0
                          ),
                        ),

                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 4.0),
                            // subcategory expansion tile
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            title: Text(widget.subcategoryTitle),
                              children: <Widget>[

                                (snapshot.data.types.isNotEmpty) ?
                                Column(
                                  children: snapshot.data.types.map<Widget>(  (name) {
                                    var measure = snapshot.data.getSizeByTypeName(name);

                                    return ExpansionTile(
                                      title: Text( measure.name ),
                                      children: <Widget>[
                                        Container(
                                          child: StreamBuilder<Object>(
                                            stream: bloc.indexesChangeStream,
                                            builder: (context, snapshot) {
                                              return SizeListWidget(
                                                measure,
                                                selectedIndexes: bloc.getSelectedIndexesForType(measure.name),
                                                onSizeSelected: bloc.addIndexForSizeSubType,
                                                onSizeUnselected: bloc.removeIndexForSizeSubType,
                                              );
                                            }
                                          ),
                                          height: heightBase * measure.noMetricHeaders.length,
                                        ),
                                      ],
                                    );
                                  } ).toList(),
                                ) :
                                Container(
                                  margin: EdgeInsets.only(bottom: 8.0),
                                  child: Text('Unique Size', style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 16.0,
                                  ),),
                                ),
                              ],
                          ),
                        ),
                      ],
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}