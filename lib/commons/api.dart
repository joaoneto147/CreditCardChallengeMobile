import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const URL_API = "http://10.0.2.2:5000/api";
const URL_API_HTTPS = "http://10.0.2.2:5000/api";
const TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJ5LnNybmV0bzNAZ21haWwuY29tIiwic3ViIjoiZTQwYmVkNzItOTU2OC00NTMyLWExODgtNWZhNWQ1MGQzMzE1IiwiZXhwIjoxNTg3Mjg3NTkxfQ.RZPW7uj_t1tIOxqbYGLmodD1FkKHGij0EJJ7nNsEe5s";

class Api {
  String getQueryString(List<String> paramters) {
    String _paramter = "";   
    String _charConcat = "?";

    paramters.forEach((f) {
      _paramter += _charConcat + f;
      _charConcat = "&";
    });
    return _paramter;
  }

  Future sendGetRequest(String urlRequest, String queryParameters) async {
    final response = await http.get(URL_API + urlRequest + queryParameters, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $TOKEN'
    });    
    return response;
  }

  Future<http.Response> sendPostRequest(
      String urlRequest, Map<String, dynamic> bodyRequest) async {
    final headers = {HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer $TOKEN'};
    final jsonBody = json.encode(bodyRequest);

    http.Response response = await http.post(URL_API_HTTPS + urlRequest,
        body: jsonBody, headers: headers);
    return response;
  }

  Future sendDeleteRequest(String urlRequest) async {
    final response = await http.get(URL_API + urlRequest);
    return response.body;
  }

  Future sendPutRequest(String urlRequest) async {
    final response = await http.get(URL_API + urlRequest);
    return response.body;
  }
}
