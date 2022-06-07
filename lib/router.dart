import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/pages/login/forgot_password.dart';
import 'package:Awoshe/pages/message/message.page.dart';
import 'package:Awoshe/pages/product/product.customize.order.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:Awoshe/pages/product/product.photos.gallery.dart';
import 'package:Awoshe/pages/product/product.standard.order.dart';
import 'package:Awoshe/pages/registration/registration.page.dart';
import 'package:Awoshe/pages/welcome/welcome.page.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/pages/tabs/tabs.dart';
import 'package:Awoshe/pages/verify_email/verify_email.page.dart';
import 'package:Awoshe/pages/login/login.page.dart';
import 'package:fluro/fluro.dart';
import 'package:Awoshe/pages/profile/followers/followers.page.dart';
import 'package:Awoshe/widgets/not_found.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';

import 'pages/promotion/promotion.page.dart';

final GlobalKey tabsState = GlobalKey<AwosheTabBarState>();

class Routes {
  static String login = "/login";
  static String signup = "/signup";
  static String home = "/home";
  static String onboarding = "/onboarding";
  static String verifyEmail = "verify_email";
  static String followers = "/followers";
  static String root = "/";
  static String noRoute = "/noRoute";
  static String standardorder = "/standardorder";
  static String customorder = "/customorder";
  static String productphotos = "/productphotos";
  static String product = "/product";
  static String women = "/women";
  static String message = "/message";
  static String termAndCondition = "/terms_and_condition";
  static String privacyPolicy = "/privacyPolicy";
  static String forgotPassword = "/forgotPassword";
  static String promotion = '/promotion';
  static String welcome = '/welcome';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: Text("Coming soon..."),
              content: Text("Page you are looking for is under development"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                FlatButton(
                  child: Text("OK. GOT IT"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      AppRouter.pageNotFoundAlert(context);
      return Container();
    });

    var rootHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new AwosheTabBar(
        currrentPage: TabsPage.HOME
      );
    });

    var homeHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new AwosheTabBar(
        currrentPage: TabsPage.HOME
      );
    });

    var loginHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new LoginPage();
    });

    var signupHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new RegistrationPage();
    });

    var verifyEmailHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new VerifyEmailPage();
    });

    var followerHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new FollowersPage();
    });

    var noRouteHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new PageNotFound();
    });

    var productphotosHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new ProductPhotos();
    });
    var standardorderHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new StandardOrder();
    });

    var customorderHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new CustomOrder();
    });

    var productHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new ProductPage();
    });

    Handler welcomeHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          return  WelcomePage();
        });

    Handler forgotPasswordHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          return ForgotPasswordPage();
        });


    Handler messageHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          UserStore userStore = Provider.of<UserStore>(context);
      return  MessagePage(userStore: userStore);
    });

    Handler termsAndCondHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          return WebviewScaffold(
            url: TERMS_AND_CONDITION_URL,
            appBar: AppBar(
              title: Text("Terms & Conditions"),
            ),
          );
        });

    Handler privacyPolicyHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          return WebviewScaffold(
            url: PRIVACY_POLICY,
            appBar: AppBar(
              title: Text("Privacy Policy"),
            ),
          );
        });

    Handler promotionHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          return PromotionPage();
        });

    router.define(root, handler: rootHandler);
    router.define(home, handler: homeHandler);
    router.define(login, handler: loginHandler);
    router.define(signup, handler: signupHandler);
    router.define(verifyEmail, handler: verifyEmailHandler);
    router.define(followers, handler: followerHandler);
    router.define(noRoute, handler: noRouteHandler);
    router.define(product, handler: productHandler);
    router.define(standardorder, handler: standardorderHandler);
    router.define(customorder, handler: customorderHandler);
    router.define(productphotos, handler: productphotosHandler);
    router.define(message, handler: messageHandler);
    router.define(termAndCondition, handler: termsAndCondHandler);
    router.define(privacyPolicy, handler: privacyPolicyHandler);
    router.define(forgotPassword, handler: forgotPasswordHandler);
    router.define(promotion, handler: promotionHandler);
    router.define(welcome, handler: welcomeHandler);
  }
}

class AppRouter {
  static Router router;
  static String landingRouteName = Routes.login;
  static Widget initialPage;

  static pageNotFoundAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("Coming soon..."),
            content: Text("Page you are looking for is under development"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: Text("OK. GOT IT"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
