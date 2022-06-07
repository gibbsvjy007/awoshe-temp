import 'package:Awoshe/logic/api/category_api.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/models/category/ClotheCategory.dart';
import 'package:Awoshe/models/feed/feed.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  int fetchProductsPerPage = 0;
  int PRODUCTS_FETCH_LIMIT = 15;

  @observable
  bool loading = false;

  @observable
  ClotheCategory clotheCategory;

  @observable
  String mainCategory = '';

  @observable
  ObservableList products = ObservableList<Feed>();

  @observable
  bool fetchingProducts = false;

  @observable
  bool allProductsFetched = false;

  @action
  void setClothCategory(ClotheCategory category) {
    clotheCategory = category;
  }

  @action
  void setMainCategory(String category) {
    mainCategory = category;
  }

  @action
  void setLoading(bool l) {
    loading = l;
  }

  @action
  void setFectching(bool l) {
    fetchingProducts = l;
  }

  @action
  void setProducts(List<Feed> f, {bool reset = false}) {
    if (reset) {
      products.clear();
      products.addAll(f);
    } else {
      products.addAll(f);
    }
  }

  @action
  Future<void> getMainCategory(String mainCategory) async {
    setLoading(true);
    ClotheCategory clotheCategory =
        await CategoryApi.getMainCategoryByName(mainCategory.toLowerCase());
    setClothCategory(clotheCategory);

    setMainCategory(clotheCategory.title);
    print('returning clothe category');
    setLoading(false);
  }

  @action
  Future<void> fetchProductsByCategory(
      {String mainCategory,
      String subCategory,
      String userId,
      bool fetchLatest = false}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!fetchLatest) setFectching(true);
      try {
        RestServiceResponse response =
            await CategoryApi.fetchProductsByCategory(
                mainCategory: mainCategory,
                subCategory: subCategory,
                userId: userId,
                page: fetchProductsPerPage,
                limit: PRODUCTS_FETCH_LIMIT);
        if (response.success) {
          //print(response.toString());
          print('THe data is empty ${response.content.isEmpty}');
          final List<Feed> productsData = response.content.map<Feed>((f) {
            print(f.toString());
            return Feed.fromJson(f);
          }).toList();
          fetchProductsPerPage++;
          setProducts(productsData, reset: fetchLatest);
          if (productsData.length < PRODUCTS_FETCH_LIMIT) {
            allProductsFetched = true;
          }
          setFectching(false);
        }
      } catch (ex) {
        setProducts([], reset: fetchLatest);
        setFectching(false);
      }
    });
  }
}
