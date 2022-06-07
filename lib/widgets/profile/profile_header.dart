import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/components/ClickableFilledStackArea.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  final OnTap onCoverTap;
  final OnTap onProfilePictureTap;
  static UserStore userStore;
  final ProfileStore profileStore;
  static UserDetails userInfo;
  // profile circle picture avatar radius
  final radius = 60.0;
  final heightFactor = 4;
  final offset = 1.2;
  final borderPadding = 2.0;
  final hPadding = 16.0;


  ProfileHeader({this.onCoverTap, this.onProfilePictureTap, this.profileStore});

  // while is loading cover image shows a container with
  // AwosheDotLoading
  Widget coverImageContainer(width, height) => Container(
    width: width,
    decoration: BoxDecoration(
      color: Colors.transparent,
    ),
    height: (height / heightFactor) + radius,
    child: Stack(
      overflow: Overflow.visible,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Stack(
            children: <Widget>[
              Container(
                width: width,
                height: (height / heightFactor),
                child: Center(
                  child: AwosheDotLoading(),
                ),
              ),
              // cover picture container
              if (userInfo?.coverUrl == "" || userInfo?.coverUrl == null)
                Container(
                  width: width,
                  height: (height / heightFactor),
                  decoration: BoxDecoration(color: awBlack),
                ),

              if (userInfo?.coverUrl != "" && userInfo?.coverUrl != null)
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    width: width,
                    height: (height / heightFactor),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AdvancedNetworkImage(
                          userInfo?.coverUrl,
                          useDiskCache: true,
                          cacheRule: IMAGE_CACHE_RULE,
                        ),
                      ),
                    ),
                  ),
                ),
              ClickableFilledStackArea(
                onTap: onCoverTap,
              ),
            ],
          ),
        ),
        Positioned(
          top: (height / heightFactor) - radius,
          child: Container(
            child: AnimatedSwitcher(
              duration: Duration(seconds: 500),
              child: GestureDetector(
                onTap: onProfilePictureTap,
                child: Container(
                  child: userInfo.pictureUrl != "" && userInfo.pictureUrl != null
                      ? CircleAvatar(
                    radius: radius,
                    backgroundImage:
                    AdvancedNetworkImage(
                      userInfo.pictureUrl,
                      cacheRule: IMAGE_CACHE_RULE,
                      useDiskCache: true,                  
                    ),
                  )
                      : _getInitialWidget(userInfo.name, radius),
                  decoration: new BoxDecoration(
                    color: Colors.white, // border color
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(borderPadding),
                ),
              ),
            ),
            decoration: new BoxDecoration(
              color: Colors.transparent, // border color
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    ),
  );

  Widget userNameLabelRow(width, height) => Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: hPadding),
    child: Center(
      child: Text(
        '${StringUtils.capitalize(userInfo?.name)}',
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 18.0),
      ),
    ),
  );

  Widget locationLabelRow(width, height) => Container(
    width: width,
    alignment: Alignment.center,
    margin: EdgeInsets.only(top: 8.0),
    padding: EdgeInsets.symmetric(horizontal: hPadding),
    child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.location_on,
            color: Colors.grey,
          ),
          SizedBox(
            width: 4.0,
          ),
          Text(
            userInfo?.location != "" && userInfo?.location != null ? '${StringUtils.capitalize(userInfo?.location)}' : 'City, Country',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Observer(
      name: 'profile_header',
      builder: (context) {
        userStore = Provider.of<UserStore>(context, listen: false);
        userInfo = profileStore.userDetails;
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            coverImageContainer(width, height),
            SizedBox(
              height: (offset * 10),
            ),
            userNameLabelRow(width, height),
            locationLabelRow(width, height),
          ],
        );
      },
    );
  }

  Widget _getInitialWidget(String fullName, double radius) => CircleAvatar(
        radius: radius,
        child: Center(
          child: Text(Utils.getInitials(fullName),
              style: lightBoldText.merge(TextStyle(fontSize: 45))),
        ),
        backgroundColor: secondaryColor,
      );
} // end of layout
