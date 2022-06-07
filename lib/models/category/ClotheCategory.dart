// correct model

// This class represents a main category of a clothe. Like women, men, girl, boy, men accessories etc...
class ClotheCategory{
  static const TITLE = "title";
  static const STATUS = "status";
  static const LOCATION = "location";
  static const SUBCATEGORIES = "subcategories";
  static const SIZES = "sizes";
  static const PARENT = "parent";

  String title;
  String status;
  String location;
  String parent;
  // location, ClotheSize
  Map<String, ClotheSize> locationSizeTypesMap = {};

  Map<String, ClotheCategory> subcategoriesMap = {};
  List<ClotheCategory> get subcategories => subcategoriesMap.values.toList();

  List<String> get getSizeLocationNames =>
      locationSizeTypesMap.keys.toList();

  ClotheSize getClotheSizeByLocation(String locationName) =>
      locationSizeTypesMap[locationName];

  List<ClotheSize> getSizesAvailable() => locationSizeTypesMap.values.toList();

  ClotheCategory getSubcategoryByName(String subcategory) => subcategoriesMap[subcategory];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ClotheCategory &&
              runtimeType == other.runtimeType &&
              title == other.title;

  @override
  int get hashCode => title.hashCode;

  ClotheCategory.fromJson(Map<String,dynamic> json):
        title = json[TITLE] ?? '',
        status = json[STATUS] ?? '',
        parent = json[PARENT] ?? '',
        location = json[LOCATION] ?? '' {


    // getting children subcategories
    if (json[SUBCATEGORIES] != null ){
      Map<String,dynamic>.from( json[SUBCATEGORIES] ?? {} )
          .keys.forEach( (key){
            subcategoriesMap.putIfAbsent(key, () =>
                ClotheCategory.fromJson(
                    Map<String, dynamic>.from(
                        json[SUBCATEGORIES][key]))
            );
      } );
    }

    // getting sizes available to this category

//    print(json[SIZES]);
    if (json[SIZES] != null){
      var sizesMap = Map<String,dynamic>.from( json[SIZES] );
      sizesMap.keys.forEach(  (locationName){
//        print("For category $title getting $locationName " );
        locationSizeTypesMap.putIfAbsent( locationName, () =>
            ClotheSize.fromJson(
                Map<String,dynamic>.from( sizesMap[locationName] ) )
        );
      });
    }
  }

  @override
  String toString() {
    return "$TITLE: $title\n $SUBCATEGORIES: $subcategories";
  }
}

/// This class is CLotheLocation
class ClotheSize {
  static const TYPES = "types";
  static const CONVERSION = "conversion";
  static const FIT = "fit";
  static const GUIDE = "guide";
  static final EMPTY= ClotheSize._();

  final List<String> types;
  final List<String> guide;
  final Map<String, SizeMeasure> sizes = {};

  List<String> getSizeTypeNames() => sizes.keys.toList();

  List<SizeMeasure> get getSizes => sizes.values.toList();

  SizeMeasure getSizeByTypeName(String name) =>
      sizes[name];

  ClotheSize._() :
        types = [],
        guide = [];

  ClotheSize.fromJson(Map<String, dynamic> json) :
        guide = List<String>.from(json[GUIDE] ?? []),
        types = List<String>.from(json[TYPES] ?? [] )
  {
    types.forEach( (type) {
      sizes.putIfAbsent(
          type, () =>
          SizeMeasure.fromJson( Map<String,dynamic>.from(json[type]), type )
      );
    });
  }
//  List<String> conversion;
//  Object conversion;
// List<Object> fit
}

class SizeMeasure {
  static const SUBTYPE_TEXT = "subtype_text";
  static const NONMETRIC = "nonmetric_values";
  static const METRIC = "metric_values";
  static const NONMETRIC_HEADERS = "nonmetric_headers";
  static const METRIC_HEADERS = "metric_headers";

  /// Data in JSON format
  final String name;
  List<String> noMetricHeaders = [];
  List<List<String>> nonmetricValues = [];

  List<String> metricHeaders = [];
  List<List<String>> metricValues = [];

  String subtypeText;

  SizeMeasure.fromJson(Map<String, dynamic> json, String name) :
        name = name ?? '',
        subtypeText = json[SUBTYPE_TEXT] ?? '' {

    noMetricHeaders.addAll( List<String>.from( json[NONMETRIC_HEADERS] ) ?? [] );
    var nonMetrics = List.from( json[NONMETRIC] ?? []);

    for (int i = 0; i < nonMetrics.length; i++ ) {
      List<dynamic> list = nonMetrics[i];
      this.nonmetricValues.add( List<String>.from( list.map( (e) => e.toString() ).toList() ) );
    }

    metricHeaders.addAll( List<String>.from( json[METRIC_HEADERS] ) ?? []  );
    var metrics = List.from( json[METRIC] ?? [] );

    for(int i = 0; i < metrics.length; i++) {
      List<dynamic> list = metrics[i];
      this.metricValues.add( List<String>.from( list.map( (e) => e.toString() ).toList() ) );
    }
  }

}