abstract class SqliteMigrate {
  static const String initialScript = '''
CREATE TABLE task (
    taskId INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    isDone BOOLEAN NOT NULL DEFAULT 0
);
''';
}
