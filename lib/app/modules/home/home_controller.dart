import 'package:flutter/cupertino.dart';
import 'package:initiative_helper/app/database/database.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class CurrentEncounter {
  int id;
  String description;

  CurrentEncounter({@required this.id, @required this.description});
}

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  _HomeControllerBase() {
    _db = AppDatabase();        
  }

  AppDatabase _db;

  @observable
  ObservableFuture<List<Character>> charactersList = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Encounter>> encountersList = ObservableFuture.value([]);

  @observable
  CurrentEncounter activeEncounter = CurrentEncounter(id: 0, description: 'Choose an encounter');

  // @action
  // Future<List<Encounter>> getEncounters() async{
  //   return encountersList = _db.encounterDao.allEncounters().asObservable();
    
  // }  

  @action
  void setActiveEncouter(int id,String description) => activeEncounter = 
    CurrentEncounter(id: id, description: description);

  @action
  Future getEncounters() => encountersList =
    ObservableFuture(_db.encounterDao.allEncounters());

  @action
  Future deleteEncounter(Encounter encounter) async{
    //If the active encounter is the one getting deleted
    //reset the characters list
    if (encounter.id == activeEncounter.id) {
      setActiveEncouter(0, 'Choose an encounter');
      charactersList = ObservableFuture.value([]);
    }
    //Delete the encounter
    _db.encounterDao.deleteEncounter(encounter);    
    await getEncounters();
  }

  @action
  Future<int> addEncounter(String description) async{
    int id = await _db.encounterDao.createEncounter(description);
    await getEncounters();
    return id;
  }

  // @action
  // Future<List<Character>> getCharactersInEncounter(Encounter encounter) {
  //   return charactersList = _db.characterDao.charactersInEncounter(encounter).asObservable();
  // }

  Future getCharactersInEncounter(Encounter encounter) { 
    setActiveEncouter(encounter.id,encounter.description);
    return charactersList =
      ObservableFuture(_db.characterDao.charactersInEncounter(encounter));
  }

  @action
  Future deleteCharacter(Character character) async {
    await _db.characterDao.deleteCharacter(character);
    final Encounter encounter = await _db.encounterDao.getEncounter(character.encounter);
    await getCharactersInEncounter(encounter);
  }

  @action
  Future updateCharacter(Character characters,int encounterId) async {
    await _db.characterDao.updateCharacter(characters);
    final Encounter encounter = await _db.encounterDao.getEncounter(encounterId);
    await getCharactersInEncounter(encounter);
  }

  @action
  Future addCharacter(CharactersCompanion charactersCompanion, int encounterId) async {
    await _db.characterDao.createCharacter(charactersCompanion);
    final Encounter encounter = await _db.encounterDao.getEncounter(encounterId);
    await getCharactersInEncounter(encounter);
  }
}
