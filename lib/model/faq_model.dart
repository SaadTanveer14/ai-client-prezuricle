class FaqModel {
  FaqModel({
      num? id, 
      String? question, 
      num? status, 
      String? answer, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _question = question;
    _status = status;
    _answer = answer;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  FaqModel.fromJson(dynamic json) {
    _id = json['id'];
    _question = json['question'];
    _status = json['status'];
    _answer = json['answer'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _question;
  num? _status;
  String? _answer;
  String? _createdAt;
  String? _updatedAt;

  num? get id => _id;
  String? get question => _question;
  num? get status => _status;
  String? get answer => _answer;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['question'] = _question;
    map['status'] = _status;
    map['answer'] = _answer;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}