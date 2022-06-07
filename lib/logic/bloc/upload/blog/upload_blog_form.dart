import 'dart:async';
import 'dart:io';
import 'package:Awoshe/logic/bloc_helpers/bloc_provider.dart';
import 'package:Awoshe/services/validations.dart';
import 'package:rxdart/rxdart.dart';

class UploadBlogFormBloc extends Object
    with Validators
    implements BlocBase, RegistrationFormBlocAbstract {
  final BehaviorSubject<List<File>> _imageController =
      BehaviorSubject<List<File>>();
  final _titleController = BehaviorSubject<String>();
  final _descController = BehaviorSubject<String>();
  final _urlController = BehaviorSubject<String>();
  final _categoryController = BehaviorSubject<String>();

  Stream<String> get category => _categoryController.stream;

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
  Stream<String> get url => _urlController.stream.transform(validateUrl);

  @override
  Stream<bool> get submitValid =>
      Observable.combineLatest3(title, url, desc, (e, p, d) => true);

  // sink
  @override
  Function(String) get changeTitle => _titleController.sink.add;

  @override
  Function(String) get changeDesc => _descController.sink.add;

  @override
  Function(String) get changeUrl => _urlController.sink.add;

  Function(String) get changeCategory => _categoryController.sink.add;

  @override
  void dispose() {
    _imageController.close();
    _titleController.close();
    _descController.close();
    _urlController.close();
    _categoryController.close();
  }
}

abstract class RegistrationFormBlocAbstract {
  Function(List<File>) get changeImage;
  Function(String) get changeTitle;
  Function(String) get changeDesc;
  Function(String) get changeUrl;

  Stream<List<File>> get images;
  Stream<String> get title;
  Stream<String> get desc;
  Stream<String> get url;
  Stream<bool> get submitValid;

  void dispose();
}
