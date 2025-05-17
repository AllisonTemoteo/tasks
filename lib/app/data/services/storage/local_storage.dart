abstract class LocalStorage<T> {
  T? _database;
  Future<T> get database async => await _initDatabase();

  Future<T> _initDatabase() async {
    return _database ??= await createDatabase();
  }

  Future<T> createDatabase();
}
