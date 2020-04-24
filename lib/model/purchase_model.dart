class Purchase {
  int id;
  String userId;
  String storeName;
  double value;
  String buyDate;
  int creditCardId;

  Purchase(
      {this.id,
      this.userId,
      this.storeName,
      this.value,
      this.buyDate,
      this.creditCardId});

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'],
      userId: json['userId'],
      storeName: json['storeName'],
      value: json['value'],
      buyDate: json['buyDate'],
      creditCardId: json['creditCardId']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['storeName'] = this.storeName;
    data['value'] = this.value;
    data['buyDate'] = this.buyDate;
    data['creditCardId'] = this.creditCardId;
    return data;
  }
}
