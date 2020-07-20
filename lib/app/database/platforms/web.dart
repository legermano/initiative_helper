import 'package:moor/moor_web.dart';

import '../database.dart';

AppDatabase constructDb({bool logStatements = true}) {
  return AppDatabase(WebDatabase('db', logStatements: logStatements));
}
