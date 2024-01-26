class Profile {
  Profile({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  Profile.fromJson(dynamic json) {
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
      String? username, 
      String? email, 
      dynamic phone, 
      String? image, 
      String? lang, 
      num? status, 
      num? credits, 
      dynamic subscribeAt, 
      String? willExpire, 
      num? planId, 
      String? emailVerifiedAt, 
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
    _status = status;
    _credits = credits;
    _subscribeAt = subscribeAt;
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
    _status = json['status'];
    _credits = json['credits'];
    _subscribeAt = json['subscribe_at'];
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
  String? _username;
  String? _email;
  dynamic _phone;
  String? _image;
  String? _lang;
  num? _status;
  num? _credits;
  dynamic _subscribeAt;
  String? _willExpire;
  num? _planId;
  String? _emailVerifiedAt;
  String? _createdAt;
  String? _updatedAt;
  Plan? _plan;

  num? get id => _id;
  String? get name => _name;
  String? get role => _role;
  String? get username => _username;
  String? get email => _email;
  dynamic get phone => _phone;
  String? get image => _image;
  String? get lang => _lang;
  num? get status => _status;
  num? get credits => _credits;
  dynamic get subscribeAt => _subscribeAt;
  String? get willExpire => _willExpire;
  num? get planId => _planId;
  String? get emailVerifiedAt => _emailVerifiedAt;
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
    map['status'] = _status;
    map['credits'] = _credits;
    map['subscribe_at'] = _subscribeAt;
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
      String? name, 
      num? price, 
      num? offerPrice, 
      num? credits, 
      String? duration, 
      num? status, 
      List<Features>? features, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _price = price;
    _offerPrice = offerPrice;
    _credits = credits;
    _duration = duration;
    _status = status;
    _features = features;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Plan.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _offerPrice = json['offer_price'];
    _credits = json['credits'];
    _duration = json['duration'];
    _status = json['status'];
    if (json['features'] != null) {
      _features = [];
      json['features'].forEach((v) {
        _features?.add(Features.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  num? _price;
  num? _offerPrice;
  num? _credits;
  String? _duration;
  num? _status;
  List<Features>? _features;
  String? _createdAt;
  String? _updatedAt;

  num? get id => _id;
  String? get name => _name;
  num? get price => _price;
  num? get offerPrice => _offerPrice;
  num? get credits => _credits;
  String? get duration => _duration;
  num? get status => _status;
  List<Features>? get features => _features;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    map['offer_price'] = _offerPrice;
    map['credits'] = _credits;
    map['duration'] = _duration;
    map['status'] = _status;
    if (_features != null) {
      map['features'] = _features?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Features {
  Features({
      String? title, 
      String? status,}){
    _title = title;
    _status = status;
}

  Features.fromJson(dynamic json) {
    _title = json['title'];
    _status = json['status'];
  }
  String? _title;
  String? _status;

  String? get title => _title;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['status'] = _status;
    return map;
  }

}