import 'package:initiative_helper/app/database/daos/characters.dart';
import 'package:initiative_helper/app/database/daos/encounters.dart';
import 'package:moor/moor.dart';

part 'database.moor.dart';

@UseMoor(
  tables: [Encounters,Characters],
  daos:   [EncounterDao, CharacterDao],
  queries: {
    'deleteCharacters' : 'DELETE FROM characters WHERE encounter = ?'
  }
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override  
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) {
        return m.createAll();
      },
    );
  }

  @override
  int get schemaVersion => 1;
}