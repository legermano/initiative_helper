import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:initiative_helper/app/modules/home/models/monsters_model.dart';
import 'package:initiative_helper/app/modules/home/repositories/interfaces/monsters_interface.dart';
import 'package:initiative_helper/app/modules/home/services/interfaces/monsters_interface.dart';

class MonstersService extends Disposable implements IMonsterService{
  final IMonstersRepository monstersRepository;
  MonstersService({@required this.monstersRepository});

  //dispose will be called automatically
  @override
  void dispose() {}

  @override
  Future<List<MonstersModel>> queryRows({String name}) async{
    Future<List<MonstersModel>> rows;
    name.isNotEmpty 
      ? rows = monstersRepository.queryRows(name: name)
      : rows = monstersRepository.queryRows();
    return rows;  
  }
}
