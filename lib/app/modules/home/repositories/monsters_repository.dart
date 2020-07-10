import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'package:initiative_helper/app/modules/home/models/monsters_model.dart';
import 'package:initiative_helper/app/modules/home/repositories/interfaces/monsters_interface.dart';

class MonstersRepository extends Disposable implements IMonstersRepository{
  final client = Dio();
  final baseUrl = 'http://192.168.1.13:8888/heroes';

  //dispose will be called automatically
  @override
  void dispose() {}

  @override
  Future<List<MonstersModel>> queryRows({String name}) async{           
    final response = await client.get(baseUrl,queryParameters: {
      'name': name,
    });
    return List<MonstersModel>.from(
      response.data.map(
        (monster) => MonstersModel.fromJson(monster)
      )
    );     
  }
}
