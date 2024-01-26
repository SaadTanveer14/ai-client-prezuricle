class ImageHistoryModel {
  ImageHistoryModel({
      num? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ImageHistoryModel.fromJson(dynamic json) {
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
      num? userId, 
      dynamic categoryId, 
      String? type, 
      String? title, 
      num? costCredits, 
      String? imageSizes, 
      List<String>? data, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _categoryId = categoryId;
    _type = type;
    _title = title;
    _costCredits = costCredits;
    _imageSizes = imageSizes;
    _data = data;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _categoryId = json['category_id'];
    _type = json['type'];
    _title = json['title'];
    _costCredits = json['cost_credits'];
    _imageSizes = json['image_sizes'];
    _data = json['data'] != null ? json['data'].cast<String>() : [];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _userId;
  dynamic _categoryId;
  String? _type;
  String? _title;
  num? _costCredits;
  String? _imageSizes;
  List<String>? _data;
  String? _createdAt;
  String? _updatedAt;

  num? get id => _id;
  num? get userId => _userId;
  dynamic get categoryId => _categoryId;
  String? get type => _type;
  String? get title => _title;
  num? get costCredits => _costCredits;
  String? get imageSizes => _imageSizes;
  List<String>? get data => _data;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['category_id'] = _categoryId;
    map['type'] = _type;
    map['title'] = _title;
    map['cost_credits'] = _costCredits;
    map['image_sizes'] = _imageSizes;
    map['data'] = _data;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}