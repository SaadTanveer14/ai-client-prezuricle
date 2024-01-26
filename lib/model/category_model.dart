class CategoryModel {
  CategoryModel({
      num? id, 
      String? name, 
      num? status,
      dynamic image, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _status = status;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  CategoryModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  num? _status;
  dynamic _image;
  String? _createdAt;
  String? _updatedAt;

  num? get id => _id;
  String? get name => _name;
  num? get status => _status;
  dynamic get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}