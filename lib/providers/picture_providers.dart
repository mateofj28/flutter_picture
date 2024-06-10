

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_picture/database_helper.dart';
import 'package:flutter_picture/models/photo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PictureProviders extends ChangeNotifier {

  final _photoDatabase = PhotoDatabase();
  List<Photo> _photos = [];

  List<Photo> get photos => _photos;

  Future<String?> _savePhoto(File file) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = '${appDocDir.path}/$fileName';
    if (await file.copy(filePath) != null) {
      return filePath;
    }
    return null;
  }

  Future<void> loadPhotos() async {
    _photos = await _photoDatabase.getPhotos();
    notifyListeners();
  }


  Future<void> addPhoto(Photo photo) async {
    await _photoDatabase.addPhoto(photo);
    notifyListeners();
  }

  takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null){
      print("se tomo una foto");
      final file = File(pickedFile.path);
      final photoPath = await _savePhoto(file);

      if (photoPath != null){
        final photo = Photo(url: photoPath);
        print("se agrego la foto"); 
        addPhoto(photo);
        print("trayendo fotos de la base de datos");
        loadPhotos();
        print("tamaño de las lista");
        print(photos.length);
      }

    }
  }

}