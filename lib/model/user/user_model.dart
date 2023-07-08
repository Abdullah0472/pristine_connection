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
    data['status_code'] = statusCode;
    data['message'] = message;
    data['error'] = error;
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
        this.zip});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['name'] = name;
    data['reg_no'] = regNo;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['license'] = license;
    data['city'] = city;
    data['state'] = state;
    data['address'] = address;
    data['zip'] = zip;
    return data;
  }
}