class LoadsModel {
  int? statusCode;
  String? message;
  String? error;
  List<Data>? data;

  LoadsModel({this.statusCode, this.message, this.error, this.data});

  LoadsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? pickupDate;
  String? deliveryDate;
  String? pickupLocation;
  String? deliveryLocation;
  int? miles;
  String? dims;
  String? vehicleTypes;
  int? weight;

  Data(
      {this.id,
        this.pickupDate,
        this.deliveryDate,
        this.pickupLocation,
        this.deliveryLocation,
        this.miles,
        this.dims,
        this.vehicleTypes,
        this.weight});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pickupDate = json['pickup_date'];
    deliveryDate = json['delivery_date'];
    pickupLocation = json['pickup_location'];
    deliveryLocation = json['delivery_location'];
    miles = json['miles'];
    dims = json['dims'];
    vehicleTypes = json['vehicle_types'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pickup_date'] = this.pickupDate;
    data['delivery_date'] = this.deliveryDate;
    data['pickup_location'] = this.pickupLocation;
    data['delivery_location'] = this.deliveryLocation;
    data['miles'] = this.miles;
    data['dims'] = this.dims;
    data['vehicle_types'] = this.vehicleTypes;
    data['weight'] = this.weight;
    return data;
  }
}