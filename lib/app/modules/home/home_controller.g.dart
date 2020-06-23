// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$charactersListAtom = Atom(name: '_HomeControllerBase.charactersList');

  @override
  ObservableList<CharacterWithInfo> get charactersList {
    _$charactersListAtom.reportRead();
    return super.charactersList;
  }

  @override
  set charactersList(ObservableList<CharacterWithInfo> value) {
    _$charactersListAtom.reportWrite(value, super.charactersList, () {
      super.charactersList = value;
    });
  }

  final _$encountersListAtom = Atom(name: '_HomeControllerBase.encountersList');

  @override
  ObservableFuture<List<Encounter>> get encountersList {
    _$encountersListAtom.reportRead();
    return super.encountersList;
  }

  @override
  set encountersList(ObservableFuture<List<Encounter>> value) {
    _$encountersListAtom.reportWrite(value, super.encountersList, () {
      super.encountersList = value;
    });
  }

  final _$activeEncounterAtom =
      Atom(name: '_HomeControllerBase.activeEncounter');

  @override
  CurrentEncounter get activeEncounter {
    _$activeEncounterAtom.reportRead();
    return super.activeEncounter;
  }

  @override
  set activeEncounter(CurrentEncounter value) {
    _$activeEncounterAtom.reportWrite(value, super.activeEncounter, () {
      super.activeEncounter = value;
    });
  }

  final _$deleteEncounterAsyncAction =
      AsyncAction('_HomeControllerBase.deleteEncounter');

  @override
  Future<dynamic> deleteEncounter(Encounter encounter) {
    return _$deleteEncounterAsyncAction
        .run(() => super.deleteEncounter(encounter));
  }

  final _$addEncounterAsyncAction =
      AsyncAction('_HomeControllerBase.addEncounter');

  @override
  Future<int> addEncounter(String description) {
    return _$addEncounterAsyncAction.run(() => super.addEncounter(description));
  }

  final _$deleteCharacterAsyncAction =
      AsyncAction('_HomeControllerBase.deleteCharacter');

  @override
  Future<dynamic> deleteCharacter(CharacterWithInfo character) {
    return _$deleteCharacterAsyncAction
        .run(() => super.deleteCharacter(character));
  }

  final _$updateCharacterAsyncAction =
      AsyncAction('_HomeControllerBase.updateCharacter');

  @override
  Future<dynamic> updateCharacter(CharacterWithInfo character) {
    return _$updateCharacterAsyncAction
        .run(() => super.updateCharacter(character));
  }

  final _$addCharacterAsyncAction =
      AsyncAction('_HomeControllerBase.addCharacter');

  @override
  Future<dynamic> addCharacter(
      CharactersCompanion charactersCompanion, int encounterId) {
    return _$addCharacterAsyncAction
        .run(() => super.addCharacter(charactersCompanion, encounterId));
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void setActiveEncouter(int id, String description) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setActiveEncouter');
    try {
      return super.setActiveEncouter(id, description);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> getEncounters() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.getEncounters');
    try {
      return super.getEncounters();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void orderCharacterList() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.orderCharacterList');
    try {
      return super.orderCharacterList();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startQueue() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.startQueue');
    try {
      return super.startQueue();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fowardQueue() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.fowardQueue');
    try {
      return super.fowardQueue();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void backwardQueue() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.backwardQueue');
    try {
      return super.backwardQueue();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
charactersList: ${charactersList},
encountersList: ${encountersList},
activeEncounter: ${activeEncounter}
    ''';
  }
}
