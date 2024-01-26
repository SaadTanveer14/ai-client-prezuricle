class SignUpModel {
  SignUpModel({
      Data? data, 
      String? message,}){
    _data = data;
    _message = message;
}

  SignUpModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  Data? _data;
  String? _message;

  Data? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

class Data {
  Data({
      num? userId, 
      String? tokenType, 
      String? token,}){
    _userId = userId;
    _tokenType = tokenType;
    _token = token;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _tokenType = json['token_type'];
    _token = json['token'];
  }
  num? _userId;
  String? _tokenType;
  String? _token;

  num? get userId => _userId;
  String? get tokenType => _tokenType;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['token_type'] = _tokenType;
    map['token'] = _token;
    return map;
  }

}