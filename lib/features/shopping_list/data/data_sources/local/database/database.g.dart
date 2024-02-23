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

  ProductFloorDao? _productFloorDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Product` (`barcodeId` INTEGER, `name` TEXT, `isSaved` INTEGER, `imageFrontUrl` TEXT, PRIMARY KEY (`barcodeId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductFloorDao get productFloorDao {
    return _productFloorDaoInstance ??=
        _$ProductFloorDao(database, changeListener);
  }
}

class _$ProductFloorDao extends ProductFloorDao {
  _$ProductFloorDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _productInsertionAdapter = InsertionAdapter(
            database,
            'Product',
            (Product item) => <String, Object?>{
                  'barcodeId': item.barcodeId,
                  'name': item.name,
                  'isSaved':
                      item.isSaved == null ? null : (item.isSaved! ? 1 : 0),
                  'imageFrontUrl': item.imageFrontUrl
                },
            changeListener),
        _productDeletionAdapter = DeletionAdapter(
            database,
            'Product',
            ['barcodeId'],
            (Product item) => <String, Object?>{
                  'barcodeId': item.barcodeId,
                  'name': item.name,
                  'isSaved':
                      item.isSaved == null ? null : (item.isSaved! ? 1 : 0),
                  'imageFrontUrl': item.imageFrontUrl
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Product> _productInsertionAdapter;

  final DeletionAdapter<Product> _productDeletionAdapter;

  @override
  Stream<List<Product>> getAllProductFloor() {
    return _queryAdapter.queryListStream('SELECT * FROM Product',
        mapper: (Map<String, Object?> row) => Product(
            row['barcodeId'] as int?,
            row['name'] as String?,
            row['isSaved'] == null ? null : (row['isSaved'] as int) != 0,
            row['imageFrontUrl'] as String?),
        queryableName: 'Product',
        isView: false);
  }

  @override
  Future<Product?> getProductFloorById(int barcodeId) async {
    return _queryAdapter.query('SELECT * FROM Product WHERE barcodeId = ?1',
        mapper: (Map<String, Object?> row) => Product(
            row['barcodeId'] as int?,
            row['name'] as String?,
            row['isSaved'] == null ? null : (row['isSaved'] as int) != 0,
            row['imageFrontUrl'] as String?),
        arguments: [barcodeId]);
  }

  @override
  Future<void> insertProductFloor(Product productFloor) async {
    await _productInsertionAdapter.insert(
        productFloor, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteProductFloor(Product productFloor) async {
    await _productDeletionAdapter.delete(productFloor);
  }
}
