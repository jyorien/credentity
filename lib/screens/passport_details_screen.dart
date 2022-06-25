import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:credentity/models/passport_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:credentity/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:credentity/screens/verify_steps_screen.dart';

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
    final _firstNameController = TextEditingController();
    final _lastNameController = TextEditingController();
    final _passportNumberController = TextEditingController();
    final _sexController = TextEditingController();
    final _dobController = TextEditingController();
    final _doeController = TextEditingController();
    final _countryController = TextEditingController();
    final _nationalityController = TextEditingController();
    return FutureBuilder(
        future: http.post(
            Uri.parse(
                "https://dy5fhp4lctrfz6oszozwnwfbrq0kjrfp.lambda-url.ap-southeast-1.on.aws/"),
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
          _firstNameController.text = _passportData.firstName ?? "";
          _lastNameController.text = _passportData.lastName ?? "";
          _passportNumberController.text = _passportData.passportNumber ?? "";
          _sexController.text = _passportData.sex ?? "";
          _dobController.text = _passportData.dateOfBirth ?? "";
          _doeController.text = _passportData.dateOfExpiration ?? "";
          _countryController.text = _passportData.countryRegion ?? "";
          _nationalityController.text = _passportData.nationality ?? "";
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            onPressed: () {
                              _firstNameController.text = "";
                            },
                          ),
                          labelText: 'First Name',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            onPressed: () {
                              _lastNameController.text = "";
                            },
                          ),
                          labelText: 'Last Name',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _sexController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            onPressed: () {
                              _sexController.text = "";
                            },
                          ),
                          labelText: 'Sex',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _dobController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            onPressed: () {
                              _dobController.text = "";
                            },
                          ),
                          labelText: 'Date of Birth',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _doeController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            onPressed: () {
                              _doeController.text = "";
                            },
                          ),
                          labelText: 'Date of Expiration',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _countryController,
                        decoration: InputDecoration(
                          labelText: 'Country Region',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            onPressed: () {
                              _countryController.text = "";
                            },
                          ),
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _nationalityController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            onPressed: () {
                              _nationalityController.text = "";
                            },
                          ),
                          labelText: 'Nationality',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _passportNumberController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            onPressed: () {
                              _nationalityController.text = "";
                            },
                          ),
                          labelText: 'Passport Number',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              UserProvider userProvider =
                                  Provider.of<UserProvider>(context,
                                      listen: false);
                              final finalPassportData = PassportData();
                              finalPassportData.firstName =
                                  _firstNameController.text;
                              finalPassportData.lastName =
                                  _lastNameController.text;
                              finalPassportData.dateOfBirth =
                                  _dobController.text;
                              finalPassportData.dateOfExpiration =
                                  _doeController.text;
                              finalPassportData.sex = _sexController.text;
                              finalPassportData.countryRegion =
                                  _countryController.text;
                              finalPassportData.passportNumber =
                                  _passportNumberController.text;
                              finalPassportData.nationality =
                                  _nationalityController.text;
                              userProvider.setPassportData(finalPassportData);
                              userProvider.setPassportPhotoFile(file);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => VerifyStepsScreen()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Text(
                                "Save Information",
                                style: TextStyle(color: Colors.white),
                              ),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(67, 77, 255, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                            ),
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          IconButton(
                            icon: Icon(Icons.restart_alt),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
