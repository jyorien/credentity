import 'dart:convert';
import 'dart:io';

import 'package:credentity/features/ocr/ocr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../constants.dart';

class PassportDetailsScreen extends StatefulWidget {
  const PassportDetailsScreen({
    Key? key,
    required this.filePath,
  }) : super(key: key);

  final String filePath;

  @override
  State<PassportDetailsScreen> createState() => _PassportDetailsScreenState();
}

class _PassportDetailsScreenState extends State<PassportDetailsScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passportNumberController = TextEditingController();
  final _sexController = TextEditingController();
  final _dobController = TextEditingController();
  final _doeController = TextEditingController();
  final _countryController = TextEditingController();
  final _nationalityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final file = File.fromUri(Uri.file(widget.filePath));
    final base64String = base64Encode(file.readAsBytesSync());

    return FutureBuilder(
      future: http.post(
        Uri.parse(
            "https://dy5fhp4lctrfz6oszozwnwfbrq0kjrfp.lambda-url.ap-southeast-1.on.aws/"),
        body: base64String,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: SpinKitHourGlass(
                color: Colors.blueAccent,
                size: 50,
              ),
            ),
          );
        }

        String data = (snapshot.data as http.Response).body;
        final passportData = PassportData.fromJson(json.decode(data));

        _firstNameController.text = passportData.firstName;
        _lastNameController.text = passportData.lastName;
        _passportNumberController.text = passportData.passportNumber;
        _sexController.text = passportData.sex;
        _dobController.text = passportData.dateOfBirth;
        _doeController.text = passportData.dateOfExpiration;
        _countryController.text = passportData.countryRegion;
        _nationalityController.text = passportData.nationality;

        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customTextFormField(
                      labelText: "First Name",
                      controller: _firstNameController),
                  const SizedBox(height: 16),
                  customTextFormField(
                      labelText: "Last Name", controller: _lastNameController),
                  const SizedBox(height: 16),
                  customTextFormField(
                      labelText: "Sex", controller: _sexController),
                  const SizedBox(height: 16),
                  customTextFormField(
                      labelText: "Date of Birth", controller: _dobController),
                  const SizedBox(height: 16),
                  customTextFormField(
                      labelText: "Date of Expiration",
                      controller: _doeController),
                  const SizedBox(height: 16),
                  customTextFormField(
                      labelText: "Country Region",
                      controller: _countryController),
                  const SizedBox(height: 16),
                  customTextFormField(
                      labelText: "Nationality",
                      controller: _nationalityController),
                  const SizedBox(height: 16),
                  customTextFormField(
                      labelText: "Passport Number",
                      controller: _passportNumberController),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          UserProvider userProvider =
                              context.read<UserProvider>();
                          final finalPassportData = PassportData(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            dateOfBirth: _dobController.text,
                            dateOfExpiration: _doeController.text,
                            sex: _sexController.text,
                            countryRegion: _countryController.text,
                            passportNumber: _passportNumberController.text,
                            nationality: _nationalityController.text,
                          );

                          userProvider.setPassportData(finalPassportData);
                          userProvider.setPassportPhotoFile(file);

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const VerifyStepsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: const Text(
                            "Save Information",
                            style: TextStyle(color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(67, 77, 255, 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),
                      IconButton(
                        icon: const Icon(Icons.restart_alt),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
