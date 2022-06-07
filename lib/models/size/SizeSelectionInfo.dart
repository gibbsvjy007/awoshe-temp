
class SizeSelectionInfo {

  //String location;
  List<String> typeNames;
  List< List<int> > sizeIndexesSelected;

  //List< List<String> > typeIndexesTitles;
  String sizesText = "";
  bool singleSize;

  SizeSelectionInfo( {this.singleSize = false,} ) : sizeIndexesSelected = [], typeNames = [];

  void addSelectionFromJson(Map<String, dynamic> json){
    // is the sizeInfo Node
    typeNames = json.keys.toList();
     sizeIndexesSelected = [];

     typeNames.forEach( (typeName){
       sizeIndexesSelected.add( List<int>.from(json[typeName]) );
     } );
  }

  Map<String, dynamic> transformSelectionToJson(){
    Map<String, dynamic> map = {};
    if (sizeIndexesSelected.isEmpty)
      return map;

    for(var i =0; i < typeNames.length; i++){
      map.putIfAbsent( typeNames[i], () => sizeIndexesSelected[i] );
    }
    return map;
  }

//  Map<String, dynamic> toJson() {
//    return {
//      'singleSize': this.singleSize,
//      'sizesText' : this.sizesText,
//      'sizesInfo' : this.transformSelectionToJson()
//    };
//  }

//  SizeSelectionInfo.fromJson(Map<String, dynamic> json) {
//    var info = SizeSelectionInfo();
//    info.singleSize = json[singleSize] ?? info.singleSize;
//    info.sizesText = json[sizesText] ?? info.sizesText;
//  }

  @override
  String toString() {
    return "TYPES: $typeNames\nSIZE INDEXES: $sizeIndexesSelected";
  }
}