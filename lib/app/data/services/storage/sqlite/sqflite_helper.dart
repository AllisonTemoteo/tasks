import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tasks/app/data/services/storage/local_storage.dart';
import 'package:tasks/app/data/services/storage/sqlite/sqlite_migrate.dart';

class SqfliteDesktopHelper extends LocalStorage<Database> {
  @override
  Future<Database> createDatabase() {
    sqfliteFfiInit();

    String dir = '';
    String path = '';

    dir = join(Directory.current.path, 'data');
    path = join(dir, 'data.db');

    Directory(dir).createSync(recursive: true);

    return databaseFactoryFfi.openDatabase(
      path,
      options: OpenDatabaseOptions(version: 1, onCreate: _onCreate),
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.transaction(_execInitialScript);
  }

  Future<dynamic> _execInitialScript(Transaction db) async {
    await db.execute(SqliteMigrate.initialScript);
  }
}
