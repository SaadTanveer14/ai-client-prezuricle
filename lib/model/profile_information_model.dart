class ProfileInformationModel {
  ProfileInformationModel({
    num? status,
    String? message,
    Data? data,}){
    _status = status;
    _message = message;
    _data = data;
  }

  ProfileInformationModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;

  num? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    num? id,
    String? name,
    String? role,
    dynamic username,
    String? email,
    String? phone,
    String? image,
    String? lang,
    num? credits,
    num? status,
    String? willExpire,
    num? planId,
    dynamic emailVerifiedAt,
    String? createdAt,
    String? updatedAt,
    Plan? plan,}){
    _id = id;
    _name = name;
    _role = role;
    _username = username;
    _email = email;
    _phone = phone;
    _image = image;
    _lang = lang;
    _credits = credits;
    _status = status;
    _willExpire = willExpire;
    _planId = planId;
    _emailVerifiedAt = emailVerifiedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _plan = plan;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _role = json['role'];
    _username = json['username'];
    _email = json['email'];
    _phone = json['phone'];
    _image = json['image'];
    _lang = json['lang'];
    _credits = json['credits'];
    _status = json['status'];
    _willExpire = json['will_expire'];
    _planId = json['plan_id'];
    _emailVerifiedAt = json['email_verified_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
  }
  num? _id;
  String? _name;
  String? _role;
  dynamic _username;
  String? _email;
  String? _phone;
  String? _image;
  String? _lang;
  num? _credits;
  num? _status;
  String? _willExpire;
  num? _planId;
  dynamic _emailVerifiedAt;
  String? _createdAt;
  String? _updatedAt;
  Plan? _plan;

  num? get id => _id;
  String? get name => _name;
  String? get role => _role;
  dynamic get username => _username;
  String? get email => _email;
  String? get phone => _phone;
  String? get image => _image;
  String? get lang => _lang;
  num? get credits => _credits;
  num? get status => _status;
  String? get willExpire => _willExpire;
  num? get planId => _planId;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Plan? get plan => _plan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['role'] = _role;
    map['username'] = _username;
    map['email'] = _email;
    map['phone'] = _phone;
    map['image'] = _image;
    map['lang'] = _lang;
    map['credits'] = _credits;
    map['status'] = _status;
    map['will_expire'] = _willExpire;
    map['plan_id'] = _planId;
    map['email_verified_at'] = _emailVerifiedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_plan != null) {
      map['plan'] = _plan?.toJson();
    }
    return map;
  }

}

class Plan {
  Plan({
    num? id,
    String? title,
    String? subtitle,
    num? price,
    String? duration,
    num? status,
    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _title = title;
    _subtitle = subtitle;
    _price = price;
    _duration = duration;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Plan.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _subtitle = json['subtitle'];
    _price = json['price'];
    _duration = json['duration'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _title;
  String? _subtitle;
  num? _price;
  String? _duration;
  num? _status;
  String? _createdAt;
  String? _updatedAt;

  num? get id => _id;
  String? get title => _title;
  String? get subtitle => _subtitle;
  num? get price => _price;
  String? get duration => _duration;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['subtitle'] = _subtitle;
    map['price'] = _price;
    map['duration'] = _duration;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}