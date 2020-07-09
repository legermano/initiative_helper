import 'package:flutter/foundation.dart';

class MonstersModel {
  final int id;
  final String name;


  MonstersModel({
    @required this.id,
    @required this.name
  });

  factory MonstersModel.fromJson(Map<String, dynamic> json) {
    return MonstersModel(
      id: json['id'],
      name: json['name']
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id,'name': name};
  }   

  @override
  String toString() {
    return 'MonsterModel{id: $id name: $name}';
  }
}
