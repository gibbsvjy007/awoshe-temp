import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

enum AddressType { SHIPPING, BILLING }

@JsonSerializable()
class Address {
  String fullName;
  String street;
  String city;
  String state;
  String zipCode;
  String country;
  int type;
  bool isDefault;

  Address(
      {this.fullName = "",
      this.street = "",
      this.city = "",
      this.state = "",
      this.zipCode = "",
      this.country = "",
      this.type = 0,
      this.isDefault = false});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
