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
  int? id;
  String? pickupDate;
  String? deliveryDate;
  String? pickupLocation;
  String? deliveryLocation;
  int? miles;
  String? dims;
  String? vehicleTypes;
  int? weight;
  int? pieces;
  String? stackable;
  String? hazardous;
  String? notes;
  String? dockLevel;

  Data(
      {this.id,
        this.pickupDate,
        this.deliveryDate,
        this.pickupLocation,
        this.deliveryLocation,
        this.miles,
        this.dims,
        this.vehicleTypes,
        this.weight,
        this.pieces,
        this.stackable,
        this.hazardous,
        this.notes,
        this.dockLevel,
      });

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
    pieces = json['pieces'];
    stackable = json['stackable'];
    hazardous = json['hazardous'];
    notes = json['notes'];
    dockLevel = json['dock_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['pickup_date'] = pickupDate;
    data['delivery_date'] = deliveryDate;
    data['pickup_location'] = pickupLocation;
    data['delivery_location'] = deliveryLocation;
    data['miles'] = miles;
    data['dims'] = dims;
    data['vehicle_types'] = vehicleTypes;
    data['weight'] = weight;
    data['pieces'] = pieces;
    data['stackable'] = stackable;
    data['hazardous'] = hazardous;
    data['notes'] = notes;
    data['dock_level'] = dockLevel;

    return data;
  }
}