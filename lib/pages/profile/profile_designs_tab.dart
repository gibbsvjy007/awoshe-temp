import 'package:Awoshe/components/desing_tile.dart';
import 'package:Awoshe/logic/api/user_api.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/no_data_available.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO we need create a pagination to no fetch all designer products at once

class DesignsTab extends StatefulWidget {
  final String designerId;

  // Todo change to ProfileType data type
  final String profileType;

  DesignsTab({Key key, this.designerId, this.profileType}) : super(key: key);

  @override
  _DesignsTabState createState() => _DesignsTabState();
}

class _DesignsTabState extends State<DesignsTab> {
  UserStore userStore;
  UploadStore uploadStore;
  Future <List<Product>> _dataFuture;

  @override
  void initState() {
    _dataFuture = UserApi.getDesigns(userId: widget.designerId, limit: 30);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    userStore ??= Provider.of<UserStore>(context);
    uploadStore ??= Provider.of<UploadStore>(context);
    super.didChangeDependencies();
  }

  Widget _getGridViewItems(final Product product) {
      return Container(
          width: 120,
          height: 120,
          child: DesignTile(
            imageUrl: product.imageUrl,
            onTap: (){
              (widget.profileType == 'PUBLIC')
                  ?
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute<bool>(
                  settings: RouteSettings(name: 'ProductPage'),
                  fullscreenDialog: true,
                  builder: (BuildContext context) => ProductPage(
                    productId: product.id,
                  ),
                ),
              ) : uploadStore.startUpdateProcess(context, product: product);
            },
          )
      );
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Product>>(
        future: _dataFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {

          if (snapshot.hasError)
            return SliverToBoxAdapter(
              child: NoDataAvailable(),
            );

          if (!snapshot.hasData)
            return SliverToBoxAdapter(child: AwosheLoading());

          if (snapshot.data != null && snapshot.data.length > 0) {

            return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3.0,
                  crossAxisSpacing: 3.0,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return  _getGridViewItems(snapshot.data[index]);
                  },
                  childCount: snapshot.data.length,
                ));
          }

          else
            return SliverToBoxAdapter(
              child: NoDataAvailable(),
            );
        },
    );
//
//    return Scaffold(
//      backgroundColor: Colors.white,
//      body: Container(
//        child: StreamBuilder(
//          stream: _service.getProfileDesigns(),
//          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//
//            if (snapshot.connectionState == ConnectionState.waiting)
//              return AwosheLoading();
//
//            if (snapshot.data != null && snapshot.data.documents.length > 0) {
//              List<DocumentSnapshot> documents = snapshot.data.documents;
//
//              return GridView.count(
//                crossAxisCount: 3,
//                mainAxisSpacing: 3.0,
//                crossAxisSpacing: 3.0,
//                padding: const EdgeInsets.all(2.0),
//                childAspectRatio: (itemWidth / itemHeight),
//                children: _getGridViewItems(documents),
//              );
//            }
//
//            else
//              return NoDataAvailable();
//          },
//        ),
//      ),
//    );
  }
}
