//const SENTRY_DSN = "https://8f9456e9bfb94c088adbfb05785a0f50@sentry.io/1263909"; /// Vijay
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
/// TODO - While Go Live set this to false - Need to add this variable to task list to set everytime when we go live
const SENTRY_DSN = 'https://6d7eb92ff85145939007bd4a48299b4a@sentry.io/1269131';
const PROD_MODE = true;
const bool DEVELOPMENT_MODE = false;

const String CURRENCY_HOST = 'free.currconv.com';
const String CURRENCY_API = '/api/v7/convert';
const String CURRENCY_API_KEY = 'd1f700e67b5fa179bc82';

const IPAY_TEST_MERCHANT_ID = 'tk_3a615b1c-7a69-11e9-b0f5-f23c9170642f';
const IPAY_LIVE_KEY = '3a614c94-7a69-11e9-b0f5-f23c9170642f';
const IPAY_KEY = PROD_MODE ? IPAY_LIVE_KEY : IPAY_TEST_MERCHANT_ID;

const PAYSTRIPE_TEST_KEY = PROD_MODE ? 'pk_live_6lI6bqUviRSN2m7Xp9TiQgPf00AmtAPZ4I' : 'pk_test_rbHAtG5BP0FyGG8wsA4DO15K00cSccaQQD';

const String BASE_URL = 'https://us-central1-awoshe-v2.cloudfunctions.net/restapi/v1';
const String PROD_BASE_URL = 'https://us-central1-awoshe-live.cloudfunctions.net/restapi/v1';
const String HOST_LOCAL = '192.168.0.101:5000';

//https://us-central1-awoshe-v2.cloudfunctions.net/restapi/v1
//https://us-central1-awoshe-v2.cloudfunctions.net/restapi/v1/product/lJfWYF1OAK1gZ5RVm2vk
const String HOST = PROD_MODE ? 'us-central1-awoshe-live.cloudfunctions.net' : 'us-central1-awoshe-v2.cloudfunctions.net';
const String HOST_TARGET = '/restapi/v1/';
const String HOST_LOCAL_TARGET = '/awoshe-v2/us-central1/restapi/v1/';

// us-central1-awoshe-v2.cloudfunctions.net
/// PAYSTACK PAYMENT INFORMATION
const PAYSTACK_PUBLIC_KEY_LIVE = 'pk_live_d1ac29bc2a65a6fd4704fe4301f95faa5d9f9475';

const PAYSTACK_SECRET_KEY_TEST = 'FLWSECK-1cbe93cc78c3880474ba05e325a9fb26-X';
const PAYSTACK_PUBLIC_KEY_TEST = 'pk_test_6ce774e9c0f7d1fa1a37e6a798f7042d650cd36a';
const PAYSTACK_BACKEND_URL_TEST = 'https://paystack-awoshe-test.herokuapp.com';

const PAYSTACK_SECRET_KEY_PROD = 'FLWSECK-1cbe93cc78c3880474ba05e325a9fb26-X';
const PAYSTACK_PUBLIC_KEY_PROD = 'pk_test_6ce774e9c0f7d1fa1a37e6a798f7042d650cd36a';
const PAYSTACK_BACKEND_URL_PROD = 'https://paystack-awoshe-test.herokuapp.com';

const FEED_THRESHOLD = 100;
const String TERMS_AND_CONDITION_URL = "https://awoshe.com/awoshe";
const String PRIVACY_POLICY = "https://awoshe.com/awoshe";

const AWOSHE_TERMS_URL = "https://awoshe.com/awoshe";
const AWOSHE_PRICING_URL = 'https://sankara.awoshe.com/pricing';

const HTTP_CLOUD_FUNCTIONS = {
  "ACTION_EMAIL_VERIFIED": "actions-auth-emailVerified"
};
const PROFILE_PLACEHOLDER = "https://via.placeholder.com/75x75";
const COVER_PLACEHOLDER = "https://via.placeholder.com/350x450";
const PLACEHOLDER_PROFILE_IMAGE = "http://i.pravatar.cc/300";
const PLACEHOLDER_DESIGN_IMAGE =
    'http://pluspng.com/img-png/dress-shirt-png-image-798.png';

// Define all the localstorage keys here
Map<String, String> localStorageKeys = {'CART_ID': 'CartId'};

const FIREBASE_DEV_CONFIG = FirebaseOptions(
    gcmSenderID: '30645609504',
    apiKey: 'AIzaSyAp5m5sBdrzAlzOnwyiKkw9EmgQmNyHsQg',
    projectID: 'awoshe-dcc63',
    googleAppID: '1:30645609504:ios:4567e85ce8a09c9e');

const APP_INPUT_RADIUS = 5.0;
enum UploadType { DESIGN, FABRIC, BLOG }
enum OrderType { STANDARD, CUSTOM, BOTH }
enum PhotoSourceType { GALLERY, CAMERA }
enum MessageType { TEXT, IMAGE, EMOJI, OFFER, REVIEW, APPROVED }
enum UploadMode { ADD, EDIT }
enum TabsPage { HOME, NOTIFICATION, UPLOAD, CART, PROFILE }
enum OrderStatus { PREPARING, SHIPPED, DELIVERED, IN_REVIEW, DONE}
enum PaymentMethod { CARD, BANK, PAYPAL, MOBILE_MONEY }
const List<List<String>> AVAILABLE_SIZES = [
  ["S", "M", "L", "XL", "XXL"],
  ["1", "2", "3", "4", "5"],
  ["S", "M", "L", "XL", "XXL"]
];
const List<String> DISPLAY_TYPE =  ["SINGLE", "THUMBNAIL", "SWIPER"];
const List<String> ORDER_STATUS = [
  "PREPARING",
  "SHIPPED",
  "DELIVERED",
  "IN_REVIEW",
  "DONE"
];

/// Maintain this both enums together
enum MainCategory { MEN, WOMEN, KIDS, ACCESSORIES }
const MAIN_CATEGORIES = ["MEN", "WOMEN", "KIDS", "ACCESSORIES"];
enum SearchType { DESIGNER, MEN, WOMEN, KIDS, ACCESSORIES, GIRLS, HOME, ALL }
enum SubCategory {
  ALL,
  SHIRTS,
  TSHIRTS,
  PULLOVERS,
  CASUAL_SHIRT,
  TROUSERS,
  JACKETS,
  SHOES,
  SHORTS,
  DRESS_SHIRT
}
const List<String> SUB_CATEGORIES = [
  "All",
  "Shirts",
  "Tshirts",
  "Pullover",
  "Casual Shirt",
  "Trouser",
  "Jackets",
  "Shoes",
  "Shorts",
  "Dress Shirt"
];

const ASPECT_RATIO_PORTRAIT = 3/4;
const ASPECT_RATIO_LANDSCAPE = 4/3;

const Map<String, String> PLATFORM = {
  "android": "android",
  "ios": "ios"
};
enum ProductType { DESIGN, FABRIC, BLOG }
enum FeedType {
  BLOG,
  TH,
  SW,
  SINGLE
}

const DEFAULT_CURRENCY = 'USD';

const List<String> CURRENCIES = [
  'USD', 'GHS', 'NGN', 'CHF', 'EUR', 
];

const DESIGNER_CURRENCIES =  <String>[
  'GHS', 'NGN', 'USD'
];

const Map<String, String> CURRENCY_SYMBOLS = {
  'GHS': 'GH₵',
  'USD': '\$',
  'NGN': '₦'
};

const List<String> DISTANCE_UNITS = [
  '/Yard',
  '/Meter'
];

enum CheckoutStatus { NONE, DOING, COMPLETE, ERROR }

/// Invoice states that comes from iPay platform
/// 
enum InvoiceState {
  /// Invoice is currently awaiting payment by buyer
  AWAITING_PAYMENT,

  /// Buyer cancelled the invoice by clicking on the cancel button. 
  /// No further action expected
  CANCELLED, 

  /// An invoice normal expires if it is not paid within 24 hours of being created. 
  /// iPay will not accept payments for expired invoices
  EXPIRED, 

  /// Invoice has been paid. 
  /// Seller can proceed with rendering of service or delivery of goods
  PAID
}

/// The duration of the cache in disk. 72h.
const Duration CACHE_DURATION = Duration(days: 5);

/// The max objects number to be cached
const MAX_CACHE_OBJECTS = 500;

/// The image cache rule
const CacheRule IMAGE_CACHE_RULE = CacheRule(
  maxAge: CACHE_DURATION,
  storeDirectory: StoreDirectoryType.document,
);