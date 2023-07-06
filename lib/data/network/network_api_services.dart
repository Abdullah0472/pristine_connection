import 'dart:convert';
import 'dart:io';
import 'package:celient_project/data/network/base_api_services.dart';
import 'package:celient_project/view_model/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../model/login/user_model.dart';
import '../app_exceptions.dart';

class NetworkApiServices extends BaseApiServices {

  UserPreference userPreference = UserPreference();

  // @override
  // Future<dynamic> getApi(String url)async{
  //
  //   if (kDebugMode) {
  //     print(url);
  //   }
  //
  //   dynamic responseJson ;
  //   try {
  //     final String? getTooken = await userPreference.getUser().then((value) => value.token);
  //     final response = await http.get(Uri.parse(url),
  //       headers: {
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $getTooken'
  //       },
  //     ).timeout( const Duration(seconds: 10));
  //     responseJson  = returnResponse(response) ;
  //   }on SocketException {
  //     throw InternetException('');
  //   }on RequestTimeOut {
  //     throw RequestTimeOut('');
  //
  //   }
  //   print(responseJson);
  //   return responseJson ;
  //
  // }


  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    try {
      UserModel userModel = await userPreference.getUser();
      final String? getToken = userModel.data?.bearerToken;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $getToken',
        },
      ).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
          throw RequestTimeOut('');

        }
    print(responseJson);
    return responseJson;
  }



  @override
  Future<dynamic> postApi(var data , String url)async{

    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson ;
    try {

      final response = await http.post(Uri.parse(url),
        body: data
      ).timeout( const Duration(seconds: 10));
      responseJson  = returnResponse(response) ;
    }on SocketException {
      throw InternetException('');
    }on RequestTimeOut {
      throw RequestTimeOut('');

    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson ;

  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 405:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 500:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;

      default :
        throw FetchDataException('Error accoured while communicating with server '+response.statusCode.toString()) ;
    }
  }

}