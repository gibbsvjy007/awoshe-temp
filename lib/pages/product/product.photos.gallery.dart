import 'package:Awoshe/components/closefab.dart';
import 'package:Awoshe/logic/bloc/product/ProductPhotosBloc.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:provider/provider.dart';

class ProductPhotos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ProductPhotosBloc bloc = Provider.of<ProductPhotosBloc>(context);
    List<PhotoView> galleryItems = bloc.createImageViews();
    
    return Scaffold(
      floatingActionButton: AwosheCloseFab(
        onPressed: () {Navigator.pop(context);},
      ),
      body: Stack(children: <Widget>[
          PhotoViewGallery.builder(
            onPageChanged: (currentPageIndex){
              bloc.displayPage(currentPageIndex);
            },

            pageController: PageController(
                initialPage: bloc.initialPage,
                keepPage: true,
            ),

            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: galleryItems[index].imageProvider,
                initialScale: PhotoViewComputedScale.contained * 0.8,
                //heroTag: galleryItems[index].heroTag,
              );
            },
            itemCount: galleryItems.length,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              StreamBuilder<int>(
                stream: bloc.currentPageIndex,
                initialData: bloc.initialPage,
                builder: (context, snapshot) {
                  return SafeArea(
                    child: Center(
                      child: new DotsIndicator(
                        dotsCount: bloc.imageUrls.length,
                        position: snapshot.data,
                      ),
                    ),
                  );
                }
              ),
            ],
          )
        ]),
    );
  }
}