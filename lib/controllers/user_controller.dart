import 'dart:convert';

import 'package:credit_car_challenge/commons/api.dart';
import 'package:credit_car_challenge/commons/conts/end_point_map_const.dart';
import 'package:credit_car_challenge/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserController extends ChangeNotifier {
  User loggedUser;

  var _api = Api();
  bool _processing = false;
  String _msgLastRequest;

  String get msgCadastroUsuario => _msgLastRequest;
  bool get processingRegister => _processing;

  Future singUp(String name, String email, String password,
      String confirmationPassword) async {
    _setProcessingRegister();
    var bodySingIn =
        User.getJsonSingin(name, email, password, confirmationPassword);
    http.Response loginRequest =
        await _api.sendPostRequest(API_SING_IN, bodySingIn);

    if (loginRequest.statusCode == 200) {
      loggedUser = User.fromJson(jsonDecode(loginRequest.body));
      _msgLastRequest = "Usuário ${loggedUser.email}, cadastrado com sucesso!";
    } else {
      loggedUser = null;
      _msgLastRequest = loginRequest.body;
    }
    _setProcessingRegister();
  }

  Future loginApi(String email, String password) async {
    final bodyRequest = {'email': email, 'senha': password};

    http.Response loginRequest =
        await _api.sendPostRequest("/user/login", bodyRequest);

    if (loginRequest.statusCode == 200) {
      loggedUser = User.fromJson(jsonDecode(loginRequest.body));
      _msgLastRequest = "Logado com sucesso!";
    } else {
      loggedUser = null;
      _msgLastRequest = loginRequest.statusCode == 401
          ? "Usuário ou senha incorreto!"
          : "Falha inesperada ao realizar login";
    }
  }

  _setProcessingRegister() {
    _processing = !_processing;
    notifyListeners();
  }
}
