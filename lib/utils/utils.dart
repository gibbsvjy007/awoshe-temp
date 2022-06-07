import 'dart:io';
import 'package:Awoshe/common/app.data.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/models/payment.dart';
import 'package:Awoshe/models/product/product_color.dart';
import 'package:Awoshe/services/user.service.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/widgets/awoshe_alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static const String _USER_ID_ = "UserId";
  static const String _IS_DESIGNER_ = "designer";
  static String _userId;

  static Future<String> getUserId() async {
    if (_userId == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _userId = prefs.getString(_USER_ID_);
    }
    return _userId;
  }

  static setDesigner(String userId) async {
    UserService userService = new UserService(userId: userId);
    final userData = await userService.getUser();
    AppData.isDesigner = userData?.roles?.designer ?? false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_IS_DESIGNER_, AppData.isDesigner);
  }

  static isDesigner() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool bDesinger = prefs.getBool(_IS_DESIGNER_);
    if (bDesinger != null) return bDesinger;
    return false;
  }

  static setFollowingCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("FOLLOWING_COUNT", count);
  }

  static getFollowingCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("FOLLOWING_COUNT");
  }

  static String capitalize(String input) {
    if (input == null) {
      throw new ArgumentError("string: $input");
    }
    if (input.length == 0) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  static getUserFullName(userId) async {
    print("____________set user full name_______");
    DocumentSnapshot _ref =
        await Firestore.instance.document("profiles/$userId").get();
    if (_ref.exists) {
      return _ref['fullName'];
    }
    return "Name Surname";
  }

  static getFirstName(String name) {
    return name.split(" ")[0];
  }

  static ProductType getProductType(UploadType type) {
    ProductType productType = ProductType.DESIGN;

    switch (type) {
      case UploadType.DESIGN:
        productType = ProductType.DESIGN;
        break;

      case UploadType.FABRIC:
        productType = ProductType.FABRIC;
        break;

      case UploadType.BLOG:
        productType = ProductType.BLOG;
        break;
    }
    return productType;
  }

  static FeedType getFeedTypeByText(String type) {
    FeedType feedType = FeedType.SINGLE;

    switch (type) {
      case 'BLOG':
        feedType = FeedType.BLOG;
        break;

      case 'TH':
        feedType = FeedType.TH;
        break;

      case 'SW':
        feedType = FeedType.SW;
        break;

      case 'SINGLE':
        feedType = FeedType.SINGLE;
        break;
    }
    return feedType;
  }

  static FeedType getFeedType(int type) {
    FeedType feedType = FeedType.SINGLE;

    switch (type) {
      case 0:
        feedType = FeedType.BLOG;
        break;

      case 1:
        feedType = FeedType.TH;
        break;

      case 2:
        feedType = FeedType.SW;
        break;

      case 3:
        feedType = FeedType.SINGLE;
        break;
    }
    return feedType;
  }

  static String getOrderType(OrderType type) {
    String orderType = 'STANDARD';

    switch (type) {
      case OrderType.STANDARD:
        orderType = 'STANDARD';
        break;

      case OrderType.CUSTOM:
        orderType = 'CUSTOM';
        break;

      case OrderType.BOTH:
        orderType = 'BOTH';
        break;
    }
    return orderType;
  }

  static String getSearchType(SearchType type) {
    switch (type) {

      case SearchType.DESIGNER:
        return 'designer';
        break;
      case SearchType.MEN:
        return 'men';
        break;
      case SearchType.WOMEN:
        return 'women';
        break;
      case SearchType.KIDS:
        return 'kids';
        break;
      case SearchType.ACCESSORIES:
        return 'accessories';
        break;
      case SearchType.GIRLS:
        return 'girls';
        break;
      case SearchType.HOME:
        return 'home';
        break;
      case SearchType.ALL:
        return 'all';
        break;
      default:
        return 'all';
    }
  }

  static String getDelieveryStatus(int type) {
    String orderType = 'STANDARD';

    switch (type) {
      case 0:
        orderType = 'PREPARING';
        break;

      case 1:
        orderType = 'SHIPPED';
        break;

      case 2:
        orderType = 'DELIVERED';
        break;

      case 3:
        orderType = 'IN_REVIEW';
        break;

      case 4:
        orderType = 'DONE';
        break;

      default:
        orderType = 'PREPARING';
        break;
    }
    return orderType;
  }

  static String getCategoryName(MainCategory type) {
    String categoryType = 'MEN';

    switch (type) {
      case MainCategory.MEN:
        categoryType = 'MEN';
        break;

      case MainCategory.WOMEN:
        categoryType = 'WOMEN';
        break;

      case MainCategory.KIDS:
        categoryType = 'KIDS';
        break;

      case MainCategory.ACCESSORIES:
        categoryType = 'ACCESSORIES';
        break;
    }
    return categoryType;
  }

  static int setMessageType(MessageType messageType) {
    switch (messageType) {
      case MessageType.TEXT:
        return MessageType.TEXT.index;
        break;
      case MessageType.IMAGE:
        return MessageType.IMAGE.index;
        break;
      case MessageType.EMOJI:
        return MessageType.EMOJI.index;
        break;
      case MessageType.OFFER:
        return MessageType.OFFER.index;
        break;
      case MessageType.REVIEW:
        return MessageType.REVIEW.index;
        break;

      default:
        return MessageType.TEXT.index;
    }
  }

  static MessageType getMessageType(int i) {
    switch (i) {
      case 0:
        return MessageType.TEXT;
        break;
      case 1:
        return MessageType.IMAGE;
        break;
      case 2:
        return MessageType.EMOJI;
        break;
      case 3:
        return MessageType.OFFER;
        break;
      case 4:
        return MessageType.REVIEW;
        break;

      case 5:
        return MessageType.APPROVED;
        break;

      default:
        return MessageType.TEXT;
        break;
    }
  }

  static MainCategory getCategoryByEnum(String type) {
    MainCategory categoryType = MainCategory.MEN;

    switch (type) {
      case "MEN":
        categoryType = MainCategory.MEN;
        break;

      case "WOMEN":
        categoryType = MainCategory.WOMEN;
        break;

      case "KIDS":
        categoryType = MainCategory.KIDS;
        break;

      case "ACCESSORIES":
        categoryType = MainCategory.ACCESSORIES;
        break;
    }
    return categoryType;
  }

  static String getPrice(dynamic i) {
    return i != null ? i.toString() : "";
  }

  static DateTime getDateTimeFromEpochUs(int us) =>
      DateTime.fromMillisecondsSinceEpoch(us ?? 0);

  static getGroupChatId(String id, String peerId) {
    String _tempId;
    if (id.hashCode <= peerId.hashCode) {
      _tempId = '$id-$peerId';
    } else {
      _tempId = '$peerId-$id';
    }
    return _tempId;
  }

  /// display time like whatsapp app
  static getMessageTime(DateTime tm) {
    DateTime today = DateTime.now();
    Duration oneDay = Duration(days: 1);
    Duration twoDay = Duration(days: 2);
    Duration difference = today.difference(tm);

    if (difference.compareTo(oneDay) < 1) {
      DateFormat formatter = new DateFormat('HH:mm');
      String formatted = formatter.format(today);
      return formatted;
    } else if (difference.compareTo(twoDay) < 1) {
      return "yesterday";
    } else {
      DateFormat formatter = new DateFormat('dd/MM/yyyy');
      String formatted = formatter.format(today);
      return formatted;
    }
  }

  static getProductColor(String color) {
    if (color.toUpperCase() == 'PRIMARY')
      return primaryColor;
    else if (color.toUpperCase() == 'GREY')
      return awLightColor;
    else
      return Colors.white;
  }

  static getCreditCard(String cardType) {
    if (cardType == CardType.visa)
      return Assets.visa;
    else if (cardType == CardType.masterCard)
      return Assets.masterCard;
    else if (cardType == CardType.americanExpress)
      return Assets.americanExpress;
    else
      return Assets.visa;
  }

  static launchURL(String url) async {
    if (url.isEmpty) return;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //Show Dialog to force user to update
  static Future<String> showAppUpdateDialog(
      context, RemoteConfig remoteConfig) async {
    bool forceUpdate = remoteConfig.getBool('force_app_update');
    return await showDialog<String>(
      context: context,
      barrierDismissible: !forceUpdate,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of app available please update it now.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: forceUpdate
                    ? <Widget>[
                        FlatButton(
                          child: Text(btnLabel),
                          onPressed: () => launchURL(
                              remoteConfig.getString('ios_appstore_url')),
                        )
                      ]
                    : <Widget>[
                        FlatButton(
                          child: Text(btnLabel),
                          onPressed: () => launchURL(
                              remoteConfig.getString('ios_appstore_url')),
                        ),
                        FlatButton(
                          child: Text(btnLabelCancel),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
              )
            : AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: forceUpdate
                    ? <Widget>[
                        FlatButton(
                          child: Text(btnLabel),
                          onPressed: () => launchURL(
                              remoteConfig.getString('android_playstore_url')),
                        )
                      ]
                    : <Widget>[
                        FlatButton(
                          child: Text(btnLabel),
                          onPressed: () => launchURL(
                              remoteConfig.getString('android_playstore_url')),
                        ),
                        FlatButton(
                          child: Text(btnLabelCancel),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
              );
      },
    );
  }

  static String getInitials(String name) {
    if (name != null && name != "") {
      final names = name?.split(" ");
      if (names != null && name.length > 0) {
        var initials = names[0]?.substring(0, 1);
        if (names.length > 1) initials += names[1]?.substring(0, 1);
        return initials.toUpperCase();
      }
      print(name);
      return name?.substring(0, 1);
    }
    return "NA";
  }

  static String capitalizeFirstLetter(String word) {
    if (word == null || word.isEmpty) return "";

    return '${word.substring(0, 1).toUpperCase()}'
        '${word.substring(1).toLowerCase()}';
  }

  static List<dynamic> uniqueList(List<dynamic> list) {
    print(list);
    List<dynamic> newList = List<dynamic>();
    list.forEach((l) {
      if (!newList.contains(l)) {
        newList.add(l);
      }
    });
    print(newList);
    return newList;
  }

  static ProductColor getColor(String colorName) {
    ProductColor color =
        ProductColor(colorName, AppData.DEFAULT_PRODUCT_COLORS_MAP[colorName]);
    print(color.colorCode);
    return color;
  }

  static List<ProductColor> getListWithProductColor(List<dynamic> list) {
    List<ProductColor> newList = List<ProductColor>();
    list.forEach((c) {
      var productColor = Utils.getColor(c);
      if (productColor.colorCode != null)
        newList.add(productColor );
    });
    return newList;
  }

  static Future<void> showEmailVerificationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AwosheAlertDialog(
          title: Text(
            "Oops!",
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Your email is not verified yet. Please verify your email or contact Awoshe support.",
                style: textStyle,
                textAlign: TextAlign.center,
              )
            ],
          ),
          hasWarning: true,
          onCancel: () => Navigator.of(context).pop(),
          onConfirm: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
    return null;
  }

  static Future<void> showAlertMessage(BuildContext context,
      {String title,
        String message,
        Function onConfirm,
        Function onCancel,
        String confirmText = 'Sign in',
        bool warning = true}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AwosheAlertDialog(
          confirmText: confirmText,
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                message,
                style: textStyle,
                textAlign: TextAlign.center,
              )
            ],
          ),
          hasWarning: warning,
          onCancel: onCancel ?? () => Navigator.of(context).pop(),
          onConfirm: onConfirm ?? () {
            Navigator.of(context).pop();
          },
        );
      },
    );
    return null;
  }
}
