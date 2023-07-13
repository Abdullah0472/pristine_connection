import 'dart:convert';
import 'dart:io';
import 'package:celient_project/data/network/base_api_services.dart';
import 'package:celient_project/view_model/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../model/login/login_model.dart';
import '../app_exceptions.dart';

class NetworkApiServices extends BaseApiServices {
  UserPreference userPreference = UserPreference();

  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    try {
      LoginModel userModel = await userPreference.getUser();
      final String? getToken = userModel.data?.bearerToken;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $getToken',
        },
      ).timeout(const Duration(seconds: 10));
      print("The Bearer Token $getToken");
      print("Raw Response Body: ${response.body}");
      responseJson = returnResponse(response);

      if (response.statusCode == 200) {
        print("Response OK: ${response.body}");
        responseJson = returnResponse(response);
      } else {
        print("HTTP Error ${response.statusCode}: ${response.body}");
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    print(responseJson);
    return responseJson;
  }

  @override
  Future<dynamic> postApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      print(url);
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      print("Raw Response Body: ${response.body}");
      responseJson = returnResponse(response);

      if (response.statusCode == 200) {
        print("Response OK: ${response.body}");
        responseJson = returnResponse(response);
      } else {
        print("HTTP Error ${response.statusCode}: ${response.body}");
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  @override
  Future<dynamic> updateApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      LoginModel userModel = await userPreference.getUser();
      final String? getToken = userModel.data?.bearerToken;

      final response = await http.post(Uri.parse(url), body: data, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $getToken',
      }).timeout(const Duration(seconds: 10));
      print("The Bearer Token $getToken");
      print("Raw Response Body: ${response.body}");
      responseJson = returnResponse(response);

      if (response.statusCode == 200) {
        print("Response OK: ${response.body}");
        // responseJson = returnResponse(response);
      } else {
        print("HTTP Error ${response.statusCode}: ${response.body}");
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {

    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 405:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 500:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      default:
        throw FetchDataException(
            'Error accoured while communicating with server ' +
                response.statusCode.toString());
    }
  }

  // dynamic returnResponse(http.Response response) {
  //   dynamic responseJson = jsonDecode(response.body);
  //   switch (response.statusCode) {
  //     case 200:
  //       return responseJson;
  //     case 400:
  //     case 401:
  //     case 404:
  //     case 405:
  //     case 500:
  //       throw ApiException(responseJson['message'] ?? "Error");
  //     default:
  //       throw FetchDataException(
  //           'Error occurred while communicating with server ' +
  //               response.statusCode.toString());
  //   }
  // }

}
