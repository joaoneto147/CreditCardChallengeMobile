import 'dart:convert';
import 'package:credit_car_challenge/commons/api.dart';
import 'package:credit_car_challenge/commons/conts/end_point_map_const.dart';
import 'package:credit_car_challenge/model/purchase_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PurchasesController extends ChangeNotifier {
  var _api = Api();
  int _daysFilter = 1;
  int _creditCardId = -1;
  List<Purchase> purchases;

  int get daysFilter => _daysFilter;

  setDaysFilter(int days){
    if (days != _daysFilter){
      _daysFilter = days;
      _creditCardId != -1 ? getPurchases(_creditCardId) : notifyListeners();
    }
  }

  Future getPurchases(int creditCardId) async {
    _creditCardId = creditCardId;
    var paramters = List<String>();
    paramters.add("lastDays=$_daysFilter");
    paramters.add("creditCardId=$creditCardId");


    http.Response response =
        await _api.sendGetRequest(API_PURCHASE, _api.getQueryString(paramters));

    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);      
      purchases = dadosJson["result"].map<Purchase>(
        (map){ 
          return Purchase.fromJson(map);         
        }
      ).toList();      

      notifyListeners();
    }
  }
  
  Future addPurchase(Purchase purchase) async {
    
    http.Response response = await _api.sendPostRequest(API_PURCHASE, purchase.toJson());

    if (response.statusCode == 200){
      return true;
    }
  }

  // Future removePurchase(DateTime buyDate, String creditCardNumber) {}
}
