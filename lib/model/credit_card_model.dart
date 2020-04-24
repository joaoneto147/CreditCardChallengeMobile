import 'package:credit_car_challenge/commons/conts/functions.dart';
import 'package:credit_car_challenge/model/purchase_model.dart';

class CreditCard {
  int id;
  String number;
  String holder;
  int securityCode;
  String flag;
  double limit;
  List<Purchase> purchases;
  String userId;

  CreditCard(
      {this.id,
      this.number,
      this.holder,
      this.securityCode,
      this.flag,
      this.limit,
      this.purchases,
      this.userId});

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      id : json['id'],
      number : formatterCreditCardNumber(json['number']),
      holder : json['holder'],
      securityCode : json['securityCode'],
      flag : json['flag'],
      limit : json['limit'] as double,
      userId : json['userId'],
    );    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();    
    data['number'] = this.number;
    data['holder'] = this.holder;
    data['securityCode'] = this.securityCode;
    data['flag'] = this.flag;
    data['limit'] = this.limit;
    data['userId'] = this.userId;
    return data;
  }
}
