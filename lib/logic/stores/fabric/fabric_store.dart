import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/services/upload_services_v2.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:mobx/mobx.dart';

part 'fabric_store.g.dart';

class FabricStore = _FabricStore with _$FabricStore;

abstract class _FabricStore with Store {
  static const FABRIC_LIMIT = 32;
  final UploadServiceV2 _service = UploadServiceV2();

  @observable
  bool isLoading = false;

  int fetchFabricPage = 0;

  @observable
  bool allFabricsFetched = false;

  @observable
  ObservableList<Product> fabrics = ObservableList<Product>();

  @action
  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  @action
  void setFabrics(List<Product> fabrics, {bool reset = false}) {
    if (reset) {
      this.fabrics.clear();
      this.fabrics.addAll(fabrics);
    } else
      this.fabrics.addAll(fabrics);
  }

  Future<void> fetchFabrics(String userId, {bool fetchLatest = false}) async {
    if (!fetchLatest) setLoading(true);

    try {
      var dataList = await _service.getProductsByType(
          userId: userId,
          type: ProductType.FABRIC,
          page: fetchFabricPage,
          limit: FABRIC_LIMIT);

      setFabrics(dataList, reset: fetchLatest);
      fetchFabricPage++;

      if (fabrics.length < FABRIC_LIMIT) {
        allFabricsFetched = true;
      }
    } catch (e) {
      print("error");
      print(e);
    }

    setLoading(false);
  }
}
