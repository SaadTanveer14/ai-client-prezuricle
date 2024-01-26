class GatewayListModel {
  GatewayListModel({
    num? status,
    String? message,
    Data? data,}){
    _status = status;
    _message = message;
    _data = data;
  }

  GatewayListModel.fromJson(dynamic json) {
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
    String? paypalIsLive,
    String? paypalClientId,
    String? paypalClientSecret,
    String? stripeIsLive,
    String? stripeClientId,
    String? stripeClientSecret,
    String? razorpayIsLive,
    String? razorpayClientId,
    String? razorpayClientSecret,
    String? sslcommerzIsLive,
    String? sslcommerzClientId,
    String? sslcommerzClientSecret,}){
    _paypalIsLive = paypalIsLive;
    _paypalClientId = paypalClientId;
    _paypalClientSecret = paypalClientSecret;
    _stripeIsLive = stripeIsLive;
    _stripeClientId = stripeClientId;
    _stripeClientSecret = stripeClientSecret;
    _razorpayIsLive = razorpayIsLive;
    _razorpayClientId = razorpayClientId;
    _razorpayClientSecret = razorpayClientSecret;
    _sslcommerzIsLive = sslcommerzIsLive;
    _sslcommerzClientId = sslcommerzClientId;
    _sslcommerzClientSecret = sslcommerzClientSecret;
  }

  Data.fromJson(dynamic json) {
    _paypalIsLive = json['paypal_is_live'];
    _paypalClientId = json['paypal_client_id'];
    _paypalClientSecret = json['paypal_client_secret'];
    _stripeIsLive = json['stripe_is_live'];
    _stripeClientId = json['stripe_client_id'];
    _stripeClientSecret = json['stripe_client_secret'];
    _razorpayIsLive = json['razorpay_is_live'];
    _razorpayClientId = json['razorpay_client_id'];
    _razorpayClientSecret = json['razorpay_client_secret'];
    _sslcommerzIsLive = json['sslcommerz_is_live'];
    _sslcommerzClientId = json['sslcommerz_client_id'];
    _sslcommerzClientSecret = json['sslcommerz_client_secret'];
  }
  String? _paypalIsLive;
  String? _paypalClientId;
  String? _paypalClientSecret;
  String? _stripeIsLive;
  String? _stripeClientId;
  String? _stripeClientSecret;
  String? _razorpayIsLive;
  String? _razorpayClientId;
  String? _razorpayClientSecret;
  String? _sslcommerzIsLive;
  String? _sslcommerzClientId;
  String? _sslcommerzClientSecret;

  String? get paypalIsLive => _paypalIsLive;
  String? get paypalClientId => _paypalClientId;
  String? get paypalClientSecret => _paypalClientSecret;
  String? get stripeIsLive => _stripeIsLive;
  String? get stripeClientId => _stripeClientId;
  String? get stripeClientSecret => _stripeClientSecret;
  String? get razorpayIsLive => _razorpayIsLive;
  String? get razorpayClientId => _razorpayClientId;
  String? get razorpayClientSecret => _razorpayClientSecret;
  String? get sslcommerzIsLive => _sslcommerzIsLive;
  String? get sslcommerzClientId => _sslcommerzClientId;
  String? get sslcommerzClientSecret => _sslcommerzClientSecret;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['paypal_is_live'] = _paypalIsLive;
    map['paypal_client_id'] = _paypalClientId;
    map['paypal_client_secret'] = _paypalClientSecret;
    map['stripe_is_live'] = _stripeIsLive;
    map['stripe_client_id'] = _stripeClientId;
    map['stripe_client_secret'] = _stripeClientSecret;
    map['razorpay_is_live'] = _razorpayIsLive;
    map['razorpay_client_id'] = _razorpayClientId;
    map['razorpay_client_secret'] = _razorpayClientSecret;
    map['sslcommerz_is_live'] = _sslcommerzIsLive;
    map['sslcommerz_client_id'] = _sslcommerzClientId;
    map['sslcommerz_client_secret'] = _sslcommerzClientSecret;
    return map;
  }

}