import 'package:flutter/material.dart';
import 'package:credentity/providers/user_provider.dart';
import 'package:provider/provider.dart';
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
          padding: EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 12,
              ),
              Image.asset("assets/images/verify.png"),
              Text(
                "Verify your account",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "To ensure that the passport is truly yours, we require a face verification so that we know it is you.",
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "Photo ID",
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Take a photo of your ID, passport or Driver's License",
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(
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
                  child: Text(
                    "Retake Image",
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OcrScanScreen()));
                  },
                ),
              ]),
              SizedBox(
                height: 12.0,
              ),
              Text(
                "Face Verification",
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
              Text(
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
