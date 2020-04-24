import 'dart:convert';

import 'package:credit_car_challenge/commons/api.dart';
import 'package:credit_car_challenge/commons/conts/end_point_map_const.dart';
import 'package:credit_car_challenge/model/credit_card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CreditCardController extends ChangeNotifier {
  var _api = Api();
  String responseAddCreditCard;

  Future<List<CreditCard>> getCreditCards() async {
    List<CreditCard> creditCards;
    http.Response response = await _api.sendGetRequest(API_CREDIT_CARD, "");

    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);
      creditCards = dadosJson["creditCards"].map<CreditCard>((map) {
        return CreditCard.fromJson(map);
      }).toList();
    }

    return creditCards;
  }

  Future addCreditCard(CreditCard newcreditCard) async {    
    responseAddCreditCard = "";
    newcreditCard.userId = "e40bed72-9568-4532-a188-5fa5d50d3315";//GetIt.instance<UserController>().loggedUser.id;
    http.Response response = await _api.sendPostRequest(API_CREDIT_CARD, newcreditCard.toJson());

    if (response.statusCode == 201){
      responseAddCreditCard = "Added successfully!";
      Map<String, dynamic> dadosJson = json.decode(response.body);     
      return CreditCard.fromJson(dadosJson);      
    } else {
      responseAddCreditCard = "It was not possible to add the card! Try again.";
      return null;
    }
  }
}
