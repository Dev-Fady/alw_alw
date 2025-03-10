import 'package:alw_alw/features/add_pepole/domain/entites/add_pepole_entity.dart';

class AddPepoleModel {
  final String name;
  final String id;

  AddPepoleModel({
    required this.name,
    required this.id,
  });

  factory AddPepoleModel.fromJson(Map<String, dynamic> json) {
    return AddPepoleModel(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }

  factory AddPepoleModel.fromEntity(AddPepoleEntity entity) {
    return AddPepoleModel(name: entity.userName, id: entity.iD);
  }

  AddPepoleEntity toEntity() {
    return AddPepoleEntity(userName: name, iD: id);
  }
}
