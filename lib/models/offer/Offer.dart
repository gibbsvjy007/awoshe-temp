import 'package:Awoshe/models/creator/creator.dart';
import 'package:Awoshe/utils/DateUtils.dart';
import 'package:json_annotation/json_annotation.dart';


part 'Offer.g.dart';

@JsonSerializable()
class Offer {

  @JsonKey(
    ignore: true
  )
  static Offer TEST = Offer(
    measurement: true,
    fabric: false,
    comment: 'Offer comments',
    deliveryDate: DateTime.now(),
    price: '12.85',

  );

  @JsonKey(includeIfNull: false)
  String id;

  @JsonKey(
    toJson: DateUtils.formatDateToString,
    fromJson: DateUtils.formatStringToDate,
  )
  DateTime deliveryDate;
  bool measurement;
  bool fabric;
  String comment;

  @JsonKey(includeIfNull: false)
  String price;

  @JsonKey(includeIfNull: false)
  Creator requestedBy;

  @JsonKey(includeIfNull: false)
  Creator approvedBy;

  @JsonKey(includeIfNull: false)
  String productName;

  @JsonKey(includeIfNull: false)
  String productImageUrl;

  Offer({this.id, this.deliveryDate,
    this.measurement,this.fabric,
    this.productName, this.productImageUrl,
    this.comment, this.price, this.approvedBy, this.requestedBy});

  Map<String, dynamic> toJson() =>
      _$OfferToJson(this);

  factory Offer.fromJson(Map<String, dynamic> json) =>
      _$OfferFromJson(json);

}