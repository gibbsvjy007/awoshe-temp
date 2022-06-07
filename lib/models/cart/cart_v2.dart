import 'package:Awoshe/models/cart/cart_item_v2.dart';
import 'package:Awoshe/models/creator/creator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_v2.g.dart';

@JsonSerializable(explicitToJson: true)
class CartV2 {

  String id;
  int createdOn;
  int updatedOn;
  Creator creator;
  @JsonKey(defaultValue: [])
  List<CartItemV2> items;

  factory CartV2.empty() {
    return CartV2(
        id: '',
        createdOn: DateTime.now().millisecondsSinceEpoch,
        updatedOn: DateTime.now().millisecondsSinceEpoch,
        items: []
    );
  }

  CartV2({this.id, this.createdOn, this.updatedOn, this.creator, this.items});

  factory CartV2.fromJson(Map<String,dynamic> json) =>
      _$CartV2FromJson(json);

  Map<String, dynamic> toJson() =>
      _$CartV2ToJson(this);
}