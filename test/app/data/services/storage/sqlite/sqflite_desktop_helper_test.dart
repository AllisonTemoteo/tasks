import 'dart:io';

import 'package:test/test.dart';
import 'package:path/path.dart';
import 'package:tasks/app/data/services/storage/sqlite/sqflite_helper.dart';

void main() {
  group('SqfliteDesktopHelper: ', () {
    late SqfliteDesktopHelper sqfliteDesktopHelper;

    setUp(() {
      sqfliteDesktopHelper = SqfliteDesktopHelper();
    });

    test(
      'should create a singleton for the database var and create the database file',
      () async {
        final instance1 = await SqfliteDesktopHelper().database;
        final instance2 = await SqfliteDesktopHelper().database;

        expect(instance1, same(instance2));

        final path = join(Directory.current.path, 'data', 'data.db');
        expect(File(path).existsSync(), isTrue);
      },
    );

    test('should create a database with basic structure', () async {
      final database = await sqfliteDesktopHelper.database;

      final tables = await database.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table';",
      );

      expect(tables.isNotEmpty, true);

      await database.close();
    });
  });

  tearDown(() {
    final dataDirectory = Directory(join(Directory.current.path, 'data'));
    if (dataDirectory.existsSync()) {
      dataDirectory.deleteSync(recursive: true);
    }
  });
}
