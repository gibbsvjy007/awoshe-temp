import 'package:Awoshe/logic/api/product_api.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/services/OfferService.dart';
import 'package:Awoshe/logic/stores/currency/currency_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/category/ClotheCategory.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/services/SizeService.dart';
import 'package:mobx/mobx.dart';

part 'product_store.g.dart';

class ProductStore = _ProductStore with _$ProductStore;

enum ProductStoreStatus {LOADING, READY, ERROR}

abstract class _ProductStore with Store {
  final SizeService _sizeService = SizeService();

  _ProductStore(this.userStore, this.currencyStore);

  final UserStore userStore;
  final CurrencyStore currencyStore;
  final OfferService offerService = OfferService();

  @observable
  Product product = Product.empty();

  // @observable
  // bool loading = false;

  /// Map with sizes available for the current product
  /// The keys are the location and the values SizeMeasure object.
  /// If is empty is because there is no size available for this product.
  final Map<String, SizeMeasure> sizeMeasurements = {};

  /// holds the size location as key and the value is a list with
  /// the sizes headers available for the product in this location
  /// like "tall": ['L', 'M', 'XS'];
  final Map<String, List<String>> sizeMeasurementHeaders = {};

  double exchangeRate = 1.0;

  void setProductFromData(Product data) async {
    try {
      setStoreStatus(ProductStoreStatus.LOADING);
      await _sizeService.init();
      await processProductSizes(data);
      
      print("product data is ready");
        setProduct(data);

        if (product.price == null)
          product.price = '0';

        if (product.currency != userStore.details.currency) {
          exchangeRate = currencyStore.getExchangeRate(
              from: product.currency, // is product currency is null use USD
              to: userStore.details.currency
          );
          if (exchangeRate == null)
            exchangeRate = 1.0;
        }
        setStoreStatus(ProductStoreStatus.READY);
    } 

    catch (ex){
      setStoreStatus(ProductStoreStatus.ERROR);
      print(ex.toString());
    }
    
  }

  @action
  void setProduct(Product p) {
    product = p;
  }

  @observable
  ProductStoreStatus status;

  @action
  void setStoreStatus(ProductStoreStatus status) => this.status = status;

  Future<void> fetchProductDetail({String userId, String productId}) async {

    try {
      setStoreStatus(ProductStoreStatus.LOADING);
      RestServiceResponse response =   
        await ProductApi.read(productId: productId, userId: userId);
      if (response.success) {
        print(response.content);
        Product productDetail = Product.fromJson(response.content);
        
        await _sizeService.init(); // load local size json file
        await processProductSizes(productDetail);

        print("product data is ready");
        setProduct(productDetail);

        if (product.price == null)
          product.price = '0';

        if (product.currency != userStore.details.currency) {
          exchangeRate = currencyStore.getExchangeRate(
              from: product.currency, // is product currency is null use USD
              to: userStore.details.currency
          );
          if (exchangeRate == null)
            exchangeRate = 1.0;
        }
        setStoreStatus(ProductStoreStatus.READY);
      }
    } 
    catch (e) {
      setStoreStatus(ProductStoreStatus.ERROR);
      print(e.toString());
    }
  }


  Future<void> processProductSizes(Product product) async {
    final SizeService _sizeService = SizeService();

//    sizeMeasurements.clear();
//    sizeMeasurementHeaders.clear();
    var productSizes = product.sizesInfo;

    if (productSizes != null) {
      print('There is sizes for ${product.id}');
      for (int i = 0; i < productSizes.typeNames.length; i++) {
        String type = productSizes.typeNames[i];

        var measurement = await _sizeService.getSizesMeasureFrom(
            product?.mainCategory, product?.subCategory, type);

        if (measurement != null) {
          sizeMeasurements.putIfAbsent(type, () => measurement);
          var indexes = productSizes.sizeIndexesSelected[i];

          //print('For $type -> ');
          //[index] means the available size like "XL", "M","L", etc
          // [0] means the index of the size representation with letters.
          List<String> sizeHeaders = [];
          indexes.forEach((index) {
            sizeHeaders.add(measurement.nonmetricValues[index][0]);
          });
          sizeMeasurementHeaders.putIfAbsent(type, () => sizeHeaders);
          print('For $type -> $sizeHeaders');
        }
      }
    }
  }
}
