import 'package:Awoshe/logic/bloc_helpers/bloc_provider.dart';
import 'package:Awoshe/models/category/ClotheCategory.dart';
import 'package:Awoshe/models/size/SizeSelectionInfo.dart';
import 'package:Awoshe/services/SizeService.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SelectSizeBloc extends BlocBase {

  final BehaviorSubject<ClotheSize> _clotheSizeSubject = BehaviorSubject();
  Observable<ClotheSize> get sizeStream => _clotheSizeSubject.stream;
  final BehaviorSubject<bool> _indexesChangingSubject = BehaviorSubject();
  Observable<bool> get indexesChangeStream => _indexesChangingSubject.stream;

  Map<String, List<int> > selectedIndexesMap = {};
  SizeService _sizeService = SizeService();
  ClotheSize _currentSize;
  String _mainCategory;
  String _subcategory;

  void init(BuildContext context, String mainCategory, String subcategory,
      {SizeSelectionInfo availableSizes} ) async {
    await _sizeService.init();

    _currentSize = await _sizeService.getSizeFrom(mainCategory, subcategory);

    if (availableSizes != null) {
      _preSelectItems(availableSizes);
    }

    _mainCategory = mainCategory;
    _subcategory = subcategory;

    //print('getting size from $mainCategory and $subcategory');
  }

  void addIndexForSizeSubType(String typeName, int indexSelected){
    if (!selectedIndexesMap.containsKey( typeName))
      selectedIndexesMap.putIfAbsent( typeName, ()=> [] );

    print('Adding to $typeName index $indexSelected');
    selectedIndexesMap[typeName].add(  indexSelected );
    _indexesChangingSubject.sink.add( true );
  }

  void removeIndexForSizeSubType(String type, int index){
    if ( selectedIndexesMap.containsKey(type) ){
      selectedIndexesMap[type].remove( index );

      if (selectedIndexesMap[type].isEmpty)
        selectedIndexesMap.remove( type );

      _indexesChangingSubject.sink.add( true );
    }
  }

  List<int> getSelectedIndexesForType(String type){
    if (selectedIndexesMap.containsKey(type) )
      return selectedIndexesMap[type];

    else
      return [];
  }

  void _preSelectItems(SizeSelectionInfo selectionInfo  ){
    print('Pre select Items $selectionInfo');

    if (selectionInfo == null || selectionInfo.typeNames.isEmpty)
      return;

    for(var i=0; i < selectionInfo.typeNames.length; i++){
      selectedIndexesMap.putIfAbsent(
          selectionInfo.typeNames[i] ,()=> selectionInfo.sizeIndexesSelected[i]);
    }
    _indexesChangingSubject.sink.add(true);
  }

  SizeSelectionInfo getSelectedSizesInfo() {
//    if (_currentSize.types.isEmpty){
//      return SizeSelectionInfo()..sizesText = "Unique Size";
//    }

    if (selectedIndexesMap.isEmpty)
      return null;


    var sizeTypeList = selectedIndexesMap.keys.toList();
    print('Selected Size types $sizeTypeList');
    var info = SizeSelectionInfo();
    String sizesText = "";
    
    for(var sizeType in sizeTypeList) {
      info.typeNames.add(sizeType);
      var selectedIndexes = selectedIndexesMap[sizeType];
      info.sizeIndexesSelected.add(selectedIndexes);

      // indexes text description
      sizesText+= sizeType + "[";
      print('For size Type ${_currentSize.toString()}');

      for(var index in selectedIndexes){
        var size = _currentSize.getSizeByTypeName(sizeType.toLowerCase());
        if (size != null) {
          sizesText +=
              size.nonmetricValues[index][0] + ", "; // getting US size standard
        }
      }

      sizesText = sizesText.substring(0, sizesText.length-2);
      sizesText+= "], ";
    }
    info.sizesText = sizesText;
    print('Size text is $sizesText');

    return info;
  }

  void loadSizes(String mainCategory, String subcategory, String location) async {
    _currentSize = await _sizeService.getSizeFrom( mainCategory, subcategory );
    print('Data fetched $_currentSize');
    _clotheSizeSubject.sink.add( _currentSize );
  }

  @override
  void dispose() {
    _clotheSizeSubject?.close();
    _indexesChangingSubject?.close();
  }

}