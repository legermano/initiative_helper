import 'package:initiative_helper/app/database/database.dart';
import 'package:moor/moor.dart';

part 'encounters.moor.dart';

class Encounters extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text().named('desc')();
}

@UseDao(tables: [Encounters])
class EncounterDao  extends DatabaseAccessor<AppDatabase> with _$EncounterDaoMixin {
  final AppDatabase db;

  EncounterDao(this.db) : super(db);

  Future<int> createEncounter(String description) {
    return into(encounters).insert(EncountersCompanion(description: Value(description)));
  }

  Future deleteEncounter(Encounter encounter) {
    return transaction(() async {
      await db.deleteCharacters(encounter.id);
      await delete(encounters).delete(encounter);
    });
  }

  Future<List<Encounter>> allEncounters() {
    return select(encounters).get();
  }

  Future<Encounter> getEncounter(int id) {
    return (select(encounters)..where((e) => e.id.equals(id))).getSingle();
  }
  
}