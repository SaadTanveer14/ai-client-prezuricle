class SignInModel {
  SignInModel({
      Data? data, 
      String? message,}){
    _data = data;
    _message = message;
}

  SignInModel.fromJson(dynamic json) {
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
      String? name, 
      String? email, 
      String? token,}){
    _name = name;
    _email = email;
    _token = token;
}

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _token = json['token'];
  }
  String? _name;
  String? _email;
  String? _token;

  String? get name => _name;
  String? get email => _email;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['token'] = _token;
    return map;
  }

}