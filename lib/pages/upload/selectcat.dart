import 'package:Awoshe/components/leftclosefab.dart';
import 'package:Awoshe/logic/bloc_helpers/bloc_provider.dart';
import 'package:Awoshe/models/category/ClotheCategory.dart';
import 'package:Awoshe/services/clothe_category.service.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

typedef OnSelection = void Function(String mainCategory, String subcategory);

class SelectCat extends StatefulWidget {
  final String mainCategorySelected;
  final String subCategorySelected;

  /// [mainCategory]: main category selected.
  /// [subcategory]: The sub category selected.
  final OnSelection callback;
  final bool displaySubCategoriesMenu;
  SelectCat( this.mainCategorySelected, this.subCategorySelected, {this.callback, this.displaySubCategoriesMenu = true} );

  @override
  _SelectCatState createState() => _SelectCatState();
}

class _SelectCatState extends State<SelectCat> {
  double height = 0.0;
  double width = 0.0;
  int outDurationInMilliseconds = 100;
  Duration inDurationInMilliseconds = Duration(milliseconds: 500);
  double currentCategoryOpacity = 0.0;
  SelectCatBloc bloc;
  String currentCategoryTitle;
  String currentSubCategoryTitle;

  @override
  void initState() {
    currentCategoryTitle = widget.mainCategorySelected?.toLowerCase() ?? "";
    currentSubCategoryTitle = widget.subCategorySelected?.toLowerCase() ?? "";
    print('Selected category $currentCategoryTitle');
    print('Selected subcategory $currentSubCategoryTitle');
    bloc = SelectCatBloc(
        mainCategory: widget.mainCategorySelected?.toLowerCase(),
        subcategory: widget.subCategorySelected?.toLowerCase()
    );
    super.initState();
  }

  @override
  void dispose() { super.dispose(); }

  Widget buildCategoryTile(ClotheCategory category) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Stack(
          children: <Widget>[
            InkWell(
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text(
                            category.title.toUpperCase(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 16.0),
                          ),
                      ],
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    child: StreamBuilder<ClotheCategory>(
                      stream: bloc.categorySelectedStream,
                      builder: (context, snapshot) {
                        return Column(
                          children: <Widget>[
                            AnimatedOpacity(
                              opacity: (!snapshot.hasData) ? .0 :
                                (currentCategoryTitle.toLowerCase() ==
                                    category.title.toLowerCase()) ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 700),
                              child: Container(
                                  color: Colors.white,
                                  height: 1.0,
                                  width: MediaQuery.of(context).size.width * 0.4),
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                ],
              ),
              onTap: () {
                currentCategoryTitle = category.title;
                currentSubCategoryTitle = "";
                bloc.selectMainCategory( category.title );
              },
            ),
          ],
        ),
      );


  Widget renderMainCategories() =>
      StreamBuilder<List<ClotheCategory>>(
        stream: bloc.categoriesStream,
        builder: (context, snapshot){
          if (snapshot.hasData){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: snapshot.data
                  .map<Widget>((category) => buildCategoryTile(category))
                  .toList(),
            );
          }

          return  Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              backgroundColor: primaryColor,
            ),
          );
        },
      );

  onCheckBoxTapped(ClotheCategory data) {
    /// currently we are not supporting multiple category selection.
    /// user will be able to choose only one
    currentSubCategoryTitle = data.title;
    currentCategoryTitle = data.parent;
    setState(() {}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AwosheLeftCloseFab(
          onPressed: () {
            if (widget.callback != null){
              widget.callback(currentCategoryTitle, currentSubCategoryTitle);
            }
      }),
      backgroundColor: awLightColor,
      body: SafeArea(
        child: InkWell(
          onTap: () {
            bloc.closeSubCategoryMenu();
          },
          child: Stack(
            alignment: FractionalOffset.centerLeft,
            children: [
              // layout for main categories
              Container(
                padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 28.0),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    renderMainCategories(),
                  ],
                ),
              ),

              // rigth side menu with subcategories
              (widget.displaySubCategoriesMenu) ?

              StreamBuilder<ClotheCategory>(
                stream: bloc.categorySelectedStream,
                builder: (context, snapshot){
                  print('we have ${snapshot.data?.title}');
                  if (!snapshot.hasData)
                    return Container();

                  return Container(
                    alignment: Alignment.centerRight,
                    child: AnimatedContainer(
                      padding: EdgeInsets.only(top: 10.0),
                      duration: inDurationInMilliseconds,
                      curve: Curves.easeInOutCirc,
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0)),
                        color: Colors.white,
                      ),
                      //decoration: BoxDecoration(color: awLightColor,borderRadius: BorderRadius.circular(5),
                      child: ListView(
                        children:  snapshot.data.subcategories.map<Widget>((data) {
                          return GestureDetector(
                            onTap: () { onCheckBoxTapped(data); },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Checkbox(
                                    onChanged: null,
                                    value: ( (currentSubCategoryTitle == data?.title && currentCategoryTitle == data?.parent) ),
                                  ),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      data.title,
                                      style: TextStyle(
                                          color: secondaryColor,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );

                },
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectCatBloc extends BlocBase {

  final BehaviorSubject<List<ClotheCategory>> _categorySubject = BehaviorSubject();
  Observable<List<ClotheCategory>> get categoriesStream => _categorySubject.stream;

  final BehaviorSubject<ClotheCategory> _selectionSubject = BehaviorSubject();
  Observable<ClotheCategory> get categorySelectedStream => _selectionSubject.stream;

  Map<String, ClotheCategory> _categoriesCache = {};
  final ClotheCategoryService _service = ClotheCategoryService();
  String selectedMainCategory, selectedSubCategory;

  SelectCatBloc({String mainCategory, String subcategory}) :
        selectedMainCategory = mainCategory,
        selectedSubCategory = subcategory {
    _init();
  }

  void _init() async {
    var categories = await _service.getAllCategories();
    categories.forEach( (cat) => _categoriesCache.putIfAbsent( cat.title.toLowerCase(), () => cat ) );

    _categorySubject.sink.add(  categories );
    if (selectedMainCategory!= null )
      selectMainCategory(selectedMainCategory);


  }

  void selectMainCategory(String title) {
    var cat = _categoriesCache[title.toLowerCase()];
    _selectionSubject.sink.add(  cat  );
  }

  void closeSubCategoryMenu() => _selectionSubject.sink.add( null );
  ClotheCategory getCategoryByTitle(String title) => _categoriesCache[title];


  @override
  void dispose() {
    _categorySubject?.close();
    _selectionSubject?.close();
    _categoriesCache?.clear();
  }

}