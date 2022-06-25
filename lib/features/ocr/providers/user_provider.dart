import 'dart:io';

import 'package:credentity/features/ocr/ocr.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  PassportData _passportData = const PassportData(
    firstName: "",
    lastName: "",
    passportNumber: "",
    sex: "",
    dateOfBirth: "",
    dateOfExpiration: "",
    countryRegion: "",
    nationality: "",
  );
  PassportData get passportData => _passportData;

  File _passportPhotoFile = File.fromUri(Uri());
  File get passportPhotoFile => _passportPhotoFile;

  File? _faceFile;
  File? get faceFile => _faceFile;

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
