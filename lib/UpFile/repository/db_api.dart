import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbArchivos {
  DbArchivos._();
  static final DbArchivos bd = DbArchivos._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Archivos.db");
    return await openDatabase(path,
        version: 1, onOpen: (db) {}, onCreate: _createTables);
  }

  void _createTables(Database db, int version) async {
    await db.execute("CREATE TABLE Archivos ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "NombreArchivo VARCHAR(35) NOT NULL,"
        "archivo BLOB NOT NULL,"
        "CONSTRAINT id_unique UNIQUE (id))");
  }

  newArchivos(Archivos newArchivos) async {
    final db = await database;

    // var res = await db.insert("Archivos", newArchivos.toMap());

    var res = await db.rawInsert(
        "INSERT INTO Archivos (NombreArchivo, archivo)"
        " VALUES (?,?)",
        [newArchivos.NombreArchivo, newArchivos.archivo]);

    return res;
  }

  getDatos() async {
    final db = await database;

    // var res = await db.insert("Archivos", newArchivos.toMap());
    final List<Map<String, dynamic>> list = await db.query('Archivos');
    return [list, list.length];
  }
}

Archivos tasksFromJson(String str) {
  final jsonData = json.decode(str);
  return Archivos.fromMap(jsonData);
}

String tasksToJson(Archivos data) {
  final dyn = data.toMap();
  return jsonEncode(dyn);
}

class Archivos {
  String NombreArchivo;
  String archivo;

  Archivos({this.NombreArchivo, this.archivo});

  factory Archivos.fromMap(Map<String, dynamic> json) => new Archivos(
        NombreArchivo: json["NombreArchivo"].toString(),
        archivo: json["archivo"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "NombreArchivo": NombreArchivo,
        "archivo": archivo,
      };
}
