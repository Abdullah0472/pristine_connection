class StartTripModel {
  int? statusCode;
  String? message;
  String? error;
  List<Data>? data;

  StartTripModel({this.statusCode, this.message, this.error, this.data});

  StartTripModel.fromJson(Map<String, dynamic> json) {
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
    data['status_code'] = statusCode;
    data['message'] = message;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? status;
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
    data['status'] = status;
    data['load_id'] = loadId;
    data['pieces'] = pieces;
    data['dims'] = dims;
    data['weight'] = weight;
    data['miles'] = miles;
    data['pickup_location'] = pickupLocation;
    data['pickup_date'] = pickupDate;
    data['delivery_location'] = deliveryLocation;
    data['delivery_date'] = deliveryDate;
    return data;
  }
}