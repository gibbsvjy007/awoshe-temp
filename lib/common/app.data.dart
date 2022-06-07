//import 'package:Awoshe/models/product.dart';
import 'package:Awoshe/models/product/product_color.dart';
import 'package:Awoshe/models/upload.dart';
import 'package:flutter/material.dart';

class AppData {
  static bool isDesigner = true;
  static bool isPromotionMode = false;
  static const String WEDDING = "Wedding";
  static const String DINNER = "Dinner";
  static const String CHURCH = "Church";
  static const String BEACH = "Beach";
  static const String OFFICE = "Office";
  static const String FUNERAL = "Funeral";
  static const String CASUAL_DAILY = "Casual/Daily";
  static const String PARTY = "Party";
  static const String ENTRY_OCCASIONS = "OCCASIONS";

  static const OCCASION_LIST = <String>[ WEDDING, DINNER,CHURCH, BEACH, OFFICE, FUNERAL,
    CASUAL_DAILY, PARTY, ];

  static const MEASUREMENT_LIST = <String>[
    "Shoulder", "Chest", "Waist tops", "Half length", "Top length",
    "Across back", "Wrist", "Waist pants", "Pelvic", "Thigh", "Knee",
    "Bar", "Trouser length", "Sleeve Round Size", "Sleeve length"
  ];

  static occasions() => <SelectableItem>[
        SelectableItem(title: WEDDING, isSelected: false),
        SelectableItem(title: DINNER, isSelected: false),
        SelectableItem(title: CHURCH, isSelected: false),
        SelectableItem(title: BEACH, isSelected: false),
        SelectableItem(title: OFFICE, isSelected: false),
        SelectableItem(title: FUNERAL, isSelected: false),
        SelectableItem(title: CASUAL_DAILY, isSelected: false),
        SelectableItem(title: PARTY, isSelected: false),
      ];

  static customMeasurements() => <SelectableItem>[
        SelectableItem(title: "Shoulder", isSelected: false),
        SelectableItem(title: "Chest", isSelected: false),
        SelectableItem(title: "Waist tops", isSelected: false),
        SelectableItem(title: "Half length", isSelected: false),
        SelectableItem(title: "Top length", isSelected: false),
        SelectableItem(title: "Across back", isSelected: false),
        SelectableItem(title: "Wrist", isSelected: false),
        SelectableItem(title: "Waist pants", isSelected: false),
        SelectableItem(title: "Pelvic", isSelected: false),
        SelectableItem(title: "Thigh", isSelected: false),
        SelectableItem(title: "Knee", isSelected: false),
        SelectableItem(title: "Bar", isSelected: false),
        SelectableItem(title: "Trouser length", isSelected: false),
        SelectableItem(title: "Sleeve Round Size", isSelected: false),
        SelectableItem(title: "Sleeve length", isSelected: false),
      ];

  /// all the static colors of the fabric goes here
  static const Color WHITE = Color.fromRGBO(255, 255, 255, 1.0);
  static const Color OFF_WHITE = Color.fromRGBO(255, 251, 208, 1);
  static const Color BEIGE = Color.fromRGBO(255, 236, 182, 1);
  static const Color TAUPE = Color.fromRGBO(232, 210, 167, 1);
  static const Color BROWN = Color.fromRGBO(101, 75, 47, 1);
  static const Color TURQUOISE = Color.fromRGBO(0, 150, 147, 1);
  static const Color POOL_BLUE = Color.fromRGBO(67, 114, 119, 1);
  static const Color PURPLE = Color.fromRGBO(64, 44, 88, 1);

  static const Color LIGHT_RED = Color.fromRGBO(251, 196, 180, 1);
  static const Color LIGHT_ORANGE = Color.fromRGBO(254, 211, 166, 1);
  static const Color LIGHT_YELLOW = Color.fromRGBO(255, 227, 160, 1);
  static const Color LIGHT_GREEN = Color.fromRGBO(175, 198, 146, 1);
  static const Color LIGHT_TURQUOISE = Color.fromRGBO(130, 193, 190, 1);
  static const Color LIGHT_POOL_BLUE = Color.fromRGBO(144, 193, 196, 1);
  static const Color LIGHT_BLUE = Color.fromRGBO(149, 183, 204, 1);
  static const Color LIGHT_PURPLE = Color.fromRGBO(170, 183, 208, 1);

  static const Color DARK_RED = Color.fromRGBO(153, 22, 26, 1);
  static const Color DARK_ORANGE = Color.fromRGBO(183, 95, 29, 1);
  static const Color DARK_YELLOW = Color.fromRGBO(184, 143, 28, 1);
  static const Color DARK_GREEN = Color.fromRGBO(71, 94, 42, 1);
  static const Color DARK_TURQUOISE = Color.fromRGBO(0, 114, 111, 1);
  static const Color DARK_POOL_BLUE = Color.fromRGBO(47, 86, 89, 1);
  static const Color DARK_BLUE = Color.fromRGBO(0, 30, 69, 1);
  static const Color DARK_PURPLE = Color.fromRGBO(57, 23, 62, 1);

  static const Color GREY = Color.fromRGBO(169, 169, 169, 1.0);
  static const Color ORANGE = Color.fromRGBO(234, 132, 57, 1.0);
  static const Color GREEN = Color.fromRGBO(40, 180, 70, 1.0);
  static const Color BLACK = Color.fromRGBO(0, 0, 0, 1.0);
  static const Color YELLOW = Color.fromRGBO(254, 207, 17, 1.0);

  static List<ProductColor> getProductDefaultColors() => <ProductColor>[
        //ProductColor("Primary", Color.fromRGBO(234, 132, 57, 1.0)),
        ProductColor("Grey", GREY),
        ProductColor("Orange", ORANGE),
        ProductColor("Green", GREEN),
        ProductColor("Black", BLACK),
        ProductColor("Yellow", YELLOW),

        ProductColor("White", WHITE),
        ProductColor("Off-White", OFF_WHITE),
        ProductColor("Beige", BEIGE),
        ProductColor("Taupe", TAUPE),
        ProductColor("Brown", BROWN),
        ProductColor("Turquoise", TURQUOISE),
        ProductColor("PoolBlue", POOL_BLUE),
        ProductColor("Purple", PURPLE),
        ProductColor("LightRed", LIGHT_RED),
        ProductColor("LightOrange", LIGHT_ORANGE),
        ProductColor("LightYellow", LIGHT_YELLOW),
        ProductColor("LightGreen", LIGHT_GREEN),
        ProductColor("LightTurquoise", LIGHT_TURQUOISE),
        ProductColor("LightPoolBlue", LIGHT_POOL_BLUE),
        ProductColor("LightBlue", LIGHT_BLUE),
        ProductColor("LightPurple", LIGHT_POOL_BLUE),
        ProductColor("DarkRed", DARK_RED),
        ProductColor("DarkOrange", DARK_ORANGE),
        ProductColor("DarkYellow", DARK_YELLOW),
        ProductColor("DarkGreen", DARK_GREEN),
        ProductColor("DarkTurquoise", DARK_TURQUOISE),
        ProductColor("DarkPoolBlue", DARK_POOL_BLUE),
        ProductColor("DarkBlue", DARK_BLUE),
        ProductColor("DarkPurple", DARK_POOL_BLUE),
      ];

  static const Map<String, dynamic> DEFAULT_PRODUCT_COLORS_MAP = {
    "Grey": GREY,
    "Orange": ORANGE,
    "Green": GREEN,
    "Black": BLACK,
    "Yellow": YELLOW,
    "White": WHITE,
    "Off-White": OFF_WHITE,
    "Beige": BEIGE,
    "Taupe": TAUPE,
    "Brown": BROWN,
    "Turquoise": TURQUOISE,
    "PoolBlue": POOL_BLUE,
    "Purple": PURPLE,
    "LightRed": LIGHT_RED,
    "LightOrange": LIGHT_ORANGE,
    "LightYellow": LIGHT_YELLOW,
    "LightGreen": LIGHT_GREEN,
    "LightTurquoise": LIGHT_TURQUOISE,
    "LightPoolBlue": LIGHT_POOL_BLUE,
    "LightBlue": LIGHT_BLUE,
    "LightPurple": LIGHT_POOL_BLUE,
    "DarkRed": DARK_RED,
    "DarkOrange": DARK_ORANGE,
    "DarkYellow": DARK_YELLOW,
    "DarkGreen": DARK_GREEN,
    "DarkTurquoise": DARK_TURQUOISE,
    "DarkPoolBlue": DARK_POOL_BLUE,
    "DarkBlue": DARK_BLUE,
    "DarkPurple": DARK_POOL_BLUE
  };

//  hex="#000000">White</a>
//  hex="#fffbd0">Off-White</a>
//  hex="#ffecb6">Beige</a>
//  hex="#e8d2a7">Taupe</a>
//  hex="#654b2f">Brown</a>
//  hex="#000000">Black</a>
//  hex="#DF7427">Orange</a>
//  hex="#e0b42d">Yellow</a>
//  hex="#758441">Green</a>
//  hex="#009693">Turquoise</a>
//  hex="#437277">Pool Blue</a>
//  hex="#402c58">Purple</a>
//  hex="#fbc4b4">Light Red</a>
//  hex="#fed3a6">Light Orange</a>
//  hex="#ffe3a0">Light Yellow</a>
//  hex="#afc692">Light Green</a>
//  data-hex="#82c1be">Light Turquoise</a>
//  data-hex="#90c1c4">Light Pool Blue</a>
//  hex="#95b7cc">Light Blue</a>
//  hex="#aab7d0">Light Purple</a>
//  hex="#99161a">Dark Red</a>
//  hex="#B75F1D">Dark Orange</a>
//  hex="#b88f1c">Dark Yellow</a>
//  hex="#475e2a">Dark Green</a>
//  data-hex="#00726f">Dark Turquoise</a>
//  data-hex="#2f5659">Dark Pool Blue</a>
//  hex="#001e45">Dark Blue</a>
//  hex="#39173e">Dark Purple</a>
}
