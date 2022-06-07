class EndPoints {
  static const String USER_REGISTER = 'user/register';
  static const String PRODUCT = 'product';
  static const String PRODUCT_ID = 'product/{0}';
  static const String PRODUCT_FAVOURITE = PRODUCT_ID + '/favourite';
  static const String PRODUCT_TYPE = '$PRODUCT/productByType/{0}';
  static const String COLLECTION = "user/collection";
  static const String FOLLOW_USER = 'user/following';
  static const String SAVE_PROFILE = 'user';
  static const String USER = 'user';
  static const String USER_PRESENCE = 'user/online';
  static const String USER_FOLLOWING = 'user/{0}/following';
  static const String USER_FOLLOWER = 'user/{0}/follower';
  static const String USER_EXIST = 'user/exists';
  static const String USER_PROFILE = 'user/{0}/profile';
  static const String MY_PROFILE = 'user/profile';
  static const String USER_NOTIFICATION = 'user/notification';
  static const String USER_FEEDBACK = 'user/feedback';
  static const String USER_DESIGNS = 'user/{0}/designs';
  static const String USER_FAVOURITES = 'user/{0}/favourites';
  static const String CONTACT = 'user/{0}/contact';
  static const String CART = "cart";
  static const String CART_CLEAR = '$CART/clear';
  static const String BLOG = "blog";
  static const String BLOG_ID = '$BLOG/{0}';
  static const String ORDER = 'order';
  static const String ORDER_ID = '$ORDER/{0}';
  static const String ORDER_STRIPE_PAYMENT_INTENT = '$ORDER/stripe/getPaymentIntent';
  static const String FEEDS = 'feeds';
  static const String BANNER_FEEDS = 'feeds/banner';
  static const String MESSAGE = 'message';
  static const String MESSAGE_RESET_COUNT = 'user/message/viewed';
  static const String NOTIFICATION_ACTION = 'user/notification/{0}/action/{1}';
  static const String SUBMIT_REVIEW = 'user/submitReview/{0}';
  //productId/userId
  static const String REVIEW_TEMPLATE = 'user/sendReviewTemplate/{0}/{1}';

  static const String OFFER_REQUEST = 'user/requestOffer/{0}';
  static const String OFFER_APPROVE = 'user/approveOffer/{0}';

  /// user/requestOffer/offerId/designerId
  static const String OFFER_DETAILS_REQUEST = 'user/requestOffer/{0}/{1}';

  /// user/requestOffer/offerId/designerId
  static const String OFFER_DETAILS_APPROVE = 'user/approveOffer/{0}/{1}';

  static const String MISCELLANEOUS = 'miscellaneous';

  static const String SUBSCRIPTION_PLANS = '$MISCELLANEOUS/plans';

  static const String SUBSCRIBE_CHECKOUT = 'user/payment';

  static const String PRODUCT_BY_OCCASION = 'product/productByOccassion/{0}';
}
