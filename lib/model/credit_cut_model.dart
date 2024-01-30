class CreditCutModel {
  CreditCutModel({
    num? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  CreditCutModel.fromJson(dynamic json) {
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
    String? type,
    num? costCredits,
    String? title,
    String? createdAt,
  }) {
    _type = type;
    _costCredits = costCredits;
    _title = title;
    _createdAt = createdAt;
  }

  Data.fromJson(dynamic json) {
    _type = json['type'];
    _costCredits = json['cost_credits'];
    _title = json['title'];
    _createdAt = json['created_at'];
  }
  String? _type;
  num? _costCredits;
  String? _title;
  String? _createdAt;

  String? get type => _type;
  num? get costCredits => _costCredits;
  String? get title => _title;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['cost_credits'] = _costCredits;
    map['title'] = _title;
    map['created_at'] = _createdAt;
    return map;
  }
}
