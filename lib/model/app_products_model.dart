class AppProductsModel {
  AppProductsModel({
      num? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  AppProductsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<Data>? _data;

  num? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      num? id, 
      String? platform, 
      String? productId, 
      num? reward, 
      num? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _platform = platform;
    _productId = productId;
    _reward = reward;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _platform = json['platform'];
    _productId = json['product_id'];
    _reward = json['reward'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _platform;
  String? _productId;
  num? _reward;
  num? _status;
  String? _createdAt;
  String? _updatedAt;

  num? get id => _id;
  String? get platform => _platform;
  String? get productId => _productId;
  num? get reward => _reward;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['platform'] = _platform;
    map['product_id'] = _productId;
    map['reward'] = _reward;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}