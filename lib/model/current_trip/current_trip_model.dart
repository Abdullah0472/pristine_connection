class CurrentTripModel {
  int? statusCode;
  String? message;
  String? error;
  List<Data>? data;

  CurrentTripModel({this.statusCode, this.message, this.error, this.data});

  CurrentTripModel.fromJson(Map<String, dynamic> json) {
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
  String? status;
  String? loadStatus;
  int? loadId;
  int? pieces;
  String? dims;
  int? weight;
  int? miles;
  String? pickupLocation;
  String? pickupDate;
  String? deliveryLocation;
  String? deliveryDate;

  Data(
      {this.status,
        this.loadStatus,
        this.loadId,
        this.pieces,
        this.dims,
        this.weight,
        this.miles,
        this.pickupLocation,
        this.pickupDate,
        this.deliveryLocation,
        this.deliveryDate});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    loadStatus = json['load_status'];
    loadId = json['load_id'];
    pieces = json['pieces'];
    dims = json['dims'];
    weight = json['weight'];
    miles = json['miles'];
    pickupLocation = json['pickup_location'];
    pickupDate = json['pickup_date'];
    deliveryLocation = json['delivery_location'];
    deliveryDate = json['delivery_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['load_status'] = this.loadStatus;
    data['load_id'] = this.loadId;
    data['pieces'] = this.pieces;
    data['dims'] = this.dims;
    data['weight'] = this.weight;
    data['miles'] = this.miles;
    data['pickup_location'] = this.pickupLocation;
    data['pickup_date'] = this.pickupDate;
    data['delivery_location'] = this.deliveryLocation;
    data['delivery_date'] = this.deliveryDate;
    return data;
  }
}