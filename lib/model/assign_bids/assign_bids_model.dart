class AssignBidsModel {
  int? statusCode;
  String? message;
  String? error;
  List<Data>? data;

  AssignBidsModel({this.statusCode, this.message, this.error, this.data});

  AssignBidsModel.fromJson(Map<String, dynamic> json) {
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
  String? loadVehicleTypes;
  String? bidVehicleTypes;
  int? weight;
  int? pieces;
  int? loadId;
  String? stackable;
  String? hazardous;
  String? notes;
  String? amount;
  String? dockLevel;

  Data(
      {this.id,
        this.pickupDate,
        this.deliveryDate,
        this.pickupLocation,
        this.deliveryLocation,
        this.miles,
        this.dims,
        this.loadId,
        this.loadVehicleTypes,
        this.bidVehicleTypes,
        this.weight,
        this.pieces,
        this.stackable,
        this.hazardous,
        this.notes,
        this.amount,
        this.dockLevel});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pickupDate = json['pickup_date'];
    deliveryDate = json['delivery_date'];
    pickupLocation = json['pickup_location'];
    deliveryLocation = json['delivery_location'];
    miles = json['miles'];
    dims = json['dims'];
    loadId = json['load_id'];
    loadVehicleTypes = json['load_vehicle_types'];
    bidVehicleTypes = json['bid_vehicle_types'];
    weight = json['weight'];
    pieces = json['pieces'];
    stackable = json['stackable'];
    hazardous = json['hazardous'];
    notes = json['notes'];
    amount = json['amount'];
    dockLevel = json['dock_level'];
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
    data['load_id'] = this.loadId;
    data['load_vehicle_types'] = this.loadVehicleTypes;
    data['bid_vehicle_types'] = this.bidVehicleTypes;
    data['weight'] = this.weight;
    data['pieces'] = this.pieces;
    data['stackable'] = this.stackable;
    data['hazardous'] = this.hazardous;
    data['notes'] = this.notes;
    data['amount'] = this.amount;
    data['dock_level'] = this.dockLevel;
    return data;
  }
}