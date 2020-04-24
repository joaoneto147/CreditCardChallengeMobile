class Token {
  String token;
  String expiration;
  String messageLogin;

  Token({this.token, this.expiration});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expiration = json['expiration'];
    messageLogin = json['messageLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expiration'] = this.expiration;
    data['messageLogin'] =this.messageLogin;
    return data;
  }
}