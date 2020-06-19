import 'package:initiative_helper/app/database/database.dart';
import 'package:moor/moor.dart';

part 'characters.moor.dart';

class Characters extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get encounter => integer().customConstraint('NULL REFERENCES encounters(id)')();
  TextColumn get name => text()();
  IntColumn get initiative => integer()();
  IntColumn get modifier => integer().nullable()(); 
}

@UseDao(tables: [Characters])
class CharacterDao extends DatabaseAccessor<AppDatabase> with _$CharacterDaoMixin {
  final AppDatabase db;

  CharacterDao(this.db) : super(db);

  Future createCharacter(CharactersCompanion character) {
    return into(characters).insert(character);
  }

  Future updateCharacter(Character character) {
    return update(characters).replace(character);
  }

  Future deleteCharacter(Character character) {
    return delete(characters).delete(character);
  }
  
  Future<List<Character>> charactersInEncounter (Encounter encounter) {
    final query = select(characters).join(
      [leftOuterJoin(db.encounters, db.encounters.id.equalsExp(characters.encounter))]
    );

    query.where(db.encounters.id.equals(encounter.id));

    // return query.watch().map((rows) {
    //   return rows.map((rows) {
    //     return Character(id: null, encounter: null, name: null, initiative: null);
    //   }).toList();
    // });

    return query.map((row) {
      return row.readTable(characters);
      // Character.fromData(row.rawData.data, db);
    }).get();
  }
  
}