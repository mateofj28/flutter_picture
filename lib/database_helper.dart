import 'dart:async';
import 'package:flutter_picture/models/photo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class PhotoDatabase {
  static final _databaseName = 'photos.db';

  Database? _database;

  Future<void> _initDatabase() async {
    if (_database == null) {
      final dbPath = await getApplicationDocumentsDirectory();
      final path = '${dbPath.path}/$_databaseName';
      _database = await openDatabase(path);
      await _createPhotoTable();
    }
  }

  Future<void> _createPhotoTable() async {
    await _database!.execute('''
      CREATE TABLE IF NOT EXISTS photos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        path TEXT UNIQUE
      )
    ''');
  }

  Future<void> addPhoto(Photo photo) async {
    await _initDatabase();
    await _database!.insert('photos', {
      'path': photo.url
    });
  }

  Future<List<Photo>> getPhotos() async {
    await _initDatabase();
    final photosData = await _database!.query('photos');
    return photosData.map((photo) => Photo.fromMap(photo)).toList();
  }

  Future<void> deletePhoto(Photo photo) async {
    await _initDatabase();
    await _database!.delete('photos', where: 'id = ?', whereArgs: [photo.id]);
  }
}
