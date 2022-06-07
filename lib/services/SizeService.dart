import 'dart:async';
import 'package:Awoshe/models/category/ClotheCategory.dart';
import 'package:Awoshe/services/clothe_category.service.dart';

class SizeService {

  final ClotheCategoryService _categoryService = ClotheCategoryService();

  SizeService();

  Future<void> init() async {
    await _categoryService.loadJsonFile();
  }

  Future<ClotheSize> getSizeFrom(String mainCategory,
      String subcategory) async {

    ClotheCategory category = await  _categoryService
        .getMainCategoryByName(mainCategory.toLowerCase());

    var subCat = category.subcategoriesMap[subcategory.toLowerCase()];
    //category.getSubcategoryByName(subcategory.toLowerCase());
    //print("SIZES FOR: ${subCat?.title} ${subCat?.getSizeLocationNames}");
    //print('SUB CAT $subCat');

    if (subCat == null)
      return ClotheSize.EMPTY;

    if (subCat.location.isEmpty )
      return ClotheSize.EMPTY;

    return category.getClotheSizeByLocation(subCat.location.toLowerCase());
  }

  Future<SizeMeasure> getSizesMeasureFrom(String mainCategoryName,
      String subcategoryName, String sizeType) async {

    if (mainCategoryName == null)
      return null;

    if (subcategoryName == null)
      return null;

    ClotheCategory category = await _categoryService
        .getMainCategoryByName(mainCategoryName.toLowerCase());

    String location = category.subcategoriesMap[subcategoryName.toLowerCase()]?.location;

    if (location == null)
      return null;

    return category?.locationSizeTypesMap[location.toLowerCase()]?.sizes[sizeType.toLowerCase()];
    //category.sizes[mainCategory].
  }
}
