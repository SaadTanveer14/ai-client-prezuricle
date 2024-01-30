class GeneralPageModel {
  GeneralPageModel({
      num? status, 
      String? message, 
      String? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GeneralPageModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'];
  }
  num? _status;
  String? _message;
  String? _data;

  num? get status => _status;
  String? get message => _message;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }

}