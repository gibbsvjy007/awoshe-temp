import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/models/favourite/favourite.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/utils/assets.dart';

import '../constants.dart';

class FavouriteTile extends StatelessWidget {
  final Favourite favourite;
  final ProfileStore profileStore;
  final int index;
  final VoidCallback onTap;
  static const String REMOVE = 'Remove';
  static const List<String> moreOptions = <String>[REMOVE];

  FavouriteTile({this.favourite, this.profileStore, this.index, this.onTap});

  void choiceAction(String choice) {
    if (choice == REMOVE) {
      print('Remove favourite');
      profileStore.deleteFavourite(id: favourite.id, index: index);
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery
        .of(context)
        .size;

    return Container(
          margin: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[

                      // The product image
                      CachedNetworkImage(
                        errorWidget: (context, url, error) =>
                            Material(
                              child: Image.asset(
                                Assets.imgNotAvailable,
                                width: deviceSize.width * 0.5 - 5,
                                height: deviceSize.height * 0.2,
                                fit: BoxFit.fitWidth,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(2.0),
                              ),
                              clipBehavior: Clip.hardEdge,
                            ),
                        imageUrl: favourite.imageUrl ?? PLACEHOLDER_DESIGN_IMAGE,
                        width: deviceSize.width * 0.5 - 5,
                        height: deviceSize.height * 0.2,
                        fit: BoxFit.fitWidth,
                      ),

                      // the product title
                      Container(
                        padding: EdgeInsets.only(top: 5.0, left: 5.0),
                        width: deviceSize.width * 0.5 - 16,
                        child: Tooltip(
                          message: favourite.title,
                          child: Text(
                            favourite.title,
                            style: boldText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),

                    ],
                  ),

                  Positioned.fill( child: GestureDetector(onTap: onTap,)),
                ],
              ),

              Container(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 15.0),
                            Text(favourite.itemId, style: textStyle12light),
                            SizedBox(height: 10.0),
                            Text(
                              '${favourite.currency} ${favourite.price}',
                              style: boldText,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),

                        Flexible(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 25.0,
                                child: IconButton(
                                    iconSize: 18.0,
                                    icon: Icon(Icons.favorite, color: Colors.red),
                                    onPressed: () {}),
                              ),
                              Container(
                                height: 25.0,
                                child: PopupMenuButton<String>(
                                  offset: Offset(0.0, 36.0),
                                  onSelected: choiceAction,
                                  icon: Icon(
                                    Icons.more_horiz,
                                    color: secondaryColor,
                                  ),
                                  elevation: 0.5,
                                  itemBuilder: (BuildContext context) {
                                    return moreOptions.map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),

    );
  }
}
