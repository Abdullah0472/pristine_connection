// class UserModel {
//   int? statusCode;
//   String? message;
//   String? error;
//   Data? data;
//
//   UserModel({this.statusCode, this.message, this.error, this.data});
//
//   UserModel.fromJson(Map<String, dynamic> json) {
//     statusCode = json['status_code'];
//     message = json['message'];
//     error = json['error'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status_code'] = statusCode;
//     data['message'] = message;
//     data['error'] = error;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? email;
//   String? name;
//   String? regNo;
//   String? phone;
//   String? avatar;
//   String? license;
//   String? city;
//   String? state;
//   String? address;
//   String? zip;
//
//   Data(
//       {this.email,
//         this.name,
//         this.regNo,
//         this.phone,
//         this.avatar,
//         this.license,
//         this.city,
//         this.state,
//         this.address,
//         this.zip});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     email = json['email'];
//     name = json['name'];
//     regNo = json['reg_no'];
//     phone = json['phone'];
//     avatar = json['avatar'];
//     license = json['license'];
//     city = json['city'];
//     state = json['state'];
//     address = json['address'];
//     zip = json['zip'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['email'] = email;
//     data['name'] = name;
//     data['reg_no'] = regNo;
//     data['phone'] = phone;
//     data['avatar'] = avatar;
//     data['license'] = license;
//     data['city'] = city;
//     data['state'] = state;
//     data['address'] = address;
//     data['zip'] = zip;
//     return data;
//   }
// }


import 'package:get/get.dart';

class UserModel {
  int? statusCode;
  String? message;
  String? error;
  Data? data;

  UserModel({this.statusCode, this.message, this.error, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? email;
  String? name;
  String? regNo;
  String? phone;
  String? avatar;
  String? license;
  String? city;
  String? state;
  String? address;
  String? zip;
  String? licenceExp;
  String? licenceNo;
  String? facemask;
  String? team;
  String? teamName;
  String? teamNumber;
  String? bankName;
  String? accountName;
  String? routing;
  String? hardHat;
  String? steelToe;
  String? vest;
  String? accountNumber;
  String? dlExp;
  String? dlExpDate;
  String? bankDocs;
  String? greenCard;
  String? twicCard;
  String? tsaCard;
  String? hazmatExp;
  String? hazmatExpDate;
  String? insuranceExp;
  String? insExpDate;

  Data(
      {this.email,
        this.name,
        this.regNo,
        this.phone,
        this.avatar,
        this.license,
        this.city,
        this.state,
        this.address,
        this.zip,
        this.licenceExp,
        this.licenceNo,
        this.facemask,
        this.team,
        this.teamName,
        this.teamNumber,
        this.bankName,
        this.accountName,
        this.routing,
        this.hardHat,
        this.steelToe,
        this.vest,
        this.accountNumber,
        this.dlExp,
        this.dlExpDate,
        this.bankDocs,
        this.greenCard,
        this.twicCard,
        this.tsaCard,
        this.hazmatExp,
        this.hazmatExpDate,
        this.insuranceExp,
        this.insExpDate});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    regNo = json['reg_no'];
    phone = json['phone'];
    avatar = json['avatar'];
    license = json['license'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    zip = json['zip'];
    licenceExp = json['licence_exp'];
    licenceNo = json['licence_no'];
    facemask = json['facemask'];
    team = json['team'];
    teamName = json['team_name'];
    teamNumber = json['team_number'];
    bankName = json['bank_name'];
    accountName = json['account_name'];
    routing = json['routing'];
    hardHat = json['hard_hat'];
    steelToe = json['steel_toe'];
    vest = json['vest'];
    accountNumber = json['account_number'];
    dlExp = json['dl_exp'];
    dlExpDate = json['dl_exp_date'];
    bankDocs = json['bank_docs'];
    greenCard = json['green_card'];
    twicCard = json['twic_card'];
    tsaCard = json['tsa_card'];
    hazmatExp = json['hazmat_exp'];
    hazmatExpDate = json['hazmat_exp_date'];
    insuranceExp = json['insurance_exp'];
    insExpDate = json['ins_exp_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['reg_no'] = this.regNo;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['license'] = this.license;
    data['city'] = this.city;
    data['state'] = this.state;
    data['address'] = this.address;
    data['zip'] = this.zip;
    data['licence_exp'] = this.licenceExp;
    data['licence_no'] = this.licenceNo;
    data['facemask'] = this.facemask;
    data['team'] = this.team;
    data['team_name'] = this.teamName;
    data['team_number'] = this.teamNumber;
    data['bank_name'] = this.bankName;
    data['account_name'] = this.accountName;
    data['routing'] = this.routing;
    data['hard_hat'] = this.hardHat;
    data['steel_toe'] = this.steelToe;
    data['vest'] = this.vest;
    data['account_number'] = this.accountNumber;
    data['dl_exp'] = this.dlExp;
    data['dl_exp_date'] = this.dlExpDate;
    data['bank_docs'] = this.bankDocs;
    data['green_card'] = this.greenCard;
    data['twic_card'] = this.twicCard;
    data['tsa_card'] = this.tsaCard;
    data['hazmat_exp'] = this.hazmatExp;
    data['hazmat_exp_date'] = this.hazmatExpDate;
    data['insurance_exp'] = this.insuranceExp;
    data['ins_exp_date'] = this.insExpDate;
    return data;
  }
}