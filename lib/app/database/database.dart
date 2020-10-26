import 'package:initiative_helper/app/database/daos/characters.dart';
import 'package:initiative_helper/app/database/daos/encounters.dart';
import 'package:initiative_helper/utils/enums/conditions.dart';
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
      onUpgrade: (m, from, to) async{
        if (from == 1) {
          await m.addColumn(characters, characters.condition);
          await m.addColumn(characters, characters.armorClass);
          await m.addColumn(characters, characters.maxHealthPoints);
          await m.addColumn(characters, characters.currentHealthPoints);          
                            
          await customStatement('UPDATE characters SET condition = 8 WHERE condition IS NULL');
        }
      },
    );
  }

  @override
  int get schemaVersion => 2;
}