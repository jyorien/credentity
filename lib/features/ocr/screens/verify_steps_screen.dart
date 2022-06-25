import 'package:credentity/features/ocr/ocr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyStepsScreen extends StatelessWidget {
  const VerifyStepsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: Navigator.of(context).pop,
                ),
                const SizedBox(height: 12),
                Image.asset("assets/images/verify.png"),
                const Text(
                  "Verify your account",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "To ensure that the passport is truly yours, we require a face verification so that we know it is you.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Photo ID",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Take a photo of your ID, passport or Driver's License",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Image.file(userProvider.passportPhotoFile),
                    ),
                    TextButton(
                      child: const Text(
                        "Retake Image",
                        style: TextStyle(color: Colors.deepPurpleAccent),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const OcrScanScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  "Face Verification",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Take a selfie of yourself with your IC held at chest level",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
