import 'package:Awoshe/logic/api/product_api.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
part 'OcassionStore.g.dart';

class OcassionStore = _OcassionStore with _$OcassionStore;


enum OcassionStoreState {LOADING, DONE, ERROR, NONE }

abstract class _OcassionStore with Store {

  @observable
  OcassionStoreState storeState = OcassionStoreState.NONE;

  @observable
  bool isLoadingMore = false;

  // using dynamic type we can transform Product type into Feed type and inverse.
  List< dynamic > productList = [];
  
  int _currentPage = 0;
  int _limit = 10;
  bool isAllPageLoaded = false;

  @action
  void _setStoreState(OcassionStoreState state) => storeState = state;

  @action
  void _setLoadingMore(bool flag) => isLoadingMore = flag;


  // load teh product data using the product API
  Future<RestServiceResponse> _loadData({@required String ocassion, @required String userId})  {
    return ProductApi.getProductsByOccasion(
        userId: userId, occasion: ocassion,
        page: _currentPage,
        limit: _limit,
      );
  }

  void loadProducts( {@required String ocassion, @required String userId} ) async {
    if (storeState == OcassionStoreState.LOADING)
      return;

    try {
      _setStoreState(OcassionStoreState.LOADING);
      var data = await _loadData(ocassion: ocassion, userId: userId,);

       productList.addAll( List.from(data.content) );
      _setStoreState(OcassionStoreState.DONE);
    } 
    
    catch (ex){
      _setStoreState(OcassionStoreState.ERROR);
      print(ex);
    }
  }

  void loadMore({@required String ocassion, @required String userId}) async {
    
    if (isAllPageLoaded)
      return;

    if(isLoadingMore)
      return;

    try {
      _setLoadingMore(true);
      _currentPage++;
      var response = await _loadData(ocassion: ocassion, userId: userId,);

      var data = List.from(response.content);
      if (data.isEmpty)
        isAllPageLoaded = true;
      else
        productList.addAll(data);

        
      _setLoadingMore(false);
      _setStoreState(OcassionStoreState.DONE);
    } 
    catch(ex){
      _setLoadingMore(false);
    
    }
  }



}