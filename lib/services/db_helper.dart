import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:api_sqflite/model/usermodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database database;
  static final DBProvider dbProvider = DBProvider();

  DBProvider();

  static const String userId = 'userId';
  static const String ids = 'id';
  static const String Title = 'title';
  static const String Table = 'Users';
  static const String DB_Name = 'users_db';

  Future<Database> get checkDatabase async {
    if (database != null) {
      print('Database name --> $database');
      print('Database open --> ${database.isOpen}');
      return database;
    } else {
      database = await createDatabase();
      return database;
    }
  }

  createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final databasePath = join(directory.path, DB_Name);

    final db = await openDatabase(databasePath, version: 1, onCreate: onCreate);
    return db;
  }

  FutureOr<void> onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $Table ($userId INTEGER, $ids INTEGER, $Title TEXT)');
  }

  Future<int> addUser(UserModel userModel) async {
    try {
      Database dbClient = await checkDatabase;
      final int result = await dbClient.insert(Table, userModel.toJson());
      print('Add user result : $result');
      return result;
    } catch (e) {
      print('Catch error in addUser --> $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAllUserMap() async {
    try {
      Database dbClient = await checkDatabase;
      final List<Map<String, dynamic>> result = await dbClient.query(Table);
      print('Get all user map result : ${jsonEncode(result)}');
      return result;
    } catch (e) {
      print('Catch error in getAllUserMap --> $e');
      return null;
    }
  }

  Future<List<UserModel>> getAllUserList() async {
    try {
      final List<Map<String, dynamic>> userMapList = await getAllUserMap();
      List<UserModel> userList = [];
      userMapList.forEach((userMap) {
        userList.add(UserModel.fromJson(userMap));
      });
      userList.sort((userA, userB) => userA.id.compareTo(userB.id));
      print('Get all user list result : $userList');
      return userList;
    } catch (e) {
      print('Catch error in getAllUserList --> $e');
      return null;
    }
  }

  Future<int> deleteUser(int id) async {
    try {
      Database dbClient = await checkDatabase;
      final int result =
          await dbClient.delete(Table, where: '$ids = ?', whereArgs: [id]);
      print('Delete user result : $result');
      return result;
    } catch (e) {
      print('Catch error in deleteUser --> $e');
      return null;
    }
  }
}
