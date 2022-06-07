import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/awoshe_rating.dart';
import 'package:flutter/material.dart';

/// @author - Vijay Rathod
/// contains reviews of the product. this can be stateful widget as well if we are going to support load more
/// TODO - if user wants to read all the reviews then we have to handle the scenario for that.
/// we can create the new dialog page for it.

class ProductReviews extends StatelessWidget {

  final Product product;

  const ProductReviews({Key key, @required this.product}) : super(key: key);@override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 10.0),
      child: ExpansionTile(
        title: Text(""),
        leading: Text(
          "Reviews",
          style: TextStyle(
              color: awBlack, fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        initiallyExpanded: false,
        children: (product.totalReviews == null || product.totalReviews == 0) ?
            <Widget>[ Text('There is no reviews yet.') ]: getReviewComments(),
      ),
    );
  }

  List<Widget> getReviewComments() {
    return <Widget>[
      Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: <Widget>[
                AwosheStarRating(
                  starCount: 5,
                  rating: 4.5,
                  color: awYellowColor,
                  size: 15.0,
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[Container(child: Text("(14)"))],
          )
        ],
      ),
      Padding(padding: EdgeInsets.all(15.0)),
      Divider(
        height: 1.0,
      ),
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://www.awoshe.com/wp-content/uploads/2018/08/manslide.png"),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Vitali Adasi"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8.0),
                        child: AwosheStarRating(
                          starCount: 5,
                          size: 14.0,
                          color: awYellowColor,
                          rating: 5.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("13 Feb, 2018"),
                ),
              )
            ],
          )
        ],
      ),
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Text(
                  "Just like the picture and fits well. High quality and fast delivery. I will ordering again. Thanks!"),
            ),
          ),
        ],
      ),
      Padding(padding: EdgeInsets.all(15.0)),
      Divider(
        height: 1.0,
      ),
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://www.awoshe.com/wp-content/uploads/2018/08/manslide.png"),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Vitali Adasi"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      AwosheStarRating(
                        starCount: 5,
                        size: 14.0,
                        color: awYellowColor,
                        rating: 5.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("13 Feb, 2018"),
              )
            ],
          )
        ],
      ),
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Text(
                  "Just like the picture and fits well. High quality and fast delivery. I will ordering again. Thanks!"),
            ),
          ),
        ],
      ),
      Padding(padding: EdgeInsets.all(15.0)),
      Divider(
        height: 1.0,
      ),
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://www.awoshe.com/wp-content/uploads/2018/08/manslide.png"),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Vitali Adasi"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      AwosheStarRating(
                        starCount: 5,
                        size: 14.0,
                        color: awYellowColor,
                        rating: 5.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("13 Feb, 2018"),
              )
            ],
          )
        ],
      ),
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Text(
                  "Just like the picture and fits well. High quality and fast delivery. I will ordering again. Thanks!"),
            ),
          ),
        ],
      ),
      Padding(padding: EdgeInsets.all(15.0)),
      Divider(
        height: 1.0,
      ),
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://www.awoshe.com/wp-content/uploads/2018/08/manslide.png"),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Vitali Adasi"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      AwosheStarRating(
                        starCount: 5,
                        size: 14.0,
                        color: awYellowColor,
                        rating: 5.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("13 Feb, 2018"),
              )
            ],
          )
        ],
      ),
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Text(
                  "Just like the picture and fits well. High quality and fast delivery. I will ordering again. Thanks!"),
            ),
          ),
        ],
      ),
    ];
  }
}

