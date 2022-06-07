import 'dart:io';
import 'package:Awoshe/common/sliver_appbar_delegate.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_bloc_state_v2.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_bloc_v2.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_details_form_bloc.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_event_v2.dart';
import 'package:Awoshe/pages/upload/design/details/details_tab.dart';
import 'package:Awoshe/pages/upload/design/customize/customize_tab.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

/// This class is used tp update a product.
class UploadDesignDetailsPage extends StatefulWidget {
  UploadDesignDetailsPage(
      {Key key,
        this.product,
      this.productId,
      this.uploadType,
      this.uploadMode,
      this.designImages})
      : super(key: key);

  final String productId;
  // final String title;
  final UploadMode uploadMode;
  final List<File> designImages;
  final ProductType uploadType;
  final Product product;

  @override
  _UploadDesignDetailsPageState createState() => new _UploadDesignDetailsPageState();
}

const kExpandedHeight = 300.0;

class _UploadDesignDetailsPageState extends State<UploadDesignDetailsPage>
    with SingleTickerProviderStateMixin {
    //ScrollController _scrollController;

  UploadDesignBlocV2 _blocV2;

  UploadDesignDetailsFormBloc _uploadDesignDetailsFormBloc = UploadDesignDetailsFormBloc();
  TabController _tabController;
  int _tabIndex = 0;

  List<Tab> uploadTabs = <Tab>[
    Tab(text: "DETAILS"),
    Tab(text: "CUSTOMIZE"),
    Tab(text: "BOTH"),
  ];


  @override
  void didChangeDependencies() {
    _blocV2 ??= Provider.of<UploadDesignBlocV2>(context);
    super.didChangeDependencies();
  }
  @override
  void initState() {
    super.initState();

    _tabController = new TabController(
        vsync: this, length: uploadTabs.length, initialIndex: _tabIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    // _scrollController.dispose();
  }

  Widget buildSliverAppBar() =>
      SliverAppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: new Text(
          "Edit Designs",
          style: new TextStyle(color: awBlack),
        ),
        leading: new IconButton(
            //Color awBlack = const Color.fromRGBO(37,48,56, 1.0);
            icon: const Icon(
              CupertinoIcons.back,
//              const IconData(0xe905, fontFamily: 'icomoon'),
              color: secondaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      );

  Widget showFabricView() => NestedScrollView(
    //controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child:  buildSliverAppBar(),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Provider<UploadDesignBlocV2>.value(
            value: _blocV2,
            child: DetailsTab(
              productData: _blocV2.product,
              uploadType: widget.uploadType,
              designImages: widget.designImages,
            ),
          ),
        ),
      );

  Widget showDesignView() => DefaultTabController(
        length: 3,
        child: NestedScrollView(
          // controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: buildSliverAppBar(),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    indicatorColor: primaryColor,
                    isScrollable: false,
                    labelColor: primaryColor,
                    unselectedLabelColor: Colors.grey,
                    tabs: uploadTabs,
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              // building details tab

              SingleChildScrollView(
                child: Provider<UploadDesignBlocV2>.value(
                  value: _blocV2,
                  child: DetailsTab(
                      productData: _blocV2.product,
                      uploadType: widget.uploadType,
                      designImages: widget.designImages,
                  ),
                ),
              ),
              /// Reason we are using the CustomizeTab is we have to distinguish STANDARD and CUSTOM Order type
              // building customize tab
              SingleChildScrollView(
                child: Provider<UploadDesignBlocV2>.value(value: _blocV2,
                  child: CustomizeTab(
                      productData: _blocV2.product,
                      productType: widget.uploadType,
                      designImages: widget.designImages,
                      uploadDesignFormBloc: _uploadDesignDetailsFormBloc
                  ),
                ),
              ),

              // building both tab
              SingleChildScrollView(
                child: Provider<UploadDesignBlocV2>.value(value: _blocV2,
                  child: CustomizeTab(
                      productData: _blocV2.product,
                      productType: widget.uploadType,
                      designImages: widget.designImages,
                      uploadDesignFormBloc: _uploadDesignDetailsFormBloc
                  ),
                ),
              ),
            ],
          ),
        ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: BlocListener<UploadDesignBlocV2, UploadDesignBlocStateV2>(
          bloc: _blocV2,
          condition: (_,current) => (current.eventType == UploadDesignBlocEventType.UPDATE),
          listener: (previous, current){
            if (current.eventType == UploadDesignBlocEventType.UPDATE){

              if (current is UploadDesignBlocStateSuccess)
                ShowFlushToast(context, ToastType.SUCCESS, "Update Successfully");

              else if (current is UploadDesignBlocStateFail)
                ShowFlushToast(
                    context, ToastType.ERROR, "Update failed");
            }
          },
          child: SafeArea(
            child: widget.uploadType == UploadType.FABRIC
                ?  showFabricView()
                : showDesignView(),
          ),
        ));
  }
}
