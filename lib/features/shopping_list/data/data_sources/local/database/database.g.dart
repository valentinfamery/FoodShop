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
            'CREATE TABLE IF NOT EXISTS `ProductFoodShop` (`barcodeId` INTEGER, `imageFrontUrl` TEXT, `isBuy` INTEGER, `weight` TEXT, `quantity` INTEGER, `nameLanguages` TEXT, PRIMARY KEY (`barcodeId`))');

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
        _productFoodShopInsertionAdapter = InsertionAdapter(
            database,
            'ProductFoodShop',
            (ProductFoodShop item) => <String, Object?>{
                  'barcodeId': item.barcodeId,
                  'imageFrontUrl': item.imageFrontUrl,
                  'isBuy': item.isBuy == null ? null : (item.isBuy! ? 1 : 0),
                  'weight': item.weight,
                  'quantity': item.quantity,
                  'nameLanguages': _mapConverter.encode(item.nameLanguages)
                },
            changeListener),
        _productFoodShopUpdateAdapter = UpdateAdapter(
            database,
            'ProductFoodShop',
            ['barcodeId'],
            (ProductFoodShop item) => <String, Object?>{
                  'barcodeId': item.barcodeId,
                  'imageFrontUrl': item.imageFrontUrl,
                  'isBuy': item.isBuy == null ? null : (item.isBuy! ? 1 : 0),
                  'weight': item.weight,
                  'quantity': item.quantity,
                  'nameLanguages': _mapConverter.encode(item.nameLanguages)
                },
            changeListener),
        _productFoodShopDeletionAdapter = DeletionAdapter(
            database,
            'ProductFoodShop',
            ['barcodeId'],
            (ProductFoodShop item) => <String, Object?>{
                  'barcodeId': item.barcodeId,
                  'imageFrontUrl': item.imageFrontUrl,
                  'isBuy': item.isBuy == null ? null : (item.isBuy! ? 1 : 0),
                  'weight': item.weight,
                  'quantity': item.quantity,
                  'nameLanguages': _mapConverter.encode(item.nameLanguages)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductFoodShop> _productFoodShopInsertionAdapter;

  final UpdateAdapter<ProductFoodShop> _productFoodShopUpdateAdapter;

  final DeletionAdapter<ProductFoodShop> _productFoodShopDeletionAdapter;

  @override
  Stream<List<ProductFoodShop>> getAllProductFloor() {
    return _queryAdapter.queryListStream('SELECT * FROM ProductFoodShop',
        mapper: (Map<String, Object?> row) => ProductFoodShop(
            row['barcodeId'] as int?,
            _mapConverter.decode(row['nameLanguages'] as String?),
            row['imageFrontUrl'] as String?,
            row['isBuy'] == null ? null : (row['isBuy'] as int) != 0,
            row['weight'] as String?,
            row['quantity'] as int?),
        queryableName: 'ProductFoodShop',
        isView: false);
  }

  @override
  Future<ProductFoodShop?> getProductFloorById(int barcodeId) async {
    return _queryAdapter.query(
        'SELECT * FROM ProductFoodShop WHERE barcodeId = ?1',
        mapper: (Map<String, Object?> row) => ProductFoodShop(
            row['barcodeId'] as int?,
            _mapConverter.decode(row['nameLanguages'] as String?),
            row['imageFrontUrl'] as String?,
            row['isBuy'] == null ? null : (row['isBuy'] as int) != 0,
            row['weight'] as String?,
            row['quantity'] as int?),
        arguments: [barcodeId]);
  }

  @override
  Stream<ProductFoodShop?> getStreamProductFloorById(int barcodeId) {
    return _queryAdapter.queryStream(
        'SELECT * FROM ProductFoodShop WHERE barcodeId = ?1',
        mapper: (Map<String, Object?> row) => ProductFoodShop(
            row['barcodeId'] as int?,
            _mapConverter.decode(row['nameLanguages'] as String?),
            row['imageFrontUrl'] as String?,
            row['isBuy'] == null ? null : (row['isBuy'] as int) != 0,
            row['weight'] as String?,
            row['quantity'] as int?),
        arguments: [barcodeId],
        queryableName: 'ProductFoodShop',
        isView: false);
  }

  @override
  Future<void> insertProductFloor(ProductFoodShop productFloor) async {
    await _productFoodShopInsertionAdapter.insert(
        productFloor, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateProductFloor(ProductFoodShop productFloor) async {
    await _productFoodShopUpdateAdapter.update(
        productFloor, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteProductFloor(ProductFoodShop productFloor) async {
    await _productFoodShopDeletionAdapter.delete(productFloor);
  }
}

// ignore_for_file: unused_element
final _mapConverter = MapConverter();
