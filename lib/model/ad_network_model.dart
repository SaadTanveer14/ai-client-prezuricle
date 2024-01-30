class AdNetworkModel {
  AdNetworkModel({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  AdNetworkModel.fromJson(dynamic json) {
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
      String? videoAdId, 
      String? admobAppId,
    String? videoAdStatus,
    String? admobAppIdStatus,}){
    _videoAdId = videoAdId;
    _admobAppId = admobAppId;
    _videoAdStatus = videoAdStatus;
    _admobAppIdStatus = admobAppIdStatus;
}

  Data.fromJson(dynamic json) {
    _videoAdId = json['video_ad_id'];
    _admobAppId = json['admob_app_id'];
    _videoAdStatus = json['video_ad_status'].toString();
    _admobAppIdStatus = json['admob_app_id_status'].toString();
  }
  String? _videoAdId;
  String? _admobAppId;
  String? _videoAdStatus;
  String? _admobAppIdStatus;

  String? get videoAdId => _videoAdId;
  String? get admobAppId => _admobAppId;
  String? get videoAdStatus => _videoAdStatus;
  String? get admobAppIdStatus => _admobAppIdStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['video_ad_id'] = _videoAdId;
    map['admob_app_id'] = _admobAppId;
    map['video_ad_status'] = _videoAdStatus;
    map['admob_app_id_status'] = _admobAppIdStatus;
    return map;
  }

}