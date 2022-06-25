import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:credentity/models/passport_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PassportDetailsScreen extends StatefulWidget {
  final filePath;

  const PassportDetailsScreen({Key? key, this.filePath}) : super(key: key);

  @override
  State<PassportDetailsScreen> createState() => _PassportDetailsScreenState();
}

class _PassportDetailsScreenState extends State<PassportDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final file = File.fromUri(Uri.file(widget.filePath));
    final base64String = base64Encode(file.readAsBytesSync());

    return FutureBuilder(
        future: http.post(
            Uri.parse(
                "https://3esqrgj3pyb6wjwmo2rswf7ney0bslmd.lambda-url.ap-southeast-1.on.aws/"),
            body: base64String),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
                body: Center(
                    child: SpinKitHourGlass(
              color: Colors.blueAccent,
              size: 50.0,
            )));
          }
          String data = (snapshot.data as http.Response).body;
          Map<String, dynamic> jsonData = json.decode(data);
          final _passportData = PassportData.fromJson(jsonData);
          return Scaffold(
            body: Column(
              children: [
                Text(_passportData.firstName ?? ""),
                Text(_passportData.lastName ?? ""),
                Text(_passportData.passportNumber ?? ""),
                Text(_passportData.sex ?? ""),
                Text(_passportData.dateOfBirth ?? ""),
                Text(_passportData.dateOfExpiration ?? ""),
                Text(_passportData.countryRegion ?? ""),
                Text(_passportData.nationality ?? ""),
              ],
            ),
          );
        });
  }
}
