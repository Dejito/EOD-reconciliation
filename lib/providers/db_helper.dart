import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelperPOS {

  static Future<Database> database() async{
    WidgetsFlutterBinding.ensureInitialized();
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'increase.db'),
        onCreate: (db, version){
          return db.execute('CREATE TABLE user_increase(id TEXT PRIMARY KEY, increaseAmount DOUBLE)');
        }, version: 1);
  }

  static Future<void> insert (String table, Map<String, Object?> data) async {
    final sqlDb = await DBHelperPOS.database();
    sqlDb.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }
  static Future<List<Map<String, dynamic>>> getData( String table) async{
    final sqlDb =  await DBHelperPOS.database();
    return sqlDb.query(table);
  }
}


class DBHelperTransfer {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
        path.join(dbPath, 'transfer.db'), onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE transfer_increase(id TEXT PRIMARY KEY, increaseAmount DOUBLE)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelperTransfer.database();
    db.insert(table, data);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqDb = await DBHelperTransfer.database();
    return sqDb.query(table);
  }

}

 class DBHelperDeposit {

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'deposit.db'),
        onCreate: (db, version){
          return db.execute('CREATE TABLE deposit_increase(id TEXT PRIMARY KEY, increaseAmount DOUBLE)');
        }, version: 1
    );
 }

  static void insert(String table, Map<String, dynamic> data) async{
    final sqlDb = await DBHelperDeposit.database();
    sqlDb.insert(table, data);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDb = await DBHelperDeposit.database();
    return sqlDb.query(table);
  }
 }

 class DBHelperProfit {

 static Future<Database> database() async{
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'userProfit.db'),
        onCreate: (db, version){
          return db.execute(
              'CREATE TABLE userProfit(id TEXT PRIMARY KEY, increaseAmount DOUBLE)'
          );
        }, version: 1
    );
  }


  static void insert (String table, Map<String, dynamic> data) async {
  final db = await DBHelperProfit.database();
  db.insert(table, data);
  }

  static Future<List<Map<String, dynamic>>> getData (String table) async {
    final db = await DBHelperProfit.database();
    return db.query(table);
  }
 }