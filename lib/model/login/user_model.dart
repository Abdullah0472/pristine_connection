// class UserModel {
//   String? token;
//   bool? isLogin ;
//
//   UserModel({this.token , this.isLogin});
//
//   UserModel.fromJson(Map<String, dynamic> json) {
//     token = json['token'];
//     isLogin = json['isLogin'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['token'] = token;
//     data['isLogin'] = token;
//     return data;
//   }
// }



class UserModel {
  int? statusCode;
  String? message;
  String? error;
  Data? data;
  bool? isLogin ;

  UserModel({this.statusCode, this.message, this.error, this.data, this.isLogin});

  UserModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    isLogin = json['isLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    data['isLogin'] = data;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? bearerToken;
  String? uniqueId;

  Data({this.bearerToken, this.uniqueId});

  Data.fromJson(Map<String, dynamic> json) {
    bearerToken = json['bearer_token'];
    uniqueId = json['unique_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bearer_token'] = this.bearerToken;
    data['unique_id'] = this.uniqueId;
    return data;
  }
}
