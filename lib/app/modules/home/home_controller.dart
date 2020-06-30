import 'package:flutter/cupertino.dart';
import 'package:initiative_helper/app/database/database.dart';
import 'package:initiative_helper/app/database/platforms/shared.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class CurrentEncounter {
  int id;
  String description;
  int currentTurn;

  CurrentEncounter({
    @required this.id, 
    @required this.description,
    @required this.currentTurn
  });
}

class CharacterWithInfo {
  Character character;
  int initiativeWithModifier;
  bool turn;

  CharacterWithInfo({
    @required this.character,
    @required this.initiativeWithModifier,
    @required this.turn
  });
}

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  _HomeControllerBase() {
    _db = constructDb();        
  }

  AppDatabase _db;

  @observable
  ObservableList<CharacterWithInfo> charactersList = ObservableList<CharacterWithInfo>();

  //? Change the encounter list to a ObservabelList too?
  @observable
  ObservableFuture<List<Encounter>> encountersList = ObservableFuture.value([]);

  @observable
  CurrentEncounter activeEncounter = CurrentEncounter(id: 0, description: '',currentTurn: 0);
  
  //# ENCOUNTERS
  @action
  void setActiveEncouter(int id,String description) => activeEncounter = 
    CurrentEncounter(id: id, description: description,currentTurn: 0);

  @action
  void setCurrentTurn(int turn) {
    activeEncounter = CurrentEncounter(
      id: activeEncounter.id, 
      description: activeEncounter.description, 
      currentTurn: turn
    );
  }  

  @action
  Future getEncounters() => encountersList =
    ObservableFuture(_db.encounterDao.allEncounters());

  @action
  Future deleteEncounter(Encounter encounter) async{
    //If the active encounter is the one getting deleted
    //reset the characters list
    if (encounter.id == activeEncounter.id) {
      setActiveEncouter(0, '');
      charactersList.clear();
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

  //# CHARACTERS
  @action
  void orderCharacterList() {
    List<CharacterWithInfo> ch = charactersList.toList();
    ch.sort((a,b) => b.initiativeWithModifier.compareTo(a.initiativeWithModifier));    
    charactersList = ch.asObservable();
    // for (var c in charactersList) {
    //   print( c.character.name +'|'+ c.initiativeWithModifier.toString()+'|turn : '+c.turn.toString());
    // }
  }  

  Future getCharactersInEncounter(Encounter encounter) async{ 
    setActiveEncouter(encounter.id,encounter.description);
    List<Character> charactes =
      await _db.characterDao.charactersInEncounter(encounter);
    charactersList = charactes.map(
      (e) => CharacterWithInfo(
        character: e, 
        initiativeWithModifier: (e.initiative + e.modifier), 
        turn: false
      )
    ).toList().asObservable();
    orderCharacterList();
  }

  @action
  Future deleteCharacter(CharacterWithInfo character) async {
    await _db.characterDao.deleteCharacter(character.character);
    charactersList.remove(character);
    orderCharacterList();
  }

  @action
  Future updateCharacter(CharacterWithInfo character) async {
    await _db.characterDao.updateCharacter(character.character);
    int index = charactersList.indexWhere(
      (c) => c.character.id == character.character.id
    );
    charactersList.replaceRange(index, (index + 1) , [character]);
    orderCharacterList();
  }

  @action
  Future addCharacter(CharactersCompanion charactersCompanion, int encounterId) async {
    int id = await _db.characterDao.createCharacter(charactersCompanion);
    charactersList.add(
      CharacterWithInfo(
        character: Character(
          id: id, 
          encounter: charactersCompanion.encounter.value, 
          name: charactersCompanion.name.value, 
          initiative: charactersCompanion.initiative.value,
          modifier: charactersCompanion.modifier.value
        ), 
        initiativeWithModifier: 
          (charactersCompanion.initiative.value + charactersCompanion.modifier.value), 
        turn: false
      )
    );
    orderCharacterList();
  }

  //# QUEUE
  @action
  int startQueue() {
    setCurrentTurn(1);
    charactersList[0].turn = true;
    orderCharacterList();
    return 0;
  }

  @action
  int restartQueue() {
    int index = charactersList.indexWhere(
      (c) => c.turn == true
    );
    charactersList[index].turn = false;
    charactersList[0].turn = true;
    setCurrentTurn(1);
    orderCharacterList();
    return 0;
  }

  @action
  int fowardQueue() {
    int index = charactersList.indexWhere(
      (c) => c.turn == true
    );

    //* When the old character is the last in the queue    
    if (index == (charactersList.length - 1)) {
      //* Restart the queue and increment the current turn
      charactersList[index].turn = false;
      index = 0;      
      charactersList[index].turn = true;
      setCurrentTurn((activeEncounter.currentTurn + 1));
    } else {
      charactersList[index].turn = false;
      index = index + 1; 
      charactersList[(index)].turn = true;      
    }
    orderCharacterList();
    return index;
  }

  @action
  int backwardQueue() {
    int index = charactersList.indexWhere(
      (c) => c.turn == true
    );

    //* When the old character is the first in the queue, don't retrocess
    if (index != 0) {      
      charactersList[index].turn = false;
      index = index - 1;
      charactersList[(index)].turn = true;      
    }
    orderCharacterList();    
    return index;
  }
}
