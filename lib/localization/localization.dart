import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:Awoshe/localization/localization_en.dart';

import 'localization_fr.dart';

abstract class Localization {
  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  String get appName;
  String get loginCreateYourAccount;
  String get loginSignInGoogle;
  String get loginSignInFacebook;
  String get loginSignIn;
  String get loginText1;
  String get loginText2;
  String get login;
  String get signUp;
  String get registerHere;
  String get signUpWith;
  String get signInWith;
  String get signupWelcomeText;
  String get forgotPasswordTitle;
  String get register;
  String get alreadyHaveAccount;
  String get privacyPolicy;
  String get verificationEmailSent;
  String get verifyEmailText;
  String get send;
  String get confirm;

  String get name;
  String get username;
  String get email;
  String get password;
  String get location;
  String get cancel;
  String get settings;
  String get account;
  String get logout;
  String get profile;
  String get loadMore;
  String get errorOccurred;
  String get retry;
  String get save;
  String get submit;
  String get share;
  String get next;

  String get street;
  String get city;
  String get state;
  String get zipCode;
  String get country;

  String get height;
  String get hip;
  String get burst;
  String get chest;
  String get arms;
  String get waist;

  String get home;
  String get notification;
  String get upload;
  String get create;
  String get search;
  String get message;
  String get cart;
  String get explore;

  String get saleOnAwoshe;
  String get about;
  String get logoutConfirmText;
  String get discard;
  String get typeMessage;

  String get desc;
  String get title;
  String get productCare;
  String get category;
  String get price;
  String get availableColor;
  String get otherInfo;
  String get availableFabrics;
  String get selectOccasion;
  String get customMeasurementsNeeded;
  String get help;
  String get standardOrder;
  String get customOrder;
  String get productUploadSuccess;
  String get fabricUploadSuccess;
  String get productOwnerIsSameAsLoggedIn;
  String get blogUrl;
  String get seeAll;

  String get sendReviewTemplate;
  String get collectionName;

  String get followPlus;
  String get following;

  String get newFeedsAvailable;
  String get favourites;
  String get designs;
  String get orders;
  String get contact;
  String get purchasesAndReviews;
  String get followers;
  String get displayType;
  String get thumbnail;
  String get carousel;
  String get portrait;
  String get landscape;

  // cartPage texts
  String get submitOrderAdvice;
  String get completeYourOrder;
  String get total;
  String get tax;
  String get shipping;
  String get itemsTotal;
  String get buyingGift;
  String get itemDeletedFromCart;
  String get emptyCart;

  // product page
  String get customize;
  String get addToCart;
  String get madeAndSoldBy;

  String get personalInformation;
  String get address;

  String get signInToPurchase;
}

class AwosheLocalizationsDelegate extends LocalizationsDelegate<Localization> {
  const AwosheLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'de', 'fr'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) => _load(locale);

  static Future<Localization> _load(Locale locale) async {
    final String name = (locale.countryCode == null || locale.countryCode.isEmpty) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;

    if( locale.languageCode == "en" ) {
      return LocalizationEN();
    } else if (locale.languageCode == "fr") {
      return LocalizationFR();
    }
    return LocalizationEN(); // Default
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}