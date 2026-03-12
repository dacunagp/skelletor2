import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/models.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'collector.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE programs (
        id INTEGER PRIMARY KEY,
        name TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE stations (
        id INTEGER PRIMARY KEY,
        name TEXT,
        latitude REAL,
        longitude REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE program_stations (
        program_id INTEGER,
        station_id INTEGER,
        PRIMARY KEY (program_id, station_id),
        FOREIGN KEY (program_id) REFERENCES programs (id),
        FOREIGN KEY (station_id) REFERENCES stations (id)
      )
    ''');
  }

  Future<void> syncData(Map<String, dynamic> jsonData) async {
    final db = await database;

    await db.transaction((txn) async {
      final List<dynamic> campanas = jsonData['campanas'] ?? [];

      for (var campanaJson in campanas) {
        final program = Program.fromJson(campanaJson);
        await txn.insert(
          'programs',
          program.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        final List<dynamic> estaciones = campanaJson['estaciones'] ?? [];
        for (var estacionJson in estaciones) {
          final station = Station.fromJson(estacionJson);
          await txn.insert(
            'stations',
            station.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );

          await txn.insert(
            'program_stations',
            {
              'program_id': program.id,
              'station_id': station.id,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }
    });
  }

  Future<List<Program>> getPrograms() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('programs');
    return List.generate(maps.length, (i) {
      return Program(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  Future<List<Station>> getStationsByProgram(int programId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT s.* FROM stations s
      INNER JOIN program_stations ps ON s.id = ps.station_id
      WHERE ps.program_id = ?
    ''', [programId]);

    return List.generate(maps.length, (i) {
      return Station(
        id: maps[i]['id'],
        name: maps[i]['name'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
      );
    });
  }
}
