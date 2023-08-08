class VehiclesModel {
  int? statusCode;
  String? message;
  String? error;
  List<Data>? data;

  VehiclesModel({this.statusCode, this.message, this.error, this.data});

  VehiclesModel.fromJson(Map<String, dynamic> json) {
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
  int? length;
  int? width;
  int? height;
  Null? regNo;
  String? images;
  int? driverId;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? model;
  String? vehicleMake;
  String? year;
  String? cargoDims;
  String? doorDims;
  String? dockHigh;
  String? palletJack;
  String? liftGate;
  String? tempCount;
  String? weight;
  String? regExp;
  String? regExpDate;
  Null? deletedAt;

  Data(
      {this.id,
        this.length,
        this.width,
        this.height,
        this.regNo,
        this.images,
        this.driverId,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.model,
        this.vehicleMake,
        this.year,
        this.cargoDims,
        this.doorDims,
        this.dockHigh,
        this.palletJack,
        this.liftGate,
        this.tempCount,
        this.weight,
        this.regExp,
        this.regExpDate,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    regNo = json['reg_no'];
    images = json['images'];
    driverId = json['driver_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    model = json['model'];
    vehicleMake = json['vehicle_make'];
    year = json['year'];
    cargoDims = json['cargo_dims'];
    doorDims = json['door_dims'];
    dockHigh = json['dock_high'];
    palletJack = json['pallet_jack'];
    liftGate = json['lift_gate'];
    tempCount = json['temp_count'];
    weight = json['weight'];
    regExp = json['reg_exp'];
    regExpDate = json['reg_exp_date'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['reg_no'] = this.regNo;
    data['images'] = this.images;
    data['driver_id'] = this.driverId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    data['model'] = this.model;
    data['vehicle_make'] = this.vehicleMake;
    data['year'] = this.year;
    data['cargo_dims'] = this.cargoDims;
    data['door_dims'] = this.doorDims;
    data['dock_high'] = this.dockHigh;
    data['pallet_jack'] = this.palletJack;
    data['lift_gate'] = this.liftGate;
    data['temp_count'] = this.tempCount;
    data['weight'] = this.weight;
    data['reg_exp'] = this.regExp;
    data['reg_exp_date'] = this.regExpDate;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}