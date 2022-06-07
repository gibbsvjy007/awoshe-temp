import 'package:meta/meta.dart';

class Payment {
  String referenceId;
  int paymentMethod;

  Payment({this.referenceId, this.paymentMethod});

  Payment.fromJson(Map<String, dynamic> json)
      : referenceId = json != null ? json['referenceId'] : "",
        paymentMethod = json != null ? json['paymentMethod'] : 0;

  Map<String, dynamic> toJson() =>
      {'referenceId': referenceId, 'paymentMethod': paymentMethod};
}

class CreditCard {
  String name;
  String number;
  String cvc;
  int expiryMonth = 0;
  int expiryYear = 0;
  String type;

  CreditCard(
      {@required this.number,
      @required this.cvc,
      @required this.expiryMonth,
      @required this.expiryYear,
      this.name,
      this.type});

  CreditCard.fromJson(Map<String, dynamic> json)
      : number = json != null ? json['number'] : "",
        cvc = json != null ? json['cvc'] : '',
        expiryMonth = json != null ? json['expiryMonth'] : 0,
        expiryYear = json != null ? json['expiryYear'] : 0,
        name = json != null ? json['name'] : "",
        type = json != null ? json['type'] : "";

  Map<String, dynamic> toJson() => {
        'number': number,
        'cvc': cvc,
        'expiryMonth': expiryMonth,
        'expiryYear': expiryYear,
        'name': name,
        'type': type
      };
}

class CardType {
  // Card types
  static const String visa = "Visa";
  static const String masterCard = "MasterCard";
  static const String americanExpress = "American Express";
  static const String dinersClub = "Diners Club";
  static const String discover = "Discover";
  static const String jcb = "JCB";
  static const String verve = "VERVE";
  static const String unknown = "Unknown";
}
