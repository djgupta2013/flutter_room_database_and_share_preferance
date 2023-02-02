// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BankDetailsDao? _bankDetailsDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BankDetails` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `itemId` TEXT, `itemValue` TEXT, `itemCode` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BankDetailsDao get bankDetailsDao {
    return _bankDetailsDaoInstance ??=
        _$BankDetailsDao(database, changeListener);
  }
}

class _$BankDetailsDao extends BankDetailsDao {
  _$BankDetailsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _bankDetailsInsertionAdapter = InsertionAdapter(
            database,
            'BankDetails',
            (BankDetails item) => <String, Object?>{
                  'id': item.id,
                  'itemId': item.itemId,
                  'itemValue': item.itemValue,
                  'itemCode': item.itemCode
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BankDetails> _bankDetailsInsertionAdapter;

  @override
  Future<List<BankDetails>> getAllBanks() async {
    return _queryAdapter.queryList('SELECT * FROM BankDetails',
        mapper: (Map<String, Object?> row) => BankDetails(
            row['itemId'] as String?,
            row['id'] as int?,
            row['itemValue'] as String?,
            row['itemCode'] as String?));
  }

  @override
  Stream<List<BankDetails>> getAllBanksAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM BankDetails',
        mapper: (Map<String, Object?> row) => BankDetails(
            row['itemId'] as String?,
            row['id'] as int?,
            row['itemValue'] as String?,
            row['itemCode'] as String?),
        queryableName: 'BankDetails',
        isView: false);
  }

  @override
  Future<void> saveBankDetails(List<BankDetails> bankDetails) async {
    await _bankDetailsInsertionAdapter.insertList(
        bankDetails, OnConflictStrategy.abort);
  }

  @override
  Future<void> saveBankDetail(BankDetails bankDetails) async {
    await _bankDetailsInsertionAdapter.insert(
        bankDetails, OnConflictStrategy.abort);
  }
}
