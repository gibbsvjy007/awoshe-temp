import 'package:Awoshe/constants.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

enum _LinkType {PRODUCT, PROFILE}

class DynamicLinkUtils {

  static final  Map<_LinkType, String> uriPrefixMap ={
    _LinkType.PRODUCT : PROD_MODE ? "https://awoshe.page.link" : "https://productlink.page.link",
    _LinkType.PROFILE : PROD_MODE ? "https://awoshe.page.link" : "https://productlink.page.link",
  };

  static final Map<_LinkType, String> linkMap = {
    _LinkType.PRODUCT: 'https://awoshe.com/path={0}',
    _LinkType.PROFILE : 'https://awoshe.com/profile={0}',
  };

  static DynamicLinkParameters createProductLink(final String productId, final String title,
      final String description,
      final String imageUrl,
      String userId) {
    return _createLinkParams(_LinkType.PRODUCT, productId,
      title: title,
      imageUrl: imageUrl,
      description: description,
    );
  }

  static DynamicLinkParameters createProfileLink(final String designerId,
      {final String designerName, final String aboutDesigner,final String imageUrl}){

   return _createLinkParams(_LinkType.PROFILE, designerId,
        description: aboutDesigner, title: designerName, imageUrl: imageUrl
    );
  }

  static DynamicLinkParameters _createLinkParams(_LinkType type, String dataId, {final String title,final String description,final String imageUrl}){
    return DynamicLinkParameters(
      uriPrefix: uriPrefixMap[type],
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable,
      ),
      link: Uri.parse( StringUtils.format( linkMap[type], [dataId]) ),//'https://awoshe.com/path=$dataId' ),

      androidParameters: AndroidParameters(
        //fallbackUrl: playStore awoshe app link,
        packageName: PROD_MODE ? 'com.awoshe.mobile.live' : 'com.awoshe.mobile',
        minimumVersion: 0,
      ),

      iosParameters: IosParameters(
        //fallbackUrl: appStore awoshe app link,
        bundleId: PROD_MODE ? 'com.awoshe.mobile.live' : 'com.awoshe.mobile',
        minimumVersion: '1.0.0',
        //appStoreId: '1469098102',
      ),

      googleAnalyticsParameters: GoogleAnalyticsParameters(campaign: 'userId', medium: "Mobile App", source: 'userId'),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        description: description,
        imageUrl: Uri.parse(imageUrl),
      ),
    );
  }

  static Future<PendingDynamicLinkData> retrieveDynamicLink() {
    return FirebaseDynamicLinks
        .instance.getInitialLink();
  }

}
