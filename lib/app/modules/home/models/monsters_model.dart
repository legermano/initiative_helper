import 'package:flutter/foundation.dart';

class MonstersModel {
  final int id;
  final String name;
  final int armorClass;
  final int hitPoints;


  MonstersModel({
    @required this.id,
    @required this.name,
    @required this.armorClass,
    @required this.hitPoints
  });

  factory MonstersModel.fromJson(Map<String, dynamic> json) {
    return MonstersModel(
      id: json['id'],
      name: json['name'],
      armorClass: json['armorClass'] as int,
      hitPoints: json['hitPoints'] as int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name, 
      'armorClass': armorClass, 
      'hitPoints': hitPoints
    };
  }   

  @override
  String toString() {
    return 'MonsterModel{id: $id name: $name armorClass: $armorClass hitPoints: $hitPoints}';
  }
}
