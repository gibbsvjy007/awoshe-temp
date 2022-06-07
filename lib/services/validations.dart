import 'dart:async';

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp nameExp = new RegExp(
        r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');

    if (email.isEmpty)
      sink.addError('Email is required');
    else if (!nameExp.hasMatch(email))
      sink.addError('Invalid email address');
    else
      sink.add(email);
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6)
      sink.add(password);
    else
      sink.addError('Password must be at least 6 characters');
  });

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    final RegExp nameExp = new RegExp(r'^[a-zA-Z\x7f-\xff ]+$');

    if (name.isEmpty)
      sink.addError('Name is required');
    else if (!nameExp.hasMatch(name))
      sink.addError('Please enter only alphabetical characters');
    else
      sink.add(name);
  });

  final validateUserName = StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    final RegExp nameExp = new RegExp(r'^(?=.{7,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$');

    if (name.isEmpty)
      sink.addError('UserName is required');
    else if (!nameExp.hasMatch(name))
      sink.addError('UserName must be 7 to 20 characters long');
    else
      sink.add(name);
  });

  final validateSearch =
      StreamTransformer<String, String>.fromHandlers(handleData: (searchText, sink) {
    final RegExp searchTextExp = new RegExp(r'^[a-zA-Z\x7f-\xff ]+$');

    if (!searchTextExp.hasMatch(searchText))
      sink.addError('Please enter only alphabetical characters');
    else
      sink.add(searchText);
  });

  String titleValidator(String title) {
    final RegExp titleExp = new RegExp(r'^[a-zA-Z\x7f-\xff ]+$');
    if (title == null || title.isEmpty)
      return 'Title is required';

    if (!titleExp.hasMatch(title))
      return 'Please enter only alphabetical characters';

    return null;
  }

  String descriptionValidator(String description) {
    if (description == null || description.isEmpty)
      return 'Description is required';

    return null;
  }

  String validateCategory(String mainCategory) {
    if (mainCategory == null || mainCategory.isEmpty)
      return 'Main category is required';

    return null;
  }

  String validateSubCategory(String subcategory) {
    if (subcategory == null || subcategory.isEmpty)
      return 'Subcategory is required';

    return null;
  }

  String validateFabric(String fabric) {
    final RegExp titleExp = new RegExp(r'^[a-zA-Z0-9,]+$');
    if (fabric == null || fabric.isEmpty)
      return 'One fabric is required';

    else if (!titleExp.hasMatch(fabric))
      return 'Fabric options should be separated by comma.';

    return null;
  }

  String validatePrice(String price) {
    final RegExp priceExp = new RegExp(r'^[0-9,.]+$');
    if (price == null || price.isEmpty)
      return 'Price is required!';

    else if (!priceExp.hasMatch(price))
      return 'Use only numeric characters in price field.';

    return null;
  }

  String zipCodeValidation(String zipCode) {
    if (zipCode == null || zipCode.isEmpty)
      return 'Zip code is required';

    return null;
  }

  String nameValidation(String name) {
    final RegExp nameExp = new RegExp(r'^[a-zA-Z\x7f-\xff ]+$');

    if (name.isEmpty)
      return 'Name is required';

    else if (!nameExp.hasMatch(name))
      return 'Please enter only alphabetical characters';

    return null;
  }

  String noEmptyValidation(String data) =>
      (data == null || data.isEmpty) ? ''
          'This field is required'
          : null;


  final validateUrl =
  StreamTransformer<String, String>.fromHandlers(handleData: (title, sink) {
    var urlPattern = r"(https?)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
    var regExp = new RegExp(urlPattern, caseSensitive: false);
    //final RegExp titleExp = new RegExp(r'^[a-zA-Z\x7f-\xff ]+$');

    if (title.isEmpty)
      sink.addError('An url is required');
    else if (!regExp.hasMatch(title))
      sink.addError('You must add http:// or https://');
    else
      sink.add(title);
  });



  // TODO this method must to go
  final validateTitle =
      StreamTransformer<String, String>.fromHandlers(handleData: (title, sink) {
    final RegExp titleExp = new RegExp(r'^[a-zA-Z\x7f-\xff ]+$');

    if (title.isEmpty)
      sink.addError('Title is required');
    else if (!titleExp.hasMatch(title))
      sink.addError('Please enter only alphabetical characters');
    else
      sink.add(title);
  });

  final validateCollName = StreamTransformer<String, String>.fromHandlers(handleData: (collName, sink) {
    final RegExp collNameExp = new RegExp(r'^[a-zA-Z\x7f-\xff ]+$');

    if (collName.isEmpty)
      sink.addError('Collection Name is required');
    else if (!collNameExp.hasMatch(collName))
      sink.addError('Please enter only alphabetical characters');
    else
      sink.add(collName);
  });


}
