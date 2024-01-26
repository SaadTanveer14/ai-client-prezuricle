class SuggestionsModel {
  SuggestionsModel({
    num? id,
    num? categoryId,
    num? status,
    String? suggestions,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _categoryId = categoryId;
    _status = status;
    _suggestions = suggestions;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  SuggestionsModel.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _status = json['status'];
    _suggestions = json['suggestions'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _categoryId;
  num? _status;
  String? _suggestions;
  String? _createdAt;
  String? _updatedAt;

  num? get id => _id;
  num? get categoryId => _categoryId;
  num? get status => _status;
  String? get suggestions => _suggestions;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['status'] = _status;
    map['suggestions'] = _suggestions;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
