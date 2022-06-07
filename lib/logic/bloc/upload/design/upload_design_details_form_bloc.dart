import 'dart:async';
import 'dart:io';
import 'package:Awoshe/logic/bloc_helpers/bloc_provider.dart';
import 'package:Awoshe/services/validations.dart';
import 'package:rxdart/rxdart.dart';

class UploadDesignDetailsFormBloc extends Object
    with Validators
    implements BlocBase, RegistrationFormBlocAbstract {
  final BehaviorSubject<List<File>> _imageController =
      BehaviorSubject<List<File>>();

  final _titleController = BehaviorSubject<String>();
  final _descController = BehaviorSubject<String>();
  final _productCareInfoController = BehaviorSubject<String>();
  final _priceController = BehaviorSubject<String>();
  final _categoryController = BehaviorSubject<String>();
  final _otherInfosController = BehaviorSubject<String>();
  final BehaviorSubject<String> _collectionNameController = BehaviorSubject<String>();
  final BehaviorSubject<String> _collectionDescController = BehaviorSubject<String>();

  @override
  Stream<List<File>> get images => _imageController.stream;

  // sink
  @override
  Function(List<File>) get changeImage => _imageController.sink.add;

  @override
  Stream<String> get title => _titleController.stream.transform(validateTitle);

  @override
  Stream<String> get desc => _descController.stream;

  @override
  Stream<String> get productCareInfo => _productCareInfoController.stream;

  @override
  Stream<String> get category => _categoryController.stream;

  @override
  Stream<String> get price => _priceController.stream;

  @override
  Stream<String> get otherInfos => _otherInfosController.stream;

  @override
  Stream<String> get collectionName => _collectionNameController.stream.transform(validateCollName);

  @override
  Stream<String> get collectionDesc => _collectionDescController.stream;

  @override
  Stream<bool> get submitValid => Observable.combineLatest2(
      title, price, (e, p) => true);

  // sink
  @override
  Function(String) get changeTitle => _titleController.sink.add;

  @override
  Function(String) get changeDesc => _descController.sink.add;

  @override
  Function(String) get changeProductCareInfo =>
      _productCareInfoController.sink.add;

  @override
  Function(String) get changePrice => _priceController.sink.add;

  @override
  Function(String) get changeCategory => _categoryController.sink.add;

  @override
  Function(String) get changeOtherInfos => _otherInfosController.sink.add;

  @override
  Function(String) get changeCollectionName => _collectionNameController.sink.add;

  @override
  Function(String) get changeCollectionDesc => _collectionDescController.sink.add;

  @override
  void dispose() {
    _imageController.close();
    _titleController.close();
    _descController.close();
    _productCareInfoController.close();
    _categoryController.close();
    _priceController.close();
    _otherInfosController.close();
    _collectionNameController.close();
    _collectionDescController.close();
  }
}

abstract class RegistrationFormBlocAbstract {
  Function(List<File>) get changeImage;
  Function(String) get changeTitle;
  Function(String) get changeDesc;
  Function(String) get changeProductCareInfo;
  Function(String) get changePrice;
  Function(String) get changeCategory;
  Function(String) get changeOtherInfos;
  Function(String) get changeCollectionName;
  Function(String) get changeCollectionDesc;

  Stream<List<File>> get images;
  Stream<String> get title;
  Stream<String> get desc;
  Stream<String> get productCareInfo;
  Stream<String> get price;
  Stream<String> get category;
  Stream<String> get otherInfos;
  Stream<String> get collectionName;
  Stream<String> get collectionDesc;
  Stream<bool> get submitValid;

  void dispose();
}
