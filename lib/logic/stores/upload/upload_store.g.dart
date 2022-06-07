// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UploadStore on _UploadStore, Store {
  Computed<String> _$categoriesLabelComputed;

  @override
  String get categoriesLabel => (_$categoriesLabelComputed ??=
          Computed<String>(() => super.categoriesLabel))
      .value;

  final _$currentStepAtom = Atom(name: '_UploadStore.currentStep');

  @override
  int get currentStep {
    _$currentStepAtom.context.enforceReadPolicy(_$currentStepAtom);
    _$currentStepAtom.reportObserved();
    return super.currentStep;
  }

  @override
  set currentStep(int value) {
    _$currentStepAtom.context.conditionallyRunInAction(() {
      super.currentStep = value;
      _$currentStepAtom.reportChanged();
    }, _$currentStepAtom, name: '${_$currentStepAtom.name}_set');
  }

  final _$titleAtom = Atom(name: '_UploadStore.title');

  @override
  String get title {
    _$titleAtom.context.enforceReadPolicy(_$titleAtom);
    _$titleAtom.reportObserved();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.context.conditionallyRunInAction(() {
      super.title = value;
      _$titleAtom.reportChanged();
    }, _$titleAtom, name: '${_$titleAtom.name}_set');
  }

  final _$titleErrorMsgAtom = Atom(name: '_UploadStore.titleErrorMsg');

  @override
  String get titleErrorMsg {
    _$titleErrorMsgAtom.context.enforceReadPolicy(_$titleErrorMsgAtom);
    _$titleErrorMsgAtom.reportObserved();
    return super.titleErrorMsg;
  }

  @override
  set titleErrorMsg(String value) {
    _$titleErrorMsgAtom.context.conditionallyRunInAction(() {
      super.titleErrorMsg = value;
      _$titleErrorMsgAtom.reportChanged();
    }, _$titleErrorMsgAtom, name: '${_$titleErrorMsgAtom.name}_set');
  }

  final _$descriptionAtom = Atom(name: '_UploadStore.description');

  @override
  String get description {
    _$descriptionAtom.context.enforceReadPolicy(_$descriptionAtom);
    _$descriptionAtom.reportObserved();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.context.conditionallyRunInAction(() {
      super.description = value;
      _$descriptionAtom.reportChanged();
    }, _$descriptionAtom, name: '${_$descriptionAtom.name}_set');
  }

  final _$descriptionErrorMsgAtom =
      Atom(name: '_UploadStore.descriptionErrorMsg');

  @override
  String get descriptionErrorMsg {
    _$descriptionErrorMsgAtom.context
        .enforceReadPolicy(_$descriptionErrorMsgAtom);
    _$descriptionErrorMsgAtom.reportObserved();
    return super.descriptionErrorMsg;
  }

  @override
  set descriptionErrorMsg(String value) {
    _$descriptionErrorMsgAtom.context.conditionallyRunInAction(() {
      super.descriptionErrorMsg = value;
      _$descriptionErrorMsgAtom.reportChanged();
    }, _$descriptionErrorMsgAtom,
        name: '${_$descriptionErrorMsgAtom.name}_set');
  }

  final _$fabricErrorMsgAtom = Atom(name: '_UploadStore.fabricErrorMsg');

  @override
  String get fabricErrorMsg {
    _$fabricErrorMsgAtom.context.enforceReadPolicy(_$fabricErrorMsgAtom);
    _$fabricErrorMsgAtom.reportObserved();
    return super.fabricErrorMsg;
  }

  @override
  set fabricErrorMsg(String value) {
    _$fabricErrorMsgAtom.context.conditionallyRunInAction(() {
      super.fabricErrorMsg = value;
      _$fabricErrorMsgAtom.reportChanged();
    }, _$fabricErrorMsgAtom, name: '${_$fabricErrorMsgAtom.name}_set');
  }

  final _$careTipAtom = Atom(name: '_UploadStore.careTip');

  @override
  String get careTip {
    _$careTipAtom.context.enforceReadPolicy(_$careTipAtom);
    _$careTipAtom.reportObserved();
    return super.careTip;
  }

  @override
  set careTip(String value) {
    _$careTipAtom.context.conditionallyRunInAction(() {
      super.careTip = value;
      _$careTipAtom.reportChanged();
    }, _$careTipAtom, name: '${_$careTipAtom.name}_set');
  }

  final _$productCareInfoAtom = Atom(name: '_UploadStore.productCareInfo');

  @override
  ObservableList<ProductCareType> get productCareInfo {
    _$productCareInfoAtom.context.enforceReadPolicy(_$productCareInfoAtom);
    _$productCareInfoAtom.reportObserved();
    return super.productCareInfo;
  }

  @override
  set productCareInfo(ObservableList<ProductCareType> value) {
    _$productCareInfoAtom.context.conditionallyRunInAction(() {
      super.productCareInfo = value;
      _$productCareInfoAtom.reportChanged();
    }, _$productCareInfoAtom, name: '${_$productCareInfoAtom.name}_set');
  }

  final _$sizeInfoAtom = Atom(name: '_UploadStore.sizeInfo');

  @override
  SizeSelectionInfo get sizeInfo {
    _$sizeInfoAtom.context.enforceReadPolicy(_$sizeInfoAtom);
    _$sizeInfoAtom.reportObserved();
    return super.sizeInfo;
  }

  @override
  set sizeInfo(SizeSelectionInfo value) {
    _$sizeInfoAtom.context.conditionallyRunInAction(() {
      super.sizeInfo = value;
      _$sizeInfoAtom.reportChanged();
    }, _$sizeInfoAtom, name: '${_$sizeInfoAtom.name}_set');
  }

  final _$mainCategoryAtom = Atom(name: '_UploadStore.mainCategory');

  @override
  String get mainCategory {
    _$mainCategoryAtom.context.enforceReadPolicy(_$mainCategoryAtom);
    _$mainCategoryAtom.reportObserved();
    return super.mainCategory;
  }

  @override
  set mainCategory(String value) {
    _$mainCategoryAtom.context.conditionallyRunInAction(() {
      super.mainCategory = value;
      _$mainCategoryAtom.reportChanged();
    }, _$mainCategoryAtom, name: '${_$mainCategoryAtom.name}_set');
  }

  final _$subCategoryAtom = Atom(name: '_UploadStore.subCategory');

  @override
  String get subCategory {
    _$subCategoryAtom.context.enforceReadPolicy(_$subCategoryAtom);
    _$subCategoryAtom.reportObserved();
    return super.subCategory;
  }

  @override
  set subCategory(String value) {
    _$subCategoryAtom.context.conditionallyRunInAction(() {
      super.subCategory = value;
      _$subCategoryAtom.reportChanged();
    }, _$subCategoryAtom, name: '${_$subCategoryAtom.name}_set');
  }

  final _$allColorsNameAtom = Atom(name: '_UploadStore.allColorsName');

  @override
  ObservableList<String> get allColorsName {
    _$allColorsNameAtom.context.enforceReadPolicy(_$allColorsNameAtom);
    _$allColorsNameAtom.reportObserved();
    return super.allColorsName;
  }

  @override
  set allColorsName(ObservableList<String> value) {
    _$allColorsNameAtom.context.conditionallyRunInAction(() {
      super.allColorsName = value;
      _$allColorsNameAtom.reportChanged();
    }, _$allColorsNameAtom, name: '${_$allColorsNameAtom.name}_set');
  }

  final _$selectedColorsAtom = Atom(name: '_UploadStore.selectedColors');

  @override
  ObservableList<String> get selectedColors {
    _$selectedColorsAtom.context.enforceReadPolicy(_$selectedColorsAtom);
    _$selectedColorsAtom.reportObserved();
    return super.selectedColors;
  }

  @override
  set selectedColors(ObservableList<String> value) {
    _$selectedColorsAtom.context.conditionallyRunInAction(() {
      super.selectedColors = value;
      _$selectedColorsAtom.reportChanged();
    }, _$selectedColorsAtom, name: '${_$selectedColorsAtom.name}_set');
  }

  final _$measurementsAtom = Atom(name: '_UploadStore.measurements');

  @override
  ObservableList<String> get measurements {
    _$measurementsAtom.context.enforceReadPolicy(_$measurementsAtom);
    _$measurementsAtom.reportObserved();
    return super.measurements;
  }

  @override
  set measurements(ObservableList<String> value) {
    _$measurementsAtom.context.conditionallyRunInAction(() {
      super.measurements = value;
      _$measurementsAtom.reportChanged();
    }, _$measurementsAtom, name: '${_$measurementsAtom.name}_set');
  }

  final _$occasionsAtom = Atom(name: '_UploadStore.occasions');

  @override
  ObservableList<String> get occasions {
    _$occasionsAtom.context.enforceReadPolicy(_$occasionsAtom);
    _$occasionsAtom.reportObserved();
    return super.occasions;
  }

  @override
  set occasions(ObservableList<String> value) {
    _$occasionsAtom.context.conditionallyRunInAction(() {
      super.occasions = value;
      _$occasionsAtom.reportChanged();
    }, _$occasionsAtom, name: '${_$occasionsAtom.name}_set');
  }

  final _$collectionsAtom = Atom(name: '_UploadStore.collections');

  @override
  ObservableList<Collection> get collections {
    _$collectionsAtom.context.enforceReadPolicy(_$collectionsAtom);
    _$collectionsAtom.reportObserved();
    return super.collections;
  }

  @override
  set collections(ObservableList<Collection> value) {
    _$collectionsAtom.context.conditionallyRunInAction(() {
      super.collections = value;
      _$collectionsAtom.reportChanged();
    }, _$collectionsAtom, name: '${_$collectionsAtom.name}_set');
  }

  final _$fabricTagsAtom = Atom(name: '_UploadStore.fabricTags');

  @override
  String get fabricTags {
    _$fabricTagsAtom.context.enforceReadPolicy(_$fabricTagsAtom);
    _$fabricTagsAtom.reportObserved();
    return super.fabricTags;
  }

  @override
  set fabricTags(String value) {
    _$fabricTagsAtom.context.conditionallyRunInAction(() {
      super.fabricTags = value;
      _$fabricTagsAtom.reportChanged();
    }, _$fabricTagsAtom, name: '${_$fabricTagsAtom.name}_set');
  }

  final _$selectedCollectionAtom =
      Atom(name: '_UploadStore.selectedCollection');

  @override
  Collection get selectedCollection {
    _$selectedCollectionAtom.context
        .enforceReadPolicy(_$selectedCollectionAtom);
    _$selectedCollectionAtom.reportObserved();
    return super.selectedCollection;
  }

  @override
  set selectedCollection(Collection value) {
    _$selectedCollectionAtom.context.conditionallyRunInAction(() {
      super.selectedCollection = value;
      _$selectedCollectionAtom.reportChanged();
    }, _$selectedCollectionAtom, name: '${_$selectedCollectionAtom.name}_set');
  }

  final _$imagesAtom = Atom(name: '_UploadStore.images');

  @override
  ObservableList<String> get images {
    _$imagesAtom.context.enforceReadPolicy(_$imagesAtom);
    _$imagesAtom.reportObserved();
    return super.images;
  }

  @override
  set images(ObservableList<String> value) {
    _$imagesAtom.context.conditionallyRunInAction(() {
      super.images = value;
      _$imagesAtom.reportChanged();
    }, _$imagesAtom, name: '${_$imagesAtom.name}_set');
  }

  final _$fabricsIdAtom = Atom(name: '_UploadStore.fabricsId');

  @override
  ObservableList<String> get fabricsId {
    _$fabricsIdAtom.context.enforceReadPolicy(_$fabricsIdAtom);
    _$fabricsIdAtom.reportObserved();
    return super.fabricsId;
  }

  @override
  set fabricsId(ObservableList<String> value) {
    _$fabricsIdAtom.context.conditionallyRunInAction(() {
      super.fabricsId = value;
      _$fabricsIdAtom.reportChanged();
    }, _$fabricsIdAtom, name: '${_$fabricsIdAtom.name}_set');
  }

  final _$priceAtom = Atom(name: '_UploadStore.price');

  @override
  String get price {
    _$priceAtom.context.enforceReadPolicy(_$priceAtom);
    _$priceAtom.reportObserved();
    return super.price;
  }

  @override
  set price(String value) {
    _$priceAtom.context.conditionallyRunInAction(() {
      super.price = value;
      _$priceAtom.reportChanged();
    }, _$priceAtom, name: '${_$priceAtom.name}_set');
  }

  final _$selectedCurrencyAtom = Atom(name: '_UploadStore.selectedCurrency');

  @override
  String get selectedCurrency {
    _$selectedCurrencyAtom.context.enforceReadPolicy(_$selectedCurrencyAtom);
    _$selectedCurrencyAtom.reportObserved();
    return super.selectedCurrency;
  }

  @override
  set selectedCurrency(String value) {
    _$selectedCurrencyAtom.context.conditionallyRunInAction(() {
      super.selectedCurrency = value;
      _$selectedCurrencyAtom.reportChanged();
    }, _$selectedCurrencyAtom, name: '${_$selectedCurrencyAtom.name}_set');
  }

  final _$selectedDistanceUnitAtom =
      Atom(name: '_UploadStore.selectedDistanceUnit');

  @override
  String get selectedDistanceUnit {
    _$selectedDistanceUnitAtom.context
        .enforceReadPolicy(_$selectedDistanceUnitAtom);
    _$selectedDistanceUnitAtom.reportObserved();
    return super.selectedDistanceUnit;
  }

  @override
  set selectedDistanceUnit(String value) {
    _$selectedDistanceUnitAtom.context.conditionallyRunInAction(() {
      super.selectedDistanceUnit = value;
      _$selectedDistanceUnitAtom.reportChanged();
    }, _$selectedDistanceUnitAtom,
        name: '${_$selectedDistanceUnitAtom.name}_set');
  }

  final _$openImageAtom = Atom(name: '_UploadStore.openImage');

  @override
  bool get openImage {
    _$openImageAtom.context.enforceReadPolicy(_$openImageAtom);
    _$openImageAtom.reportObserved();
    return super.openImage;
  }

  @override
  set openImage(bool value) {
    _$openImageAtom.context.conditionallyRunInAction(() {
      super.openImage = value;
      _$openImageAtom.reportChanged();
    }, _$openImageAtom, name: '${_$openImageAtom.name}_set');
  }

  final _$isAvailableAtom = Atom(name: '_UploadStore.isAvailable');

  @override
  bool get isAvailable {
    _$isAvailableAtom.context.enforceReadPolicy(_$isAvailableAtom);
    _$isAvailableAtom.reportObserved();
    return super.isAvailable;
  }

  @override
  set isAvailable(bool value) {
    _$isAvailableAtom.context.conditionallyRunInAction(() {
      super.isAvailable = value;
      _$isAvailableAtom.reportChanged();
    }, _$isAvailableAtom, name: '${_$isAvailableAtom.name}_set');
  }

  final _$videoSetupStatusAtom = Atom(name: '_UploadStore.videoSetupStatus');

  @override
  VideoStatus get videoSetupStatus {
    _$videoSetupStatusAtom.context.enforceReadPolicy(_$videoSetupStatusAtom);
    _$videoSetupStatusAtom.reportObserved();
    return super.videoSetupStatus;
  }

  @override
  set videoSetupStatus(VideoStatus value) {
    _$videoSetupStatusAtom.context.conditionallyRunInAction(() {
      super.videoSetupStatus = value;
      _$videoSetupStatusAtom.reportChanged();
    }, _$videoSetupStatusAtom, name: '${_$videoSetupStatusAtom.name}_set');
  }

  final _$chooseVideoAsyncAction = AsyncAction('chooseVideo');

  @override
  Future<void> chooseVideo() {
    return _$chooseVideoAsyncAction.run(() => super.chooseVideo());
  }

  final _$clearVideoSelectedAsyncAction = AsyncAction('clearVideoSelected');

  @override
  Future<void> clearVideoSelected() {
    return _$clearVideoSelectedAsyncAction
        .run(() => super.clearVideoSelected());
  }

  final _$_UploadStoreActionController = ActionController(name: '_UploadStore');

  @override
  dynamic setVideoStatus(VideoStatus status) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setVideoStatus(status);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeProductVideo() {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.removeProductVideo();
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAvailable(bool available) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setAvailable(available);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearColors() {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.clearColors();
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addFabric(String id) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.addFabric(id);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearFabricList() {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.clearFabricList();
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFabric(String id) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.removeFabric(id);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOpenImage(bool flag) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setOpenImage(flag);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrency(String currency) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setCurrency(currency);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPrice(String price) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setPrice(price);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearImages() {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.clearImages();
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addColorName(String name) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.addColorName(name);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addColorNames(Iterable iterable) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.addColorNames(iterable);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addCareOption(ProductCareType option) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.addCareOption(option);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeCareOption(ProductCareType option) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.removeCareOption(option);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearCareOptions() {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.clearCareOptions();
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addImage(int index, String path) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.addImage(index, path);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDistanceUnit(String unit) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setDistanceUnit(unit);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeImage(String path) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.removeImage(path);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCollection(String title) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setCollection(title);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentStep(int step) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setCurrentStep(step);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadCollections(String userId) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.loadCollections(userId);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addCollection(Collection collection) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.addCollection(collection);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addOccasion(String occasion) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.addOccasion(occasion);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearOccasions() {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.clearOccasions();
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMeasurements() {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.clearMeasurements();
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remoteOccasion(String occasion) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.remoteOccasion(occasion);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addMeasurement(String measurement) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.addMeasurement(measurement);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeMeasurement(String measurement) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.removeMeasurement(measurement);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addColor(String color) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.addColor(color);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeColor(String color) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.removeColor(color);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMainCategory(String mainCategory) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setMainCategory(mainCategory);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSubCategory(String subCategory) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setSubCategory(subCategory);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSizeInfo(SizeSelectionInfo sizeInfo) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setSizeInfo(sizeInfo);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitle(String title) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setTitle(title);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String description) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setDescription(description);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFabricTags(String fabricTags) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setFabricTags(fabricTags);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCareOptions(List<ProductCareType> options) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setCareOptions(options);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAvailableColors(List<String> colors) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setAvailableColors(colors);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOccasions(List<String> occasions) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setOccasions(occasions);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMeasurement(List<String> measurements) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setMeasurement(measurements);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _validateTitle() {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super._validateTitle();
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _validateDescription() {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super._validateDescription();
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCareTip(String careTip) {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.setCareTip(careTip);
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementStep() {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.incrementStep();
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementStep() {
    final _$actionInfo = _$_UploadStoreActionController.startAction();
    try {
      return super.decrementStep();
    } finally {
      _$_UploadStoreActionController.endAction(_$actionInfo);
    }
  }
}
