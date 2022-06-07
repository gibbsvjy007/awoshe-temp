import 'dart:convert';
import 'dart:io';

import 'package:Awoshe/common/app.data.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/database/database_provider.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/api/product_api.dart';
import 'package:Awoshe/logic/services/collection_services_v2.dart';
import 'package:Awoshe/logic/services/upload_services_v2.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/collection/collection.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/models/size/SizeSelectionInfo.dart';
import 'package:Awoshe/models/upload_progress/UploadProgress.dart';
import 'package:Awoshe/pages/upload/StepperUploadPage.dart';
import 'package:Awoshe/pages/upload/blog/blog_form.dart';
import 'package:Awoshe/pages/upload_process/CategorySizeContent.dart';
import 'package:Awoshe/pages/upload_process/ColorSelectionContent.dart';
import 'package:Awoshe/pages/upload_process/FabricContent.dart';
import 'package:Awoshe/pages/upload_process/MeasurementSelectionContent.dart';
import 'package:Awoshe/pages/upload_process/OccasionSelectionContent.dart';
import 'package:Awoshe/pages/upload_process/PostContent.dart';
import 'package:Awoshe/pages/upload_process/ProductCarePage.dart';
import 'package:Awoshe/pages/upload_process/TitleDesctiptionContent.dart';
import 'package:Awoshe/pages/upload_process/VideoSelection.dart';
import 'package:Awoshe/services/storage.service.dart';
import 'package:Awoshe/services/validations.dart';
import 'package:Awoshe/utils/ImageUtils.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/utils/product_care_assets.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

part 'upload_store.g.dart';

class UploadStore = _UploadStore with _$UploadStore;
enum VideoStatus {NONE, ANALISING, DONE, ERROR }

enum UploadPlace {
  TITLE_DESCRIPTION, // 0
  PRODUCT_CARE, // 1
  CATEGORY_SIZE, //2
  COLORS, // 3
  FABRIC_TAGS, // 4
  OCCASION_SELECTION, // 5
  MEASUREMENT_SELECTION, // 6
  POST_CONTENT // 7
}

enum ProcessType { UPLOAD, UPDATE }

abstract class _UploadStore with Store {
  static final Validators validators = Validators();

  static const _DESIGN_STEPS_NUMBER = 8;
  static const _FABRIC_STEPS_NUMBER = 5;

  // these values aren't observables
  UploadPlace mostFarPlace;
  FeedType feedType;
  ProductType productType;
  ProcessType processType;
  List<UploadProgress> progressList;

  ImageOrientation firstImageOrientation;
  Product _productToUpdate;

  UserStore _userStore;

  final _service = UploadServiceV2();

  int totalSteps = _DESIGN_STEPS_NUMBER;

  @observable
  int currentStep = 1;

  @observable
  String title;
  @observable
  String titleErrorMsg;
  @observable
  String description;
  @observable
  String descriptionErrorMsg;

  @observable
  String fabricErrorMsg;

  @observable
  String careTip;

  @observable
  ObservableList<ProductCareType> productCareInfo = ObservableList();

  @observable
  SizeSelectionInfo sizeInfo;

  @observable
  String mainCategory;

  @observable
  String subCategory;

  /// All the colors available the default colors plus user custom colors
  @observable
  ObservableList<String> allColorsName;

  /// The colors which this product is available or will be.
  @observable
  ObservableList<String> selectedColors = ObservableList();

  @observable
  ObservableList<String> measurements = ObservableList();

  @observable
  ObservableList<String> occasions = ObservableList();

  @observable
  ObservableList<Collection> collections = ObservableList.of(
      [Collection.DEFAULT_TYPE]);

  @observable
  String fabricTags;

  @observable
  Collection selectedCollection = Collection.DEFAULT_TYPE;

  @observable
  ObservableList<String> images = ObservableList.of(['', '', '']);

  @observable
  ObservableList<String> fabricsId = ObservableList<String>();

  @observable
  String price;

  @observable
  String selectedCurrency = DEFAULT_CURRENCY;

  @observable
  String selectedDistanceUnit = DISTANCE_UNITS[0];

  @observable
  bool openImage = false;

  @observable
  bool isAvailable = true;

  String videoUrl;

  String videoSelectionError = '';

  @observable
  VideoStatus videoSetupStatus = VideoStatus.NONE;

  VideoPlayerController videoPlayerController;

  Future<void> _setupVideo(String videoFile) async {

      if (videoPlayerController != null){
        await videoPlayerController?.dispose();
      }
      if (videoFile.contains('https://'))
        videoPlayerController = VideoPlayerController.network(videoFile);
      else
       videoPlayerController = VideoPlayerController.file(File(videoFile));

      await videoPlayerController.initialize();
  }


  @action setVideoStatus(VideoStatus status) => videoSetupStatus = status;

  @action
  Future<void> chooseVideo() async {
    try {
    this.videoSetupStatus = VideoStatus.ANALISING;

    var videoFile = await FilePicker.getFile( type: FileType.VIDEO );
      if (videoFile != null) {
        print(videoFile);
        videoUrl = videoFile.path;
      }

      else {
        this.videoSetupStatus = VideoStatus.NONE;
        return;
      }

      await _setupVideo(videoFile.path);
      if (videoPlayerController.value.duration.inSeconds > 15){
        videoSelectionError = 'Max video duration is 15 seconds';
        this.videoSetupStatus = VideoStatus.ERROR;
        return;
      }
      this.videoSetupStatus = VideoStatus.DONE;
      videoSelectionError = '';
    }

    catch (ex){
      print(ex);
      videoSelectionError = ex.toString();
      this.videoSetupStatus = VideoStatus.ERROR;
    }
  }

  @action void removeProductVideo() {
    if ( (processType == ProcessType.UPDATE) && ( this.videoUrl.startsWith('https://') ) ){
      StorageService.removeProductVideo(
          productId: _productToUpdate.id,
          designerId: _productToUpdate.creator.id).then( (_) => print('cloud removed') );
    }

    clearVideoSelected();
  }

  @action
  Future<void> clearVideoSelected() async {

    if (this.videoPlayerController != null && this.videoPlayerController.value.isPlaying)
      await this.videoPlayerController.pause();
    //this.videoPlayerController?.dispose();

    this.videoUrl = null;
    this.videoSelectionError = '';
    this.videoSetupStatus = VideoStatus.NONE;

  }

  @action setAvailable(bool available) => isAvailable = available;

  @action
  void clearColors() => this.selectedColors = ObservableList();

  @action
  void addFabric(String id) {
    if (!fabricsId.contains(id))
      fabricsId.add(id);
  }

  @action
  void clearFabricList() => fabricsId.clear();

  @action
  void removeFabric(String id) => fabricsId.remove(id);

  @action
  void setOpenImage(bool flag) => this.openImage = flag;

  @action
  void setCurrency(String currency) => this.selectedCurrency = currency;

  @action
  void setPrice(String price) => this.price = price;

  @action
  void clearImages() {
    images[0] = '';
    images[1] = '';
    images[2] = '';
    firstImageOrientation = null;
  }

  bool _isImageListEmpty() {
    return (images[0].isEmpty && images[1].isEmpty && images[2].isEmpty);
  }

  void _initDefaultColors() =>
    allColorsName = ObservableList.of( AppData.DEFAULT_PRODUCT_COLORS_MAP.keys.toList() );

  void _addCustomUserColors(BuildContext context) {
    _userStore = Provider.of<UserStore>(context, listen: false);
    var customColors = _userStore.details.customColors;
    
    if (customColors == null || customColors.isEmpty)
      return;

    allColorsName.addAll(  customColors.keys.toList() );
  }

  @action addColorName(String name ) => allColorsName.add(name);

  @action addColorNames( Iterable iterable ) => allColorsName.addAll(iterable);

  @action
  addCareOption(ProductCareType option) => this.productCareInfo.add(option);

  @action
  removeCareOption(ProductCareType option) =>
      this.productCareInfo.remove(option);

  @action
  clearCareOptions() => this.productCareInfo.clear();

  @action
  void addImage(int index, String path) {
    images[index] = path;
    
    if (_isImageListEmpty())
      firstImageOrientation = null;
  }

  @action
  void setDistanceUnit(String unit) => this.selectedDistanceUnit = unit;

  @action
  void removeImage(String path) => images.remove(path);

  @action
  void setCollection(String title) {
    var collection = getCollectionByTitle(title);

    if (collection != null) {
      selectedCollection = collection;
      clearImages();
    }
  }

  Collection getCollectionByTitle(String title) {
    Collection collection;
    for (var i = 0; i < collections.length; i++) {
      if (collections[i].title == title) {
        collection = collections[i];
        break;
      }
    }
    return collection;
  }

  @action
  void setCurrentStep (int step) => currentStep = step;

  @action
  void loadCollections(String userId) {
    var service = CollectionService();
    service.getAllCollections(userId: userId).then(
            (data) =>
            collections.addAll(data));
  }

  @action
  void addCollection(Collection collection) => collections.add(collection);

  @action
  void addOccasion(String occasion) => occasions.add(occasion);

  @action
  void clearOccasions() => this.occasions = ObservableList();

  @action
  void clearMeasurements() => this.measurements = ObservableList();

  @action
  void remoteOccasion(String occasion) => occasions.remove(occasion);

  @action
  void addMeasurement(String measurement) => measurements.add(measurement);

  @action
  void removeMeasurement(String measurement) =>
      measurements.remove(measurement);

  @action
  void addColor(String color) => selectedColors.add(color);

  @action
  void removeColor(String color) => selectedColors.remove(color);

  @action
  void setMainCategory(String mainCategory) => this.mainCategory = mainCategory;

  @action
  void setSubCategory(String subCategory) => this.subCategory = subCategory;

  @action
  void setSizeInfo(SizeSelectionInfo sizeInfo) => this.sizeInfo = sizeInfo;

  @action
  void setTitle(String title) => this.title = title;

  @computed
  String get categoriesLabel {
    if (mainCategory == null && subCategory == null) return null;
    return '${Utils.capitalize(mainCategory)} '
        '-> ${Utils.capitalize(subCategory)}';
  }

  @action
  void setDescription(String description) {
    this.description = description;
  }

  _validateFabric() =>
      fabricErrorMsg = validators.validateFabric(this.fabricTags);

  bool isFabricValid() {
    _validateFabric();
    return (fabricErrorMsg == null);
  }

  @action
  void setFabricTags(String fabricTags) => this.fabricTags = fabricTags;

  @action
  void setCareOptions(List<ProductCareType> options) =>
      this.productCareInfo = ObservableList.of(options);

  @action
  void setAvailableColors(List<String> colors) =>
      this.selectedColors = ObservableList.of(colors);

  @action
  void setOccasions(List<String> occasions) =>
      this.occasions = ObservableList.of(occasions);

  @action
  void setMeasurement(List<String> measurements) =>
      this.measurements = ObservableList.of(measurements);

  @action
  void _validateTitle() => titleErrorMsg = validators.titleValidator(title);

  @action
  void _validateDescription() =>
      descriptionErrorMsg = validators.descriptionValidator(description);

  @action
  void setCareTip(String careTip) => this.careTip = careTip;

  bool isTitleDescriptionValid() {
    _validateTitle();
    _validateDescription();
    return ((titleErrorMsg == null) && (descriptionErrorMsg == null));
  }

  Product _generateProductModel(String userId) {
    List<String> imgs = [];
    images.forEach((path) {
      if (path.isNotEmpty) imgs.add(path);
    });

    return Product(
      title: this.title,
      description: this.description,
      careInfo: this.productCareInfo.toList(),
      productCare: this.careTip,
      //sizeText: this.sizeInfo.sizesText,
      sizesInfo: this.sizeInfo,
      currency: this.selectedCurrency,
      price: this.price,
      images: imgs,
      distanceUnit: (productType == ProductType.FABRIC)
          ? selectedDistanceUnit
          : null,
      availableColors: this.selectedColors,
      occassions: this.occasions,
      mainCategory: this.mainCategory,
      subCategory: this.subCategory,
      customMeasurements: this.measurements.toList(),

      videoUrl: this.videoUrl,

      fabricTags: this.fabricTags?.split(',') ?? [],
      //fabricTags: this.fabricsId.toList(),

      status: 'active',
      collection: this.selectedCollection,
      feedType: selectedCollection.displayType,
      productType: this.productType,
      owner: userId,
      isAvailable: this.isAvailable,
      customColors: _extractSelectedCustomColors(),
    );
  }

  Future<Product> uploadData(String userId) {
    Product p = _generateProductModel(userId);
    return _service.create(p, userId);
  }

  void startProductUpload(BuildContext context) {
    if (this.productType != ProductType.DESIGN ||
        this.processType != ProcessType.UPLOAD)
      clearStore();

    this.productType = ProductType.DESIGN;
    this.processType = ProcessType.UPLOAD;
    this.totalSteps = _DESIGN_STEPS_NUMBER;
    this.currentStep = 0;
    
    _initDefaultColors();
    _addCustomUserColors(context);

    if (progressList.isNotEmpty) {
      var index = progressList.indexWhere((element) =>
      element.type == this.productType);
      if (index >= 0) {
        var progressData = progressList.elementAt(index);

        if (progressData != null) {
          print('The progress data is ${progressData.data}');
          _productToUpdate = Product.fromJson(json.decode(progressData.data));
          if (_productToUpdate.price == null || _productToUpdate.price.isEmpty)
            _productToUpdate.price = '0';

          _settingFieldValues();
        }
      }
    }

    Navigator.push(context, CupertinoPageRoute(builder: (_) =>
        StepperUploadPage()));
  }

  void startFabricUpload(BuildContext context) {
    if (this.productType != ProductType.DESIGN ||
        this.processType != ProcessType.UPLOAD)
      clearStore();

    this.productType = ProductType.FABRIC;
    this.processType = ProcessType.UPLOAD;
    this.totalSteps = _FABRIC_STEPS_NUMBER;
    this.currentStep = 0;

    if (progressList.isNotEmpty) {
      var index = progressList.indexWhere((element) =>
      element.type == this.productType);
      if (index >= 0) {
        var progressData = progressList.elementAt(index);

        if (progressData != null) {
          print('The progress data is ${progressData.data}');
          _productToUpdate = Product.fromJson(json.decode(progressData.data));
          if (_productToUpdate.price == null || _productToUpdate.price.isEmpty)
            _productToUpdate.price = '0';

          _settingFieldValues();
        }
      }
    }
    Navigator.push(context, CupertinoPageRoute(builder: (_) =>
        StepperUploadPage()));
  }

  void startBlogUpload(BuildContext context) {
    processType = ProcessType.UPLOAD;
    Navigator.push(context, CupertinoPageRoute(
        builder: (context) => UploadBlog())
    );
  }

  void startUpdateProcess(BuildContext context,
      {@required Product product}) {
    processType = ProcessType.UPDATE;

    this._productToUpdate = product;
    this.productType = product.productType;
    this.feedType = product.feedType;
    this.videoUrl = null;
    this.videoSetupStatus = VideoStatus.NONE;

    _initDefaultColors();
    _addCustomUserColors(context);

    _settingFieldValues();

    this.totalSteps = (productType == ProductType.FABRIC) ? _FABRIC_STEPS_NUMBER : _DESIGN_STEPS_NUMBER;
    this.currentStep = 0;

    Navigator.push(context, CupertinoPageRoute(builder: (_) =>
        StepperUploadPage()));
  }

  @action
  void incrementStep() {
    if (this.currentStep < totalSteps)
      this.currentStep++;
  }

  @action
  void decrementStep() {
    if (this.currentStep > 0)
      this.currentStep--;
  }

  // this method is handling the page stack of
  // the upload process.

  void _animateToPage(PageController controller, int pageIndex) =>
      controller.animateToPage(pageIndex,
          duration: Duration(milliseconds: 400), curve: Curves.easeOut );

  Widget basicInfoWidget (BuildContext context, PageController controller) => TitleDescriptionPage(
    nextCallback: (isValid) {
      if (isValid) {
        _animateToPage(controller, this.currentStep + 1);
      }
    },
  );

  Widget careWidget (BuildContext context, PageController controller) => ProductCarePage(
    nextCallback: (isValid) {
      if (isValid)
        _animateToPage(controller, this.currentStep + 1);
      else
        ShowFlushToast(context, ToastType.WARNING,
            'You must select at least one care option');
    },
  );

  Widget categoryAndSizeWidget(BuildContext context, PageController controller)
    => CategorySizeContent(
      nextCallback: (isValid) => _animateToPage(controller, this.currentStep +1),);

  Widget colorsWidget(BuildContext context, PageController controller) => ColorSelectionPage(
    nextCallback: (isValid) {
      if (isValid) {
        _animateToPage(controller, this.currentStep +1);
      }
      else
        ShowFlushToast(
            context, ToastType.WARNING, 'Color is required.');
    },
  );

  Widget fabricWidget(BuildContext context, PageController controller) => FabricContent(
    nextCallback: (isValid) {
      if (isValid) {
        _animateToPage(controller, this.currentStep +1);
//        incrementStep();
//        _goTo(context, UploadPlace.OCCASION_SELECTION);
      }

      else
        ShowFlushToast(
            context, ToastType.WARNING, 'One fabric is requied.');
    },
  );

  Widget occasionWidget(BuildContext context, PageController controller) => OccasionSelectionContent(
    nextCallback: () => _animateToPage(controller, this.currentStep +1),
  );

  Widget measurementWidget(BuildContext context, PageController controller) => MeasurementSelectionContent(
    nextCallback: () => _animateToPage(controller, this.currentStep +1),
  );


  Widget videoWidget(BuildContext context, PageController controller) => VideoSelection(
    nextCallback: () => _animateToPage(controller, this.currentStep + 1),
  );

  Widget photoAndPriceWidget(BuildContext context) => PostContent(

    onDoneCallback: (isValid) {
      if (isValid) {
        var userStore = Provider.of<UserStore>(context);

        if (processType == ProcessType.UPLOAD) {
          this.uploadData(userStore.details.id).then( (product) async {
            if ( (videoUrl != null) && ( !videoUrl.startsWith('https://')) ) {
              var data = await StorageService.uploadProductVideo(File('$videoUrl'),
                  productId: product.id,
                  designerId: userStore.details.id
              );

              if (data.isNotEmpty){
//                product.videoUrl = videoUrl;
                ProductApi.update(
                    productId:product.id,
                    productData: {'videoUrl': videoUrl},
                    userId: userStore.details.id);
              }
            }
          } );
          _onUploadSuccess(context, userStore);
        }

        else {
          this.updateData(userStore.details.id);
          _onUpdateSuccess(context);
        }

        Utils.showAlertMessage(
          context,
          message: this.productType == ProductType.DESIGN
              ? Localization
              .of(context)
              .productUploadSuccess
              : Localization
              .of(context)
              .fabricUploadSuccess,
          title: 'Dear Designer',
          onConfirm: () => _finishProcess(context),
          confirmText: 'Ok',

        );
      }
    },
  );

  void _onUpdateSuccess(BuildContext context) {
    Provider.of<DatabaseProvider>(context).remove(this.productType);
    progressList.removeWhere((e) => e.type == this.productType);
    clearStore();
  }

  void _onUploadSuccess(BuildContext context, UserStore userStore) {
    _incrementDesignCounter(userStore);
    Provider.of<DatabaseProvider>(context).remove(this.productType);
    progressList.removeWhere((e) => e.type == this.productType);
    clearStore();
  }

  void _incrementDesignCounter(UserStore userStore) {
    print('Incrementing design count...');
    var details = userStore.details;
    userStore.setUserDetails(
        details.copyWith(designsCount: details.designsCount + 1)
    );
  }

  void _finishProcess(BuildContext context) => Navigator.popUntil(context, (route) {
    return route.isFirst;
  });

  void _saveDataOnDB(BuildContext context) {
    _productToUpdate = _generateProductModel(Provider
        .of<UserStore>(context)
        .details
        .id);

    // avoiding to save temp image files path
    _productToUpdate.images = null;

    UploadProgress progress = UploadProgress(
        this.productType, jsonEncode(_productToUpdate.toJson()));
    Provider.of<DatabaseProvider>(context).saveData(progress);
    if (progressList.isNotEmpty)
      progressList.removeWhere((e) => e.type == this.productType);

    progressList.add(progress);
  }

  void saveAndExit(BuildContext context) {
    _saveDataOnDB(context);
    Navigator.pop(context);
    clearStore();
  }

  bool uploadValidation(BuildContext context) {
    var isValid = false;
    switch (this.productType) {
      case ProductType.FABRIC:
      case ProductType.DESIGN:
        isValid = (_validatePrice(context) && (_validateImages(context)));
        break;

      case ProductType.BLOG:
      // TODO: Handle this case.
        break;
    }

    return isValid;
  }

  bool _validatePrice(BuildContext context) {
    var priceValid = validators.validatePrice(this.price);
    if (priceValid != null) {
      ShowFlushToast(context, ToastType.WARNING, priceValid);
      return false;
    }
    return true;
  }

  bool _validateImages(BuildContext context) {
    var flag = false;
    for (var i = 0; i < images.length; i++) {
      if (images[i].isNotEmpty) {
        flag = true;
        break;
      }
    }

    if (!flag)
      ShowFlushToast(
          context, ToastType.WARNING, 'You must provide at least one picture');

    return flag;
  }

  void clearStore() {
    print('Cleaning store');

    this.setTitle(null);
    this.setDescription(null);
    this.setOpenImage(false);
    this.setSizeInfo(null);
    this.setMainCategory(null);
    this.setSubCategory(null);
    this.setCareTip(null);
    this.setCollection('SINGLE');
    this.setCurrency(DEFAULT_CURRENCY);
    this.setPrice(null);
    this.setDistanceUnit(DISTANCE_UNITS[0]);
    this.setFabricTags('');

    this.titleErrorMsg = null;
    this.descriptionErrorMsg = null;
    this.currentStep = 0;
    clearFabricList();
    clearImages();
    clearOccasions();
    clearCareOptions();
    clearMeasurements();
    clearColors();
    clearVideoSelected();
    _productToUpdate = null;
  }

  void _settingFieldValues() {
    setTitle(_productToUpdate.title);
    setDescription(_productToUpdate.description);
    setCareTip(_productToUpdate.productCare);
    setCareOptions(_productToUpdate.careInfo);
    setAvailableColors(_productToUpdate.availableColors);
    setPrice(_productToUpdate.price);
    setCurrency(_productToUpdate.currency);
    setCollection(_productToUpdate.collection?.title ?? "SINGLE");
    setOccasions(_productToUpdate.occassions);
    setAvailable(_productToUpdate.isAvailable);
    
    if (_productToUpdate.videoUrl != null){
      this.videoUrl = _productToUpdate.videoUrl;
      this.videoSetupStatus = VideoStatus.ANALISING;
    }
    // TODO THIS WILL CHANGE
    var fabric = '';
    _productToUpdate.fabricTags.forEach( (tag) {
      if (tag.isNotEmpty)
        fabric += '$tag,';
    } );

    if (fabric.isNotEmpty)
      fabric = fabric.substring(0,  fabric.length - 1);

    setFabricTags(fabric);
    

    // The images...
    _productToUpdate.images.forEach((url) =>
        this.addImage(_productToUpdate.images.indexOf(url), url)
    );

    switch(_productToUpdate.orientation) {
      case 'p':
        firstImageOrientation = ImageOrientation.PORTRAIT;
        break;

      case 'l':
        firstImageOrientation = ImageOrientation.LANDSCAPE;
        break;

      case 's':
        firstImageOrientation = ImageOrientation.SQUARE;
        break;
    }


    if (_productToUpdate.videoUrl !=null && _productToUpdate.videoUrl.startsWith('https://')){
     // setVideoStatus(VideoStatus.ANALISING);

      videoPlayerController = VideoPlayerController.network(_productToUpdate.videoUrl);
      videoPlayerController.initialize()
          .then( (_) => setVideoStatus(VideoStatus.DONE))
          .catchError((_) => setVideoStatus(VideoStatus.NONE));

    }
    switch (_productToUpdate.productType) {
      case ProductType.DESIGN:
        setMainCategory(_productToUpdate.mainCategory);
        setSubCategory(_productToUpdate.subCategory);
        setMeasurement(_productToUpdate.customMeasurements);
        setSizeInfo(_productToUpdate.sizesInfo);
        break;
      
      case ProductType.FABRIC:
        setDistanceUnit(_productToUpdate.distanceUnit);
        break;

      case ProductType.BLOG:
        break;
    }
  }

  Future<void> updateData(String userId) async {
    Product p = _generateProductModel(userId);
    p.id = _productToUpdate.id;
    p.owner = _productToUpdate.owner;
    p.creator = _productToUpdate.creator;
    p.itemId = _productToUpdate.itemId;

    if  (p.videoUrl != null && p.videoUrl.startsWith('https://')) {
     return _service.update(p, userId);
    }

    else {
      var localVideoUrl = p.videoUrl;
       p.videoUrl = null;
      await _service.update(p, userId);
      print('Uploading video');

      if (localVideoUrl == null)
        return;

      var url = await StorageService.uploadProductVideo( File(localVideoUrl), productId: p.id, designerId: userId);
      ProductApi.update(productId: p.id, productData: {'videoUrl': url}, userId: userId);

    }


  }

  Map<String, dynamic> _extractSelectedCustomColors() {
    var customColors = <String,dynamic> {};

    if (_userStore.details.customColors != null && _userStore.details.customColors.isNotEmpty){

      selectedColors.forEach( (selectedColorName) {
        if (_userStore.details.customColors.containsKey( selectedColorName  )) {
          print('Color founded selectedColorName: ${_userStore.details
              .customColors[selectedColorName]}');

          customColors.putIfAbsent(selectedColorName, () => _userStore.details
              .customColors[selectedColorName]);
        }
      } );
    }
    return customColors;
  }
}
