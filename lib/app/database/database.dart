import 'package:initiative_helper/app/database/daos/characters.dart';
import 'package:initiative_helper/app/database/daos/encounters.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'database.moor.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file,logStatements: true);
  });
}

@UseMoor(
  tables: [Encounters,Characters],
  daos:   [EncounterDao, CharacterDao],
  queries: {
    'deleteCharacters' : 'DELETE FROM characters WHERE encounter = ?'
  }
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

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