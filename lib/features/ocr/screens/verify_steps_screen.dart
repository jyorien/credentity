import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'ocr_scan_screen.dart';

class VerifyStepsScreen extends StatelessWidget {
  const VerifyStepsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 12,
              ),
              Image.asset("assets/images/verify.png"),
              const Text(
                "Verify your account",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const Text(
                "To ensure that the passport is truly yours, we require a face verification so that we know it is you.",
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Photo ID",
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Take a photo of your ID, passport or Driver's License",
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                  height: 100.0,
                  child: Image.file(
                    userProvider.passportPhotoFile,
                  ),
                ),
                TextButton(
                  child: const Text(
                    "Retake Image",
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const OcrScanScreen()));
                  },
                ),
              ]),
              const SizedBox(
                height: 12.0,
              ),
              const Text(
                "Face Verification",
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Take a selfie of yourself with your IC held at chest level",
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
