import '../../models/event_model.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  final String _databaseName = "my_database_idsp.db";

  Future<Database> database() async {
    Database database = await _initDatabase();
    return database;
  }

  Future _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);
    return openDatabase(path, version: 1, onCreate: onCreate);
  }

  FutureOr<void> onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE events ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'event_title TEXT, '
        'selected_date TEXT, '
        'start_time TEXT, '
        'end_time TEXT, '
        'descriptions TEXT, '
        'color_red INTEGER, '
        'color_green INTEGER, '
        'color_blue INTEGER, '
        'color_alpha INTEGER)');
  }
}

abstract class EventDbDataSource {
  Future<List<EventModel>> getCurentDbEvent();
  Future<int> addCurentDbEvent(Map<String, dynamic> row);
}

class EventDbDataSourceImpl extends EventDbDataSource {
  final DbService dbClaent = DbService();

  @override
  Future<List<EventModel>> getCurentDbEvent() async {
    final db = await dbClaent.database();
    final query = await db.query('events');
    List<EventModel>? data = query.map((e) => EventModel.fromJson(e)).toList();
    return data;
  }

  @override
  Future<int> addCurentDbEvent(Map<String, dynamic> row) async {
    final db = await dbClaent.database();
    final query = await db.insert('events', row);
    return query;
  }
}
