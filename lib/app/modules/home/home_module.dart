import 'package:initiative_helper/app/modules/home/repositories/monsters_repository.dart';
import 'package:initiative_helper/app/modules/home/services/monsters_service.dart';
import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => MonstersRepository()),
        Bind((i) => MonstersService(monstersRepository: i.get())),
        Bind((i) => HomeController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
