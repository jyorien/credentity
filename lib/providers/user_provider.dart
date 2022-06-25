import 'package:flutter/foundation.dart';
import 'package:credentity/models/passport_data.dart';
import 'dart:io';

class UserProvider extends ChangeNotifier {
  PassportData _passportData = PassportData();
  PassportData get passportData => _passportData;

  File _passportPhotoFile = File.fromUri(Uri());
  File get passportPhotoFile => _passportPhotoFile;

  File _faceFile = File.fromUri(Uri());
  File get faceFile => _faceFile;

  setPassportData(PassportData data) {
    _passportData = data;
    notifyListeners();
  }

  setPassportPhotoFile(File photo) {
    _passportPhotoFile = photo;
    notifyListeners();
  }

  setFace(File photo) {
    _faceFile = photo;
    notifyListeners();
  }
}
