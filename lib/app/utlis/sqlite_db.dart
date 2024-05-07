import 'package:cooler_mdlz/app/utlis/sqlite_helper.dart';
import 'package:cooler_mdlz/common/common.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDb {
  static Future<void> initDatabase() async {
    await deleteDatabase();
    await openDatabase(version: databaseVersion);
    await createTable();
    await closeDatabase();
  }

  static Future<Database> openDatabase({
    int? version = databaseVersion,
    OnDatabaseConfigureFn? onConfigure,
    OnDatabaseCreateFn? onCreate,
    OnDatabaseVersionChangeFn? onUpgrade,
    OnDatabaseVersionChangeFn? onDowngrade,
    OnDatabaseOpenFn? onOpen,
    bool readOnly = false,
    bool singleInstance = true
  }) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);
    final options = OpenDatabaseOptions(
        version: version,
        onConfigure: onConfigure,
        onCreate: onCreate,
        onUpgrade: onUpgrade,
        onDowngrade: onDowngrade,
        onOpen: onOpen,
        readOnly: readOnly,
        singleInstance: singleInstance);
    return databaseFactory.openDatabase(path, options: options);
  }

  static Future<void> closeDatabase() async {
    Database db = await openDatabase();
    db.close();
  }

  static Future<void> deleteDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);
    var db = await databaseFactory.openDatabase(path);
    if (await db.getVersion() < databaseVersion) {
      db.close();
      databaseFactory.deleteDatabase(path);
    }
  }

  static Future<bool> databaseExists() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);
    return await databaseFactory.databaseExists(path);
  }

  static Future<void> createTable() async {
    final db = await openDatabase();
    final outletDetailTable = await tableExist(tableName: SqliteHelper.tableOutletDetail);
    if(outletDetailTable == false) {
      await db.execute(SqliteHelper.createOutletDetailTable);
    }
    final stockTable = await tableExist(tableName: SqliteHelper.tableStock);
    if(stockTable == false) {
      await db.execute(SqliteHelper.createStockTable);
    }
    final stockCountTable = await tableExist(tableName: SqliteHelper.tableStockCount);
    if(stockCountTable == false) {
      await db.execute(SqliteHelper.createStockCountTable);
    }
    final scanTable = await tableExist(tableName: SqliteHelper.tableScan);
    if(scanTable == false) {
      await db.execute(SqliteHelper.createScanTable);
    }
    final hotZoneTable = await tableExist(tableName: SqliteHelper.tableHotZone);
    if(hotZoneTable == false) {
      await db.execute(SqliteHelper.createHotZoneTable);
    }
    final questionTable = await tableExist(tableName: SqliteHelper.tableQuestion);
    if(questionTable == false) {
      await db.execute(SqliteHelper.createQuestionTable);
    }
    final maintenanceTable = await tableExist(tableName: SqliteHelper.tableMaintenance);
    if(maintenanceTable == false) {
      await db.execute(SqliteHelper.createMaintenanceTable);
    }
    db.close();
  }

  static Future<bool> tableExist({
    required String tableName,
  }) async {
    Database db = await openDatabase();
    var tables = await db.rawQuery('SELECT * FROM sqlite_master WHERE name="$tableName";');
    return tables.isNotEmpty;
  }

  // Get record
  static Future<List<dynamic>> getRecords({
    String? query,
    String? tableName,
    String? where,  /// where : 'id = ?'
    List<dynamic>? whereArgs,
    int? limit,
  }) async {
    final db = await openDatabase();
    dynamic record;
    if(query?.isNotEmpty ?? false) {
        record = await db.rawQuery(query!);
        print('Get record: $record');
    }
    else if((tableName?.isNotEmpty ?? false) && where != null && whereArgs != null){
      record = await db.query(
        tableName!,
        where: where,
        whereArgs: whereArgs,
        limit: limit,
      );
      print('Get record: $tableName');
    }
    else if(tableName?.isNotEmpty ?? false){
      record = await db.query(tableName!);
      print('Deleted all record: $tableName');
    }
    // db.close();
    return record;
  }

  // Insert record
  static Future<int> insertRecord({
    String? query,
    String? tableName,
    Map<String, dynamic>? maps,
  }) async {
    final db = await openDatabase();
    int record = -1;
    if(query?.isNotEmpty ?? false) {
      await db.transaction((txn) async {
        record = await txn.rawInsert(query!);
        print('Insert record: $record');
      });
    }
    else if((maps?.isNotEmpty ?? false) || (tableName?.isNotEmpty ?? false)){
      record = await db.insert(
        tableName!,
        maps!,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Insert record: $tableName');
    }
    db.close();
    return record;
  }

  static Future<void> updateRecord({
    String? query,
    String? tableName,
    Map<String, dynamic>? maps,
    String where = '',  /// where : 'id = ?'
    List<dynamic> whereArgs = const [],
  }) async {
    final db = await openDatabase();
    if(query?.isNotEmpty ?? false) {
      await db.transaction((txn) async {
        int update = await db.rawUpdate(query!);
        print('Updated record: $tableName');
      });
    }
    else if((maps?.isNotEmpty ?? false) || (tableName?.isNotEmpty ?? false)){
      int update = await db.update(
        tableName!,
        maps!,
        where: where,
        whereArgs: whereArgs,
      );
      print('Updated record: $tableName');
    }
    db.close();
  }

  static Future<bool> deleteRecord({
    String? query,
    String? tableName,
    String? where,   /// where : 'id = ?'
    List<dynamic>? whereArgs,
  }) async {
    final db = await openDatabase();
    if(query?.isNotEmpty ?? false) {
      /// query : 'DELETE FROM Test WHERE name = ?', ['another name']
      await db.rawDelete(query!);
      print('Deleted record: $tableName');
    }
    else if((tableName?.isNotEmpty ?? false) && (where != null || whereArgs != null)){
      int delete = await db.delete(
        tableName!,
        where: where,
        whereArgs: whereArgs,
      );
      print('Deleted record: $tableName');
    }
    else if(tableName?.isNotEmpty ?? false){
      int delete = await db.delete(tableName!);
      print('Deleted all record: $tableName');
    }
    db.close();
    return true;
  }

  static Future<void> clearAllTable() async {
    final db = await openDatabase();
    await db.delete(SqliteHelper.tableOutletDetail);
    await db.delete(SqliteHelper.tableStock);
    await db.delete(SqliteHelper.tableStockCount);
    await db.delete(SqliteHelper.tableScan);
    await db.delete(SqliteHelper.tableQuestion);
    await db.delete(SqliteHelper.tableHotZone);
    await db.delete(SqliteHelper.tableMaintenance);
    db.close();
  }

}
