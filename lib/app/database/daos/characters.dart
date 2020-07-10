import 'package:initiative_helper/app/database/database.dart';
import 'package:initiative_helper/utils/enums/conditions.dart';
import 'package:moor/moor.dart';

part 'characters.moor.dart';

class Characters extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get encounter => integer().customConstraint('NULL REFERENCES encounters(id)')();
  TextColumn get name => text()();
  IntColumn get initiative => integer()();
  IntColumn get modifier => integer().nullable()(); 
  IntColumn get condition => intEnum<Conditions>().clientDefault(() => 8)(); //Default is Conditions.normal
  IntColumn get armorClass => integer().nullable()();
  IntColumn get maxHealthPoints => integer().nullable()();
  IntColumn get currentHealthPoints => integer().nullable()();
}

@UseDao(tables: [Characters])
class CharacterDao extends DatabaseAccessor<AppDatabase> with _$CharacterDaoMixin {
  final AppDatabase db;

  CharacterDao(this.db) : super(db);

  Future<int> createCharacter(CharactersCompanion character) {
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

    return query.map((row) {
      return row.readTable(characters);
    }).get();
  }
  
}