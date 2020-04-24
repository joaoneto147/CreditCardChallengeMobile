import 'package:credit_car_challenge/commons/token_api.dart';

class User {
  String fullName;
  String id;
  String userName;
  String email;
  String passwordHash;
  Token autenticationToken;

  User(
      {this.fullName,
      this.id,
      this.userName,
      this.email,
      this.passwordHash});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(    
      fullName : json['fullName'],
      id : json['id'],
      userName : json['userName'],
      email : json['email'],
      passwordHash : json['passwordHash']      
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['passwordHash'] = this.passwordHash;
    return data;
  }

  static Map<String, dynamic> getJsonSingin(String name, String email, String password, String confirmationPassword) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = name;
    data['email'] = email;
    data['senha'] = password;
    data['confirmacaosenha'] = confirmationPassword;    
    return data;
  }
}