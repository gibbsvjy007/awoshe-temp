import 'package:Awoshe/models/category/ClotheCategory.dart';
import 'package:Awoshe/pages/menu/menu.dart';
import 'package:Awoshe/services/clothe_category.service.dart';
import 'package:mobx/mobx.dart';

part 'CategoryMenuStore.g.dart';

enum ClotheCategoryStoreState {BUSY, READY, ERROR }

class CategoryMenuStore = _CategoryMenuStore with _$CategoryMenuStore;

abstract class _CategoryMenuStore with Store {

  final ClotheCategoryService _service = ClotheCategoryService();

  @observable
  ObservableMap<String, List<String > > categoryMap = ObservableMap();

  @observable
  ObservableList<String> expandedCategories = ObservableList();

  @observable
  ClotheCategoryStoreState state = ClotheCategoryStoreState.BUSY;

  @observable
  ObservableList<Entry> entryList = ObservableList();

  @action void setEntryList(List<Entry> data) => entryList.addAll(data);

  @action void expandCategory(String mainCategory) {
    if (!expandedCategories.contains(mainCategory)){
      expandedCategories.add(mainCategory);
    }
  }

  @action void collapseCategory(String mainCategory) =>
    expandedCategories.remove(mainCategory);


  bool isExpanded(String mainCategory)
  => expandedCategories.contains(mainCategory);


  @action void setState(ClotheCategoryStoreState state) =>
      this.state = state;


  void init() async {
    setState(ClotheCategoryStoreState.BUSY);

    List<ClotheCategory> categories = await _service.getAllCategories();

    // transforming in Entry objects
    var entryList = categories.map<Entry>( (mainCategory){

      var main = mainCategory.title.toLowerCase();
      categoryMap.putIfAbsent( main, () => <String>[]);

      return Entry(
          mainCategory.title.toUpperCase(),
          isMainEntry: true,
          parent: mainCategory.title,
          children: mainCategory.subcategories.map(
                  (childCategory){
                    
                    categoryMap[main].add(childCategory.title.toLowerCase());
                    return Entry(
                      childCategory.title,
                      children: [],
                      isMainEntry: false,
                      parent: mainCategory.title,
                    );
              }).toList()
      );
    }).toList();

    
    setEntryList(entryList);
    setState(ClotheCategoryStoreState.READY);
  }

}