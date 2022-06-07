import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/bloc_helpers/bloc_provider.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rxdart/rxdart.dart';

class ProductPhotosBloc extends BlocBase{
  BehaviorSubject<int> _picturePageSubject = BehaviorSubject();
  Observable<int> get currentPageIndex => _picturePageSubject.stream;
  final List<String> imageUrls;
  final int initialPage;
  static const List<String> defaultUrls = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/African_Fashion_in_the_City_4.JPG/1280px-African_Fashion_in_the_City_4.JPG',
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/African_Fashion_in_the_City_5.JPG/1280px-African_Fashion_in_the_City_5.JPG",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/African_Fashion_in_the_City_4.JPG/1280px-African_Fashion_in_the_City_4.JPG"
  ];

  ProductPhotosBloc({this.imageUrls = defaultUrls, this.initialPage = 0});

  void displayPage(int index) => _picturePageSubject.sink.add(index);

  List<PhotoView> createImageViews() {

    List<PhotoView> galleryItems = [];
    imageUrls.forEach( (url) => galleryItems.add(
      PhotoView(
        imageProvider: AdvancedNetworkImage(
            url,
            useDiskCache: true,
            cacheRule: IMAGE_CACHE_RULE,
        ),
        //heroTag: url,
      ),
    ));
    return galleryItems;
  }

  @override
  void dispose() {
    _picturePageSubject?.close();
  }
}
