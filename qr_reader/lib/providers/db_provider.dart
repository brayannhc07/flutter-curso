import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    // Path de donde almacenaremos el DB

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'ScansDB.db');
    print(path);

    // Crear Base de Datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        )
      ''');
    });
  }

  Future<int> nuevoScanRaw(ScanModel newScan) async {
    final id = newScan.id;
    final tipo = newScan.tipo;
    final valor = newScan.valor;

    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
        VALUES ( $id, '$tipo', '$valor')
    ''');

    return res;
  }

  Future<int> nuevoScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.insert('Scans', newScan.toJson());
    print(res);
    return res;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getScans() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<List<ScanModel>> getScansByTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.update('Scans', newScan.toJson(),
        where: 'id = ?', whereArgs: [newScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }
}
