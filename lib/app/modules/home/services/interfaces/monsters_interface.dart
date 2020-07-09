import 'package:initiative_helper/app/modules/home/models/monsters_model.dart';

abstract class IMonsterService {
  Future<List<MonstersModel>> queryRows({String name});
  Future<int> queryRowCount();
  Future<MonstersModel> findById(id);
}