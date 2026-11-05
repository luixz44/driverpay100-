import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  /// Obtém a instância ativa da base de dados (equivale ao `get_db`)[cite: 17]
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Inicializa o ficheiro `.db` no armazenamento interno do Android
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'driverapp.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  /// Executa a criação inicial das tabelas[cite: 17]
  Future<void> _onCreate(Database db, int version) async {
    try {
      // Exemplo de criação das tabelas locais para cache
      await db.execute('''
        CREATE TABLE vehicles (
          id INTEGER PRIMARY KEY,
          model TEXT NOT NULL,
          license_plate TEXT NOT NULL
        )
      ''');
      print("Tabelas da base de dados sincronizadas com sucesso!");[cite: 17]
    } catch (e) {
      print("Erro ao sincronizar tabelas: $e");[cite: 17]
    }
  }

  /// Fecha a ligação com a base de dados
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}



import 'database_helper.dart';

class LocalVehicleRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> insertVehicle(Map<String, dynamic> vehicleData) async {
    final db = await _dbHelper.database;
    await db.insert(
      'vehicles',
      vehicleData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getVehicles() async {
    final db = await _dbHelper.database;
    return await db.query('vehicles');
  }
}