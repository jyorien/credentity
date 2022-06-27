import 'dart:convert';
import 'dart:io';

import 'package:credentity/features/ocr/ocr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PassportDetailsScreen extends StatelessWidget {
  const PassportDetailsScreen({
    Key? key,
    required this.filePath,
  }) : super(key: key);

  final String filePath;

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final passportNumberController = TextEditingController();
    final sexController = TextEditingController();
    final dobController = TextEditingController();
    final doeController = TextEditingController();
    final countryController = TextEditingController();
    final nationalityController = TextEditingController();

    final file = File.fromUri(Uri.file(filePath));
    final base64String = base64Encode(file.readAsBytesSync());

    return FutureBuilder(
      future: http.post(
        Uri.parse(
          "https://dy5fhp4lctrfz6oszozwnwfbrq0kjrfp.lambda-url.ap-southeast-1.on.aws/",
        ),
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

        firstNameController.text = passportData.firstName;
        lastNameController.text = passportData.lastName;
        passportNumberController.text = passportData.passportNumber;
        sexController.text = passportData.sex;
        dobController.text = passportData.dateOfBirth;
        doeController.text = passportData.dateOfExpiration;
        countryController.text = passportData.countryRegion;
        nationalityController.text = passportData.nationality;

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
                    controller: firstNameController,
                  ),
                  const SizedBox(height: 16),
                  customTextFormField(
                    labelText: "Last Name",
                    controller: lastNameController,
                  ),
                  const SizedBox(height: 16),
                  customTextFormField(
                    labelText: "Sex",
                    controller: sexController,
                  ),
                  const SizedBox(height: 16),
                  customTextFormField(
                    labelText: "Date of Birth",
                    controller: dobController,
                  ),
                  const SizedBox(height: 16),
                  customTextFormField(
                    labelText: "Date of Expiration",
                    controller: doeController,
                  ),
                  const SizedBox(height: 16),
                  customTextFormField(
                    labelText: "Country Region",
                    controller: countryController,
                  ),
                  const SizedBox(height: 16),
                  customTextFormField(
                    labelText: "Nationality",
                    controller: nationalityController,
                  ),
                  const SizedBox(height: 16),
                  customTextFormField(
                    labelText: "Passport Number",
                    controller: passportNumberController,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          final userProvider = context.read<UserProvider>();
                          final finalPassportData = PassportData(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            dateOfBirth: dobController.text,
                            dateOfExpiration: doeController.text,
                            sex: sexController.text,
                            countryRegion: countryController.text,
                            passportNumber: passportNumberController.text,
                            nationality: nationalityController.text,
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
                        onPressed: Navigator.of(context).pop,
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
