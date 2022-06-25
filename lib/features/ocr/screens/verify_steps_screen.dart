import 'package:credentity/features/ocr/ocr.dart';
import 'package:credentity/features/ocr/screens/selfie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class VerifyStepsScreen extends StatelessWidget {
  const VerifyStepsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: Navigator.of(context).pop,
                ),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/icons/green_cam.svg"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        const SizedBox(
                          height: 12,
                        ),
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
                                style:
                                    TextStyle(color: Colors.deepPurpleAccent),
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
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  userProvider.faceFile != null
                      ? SvgPicture.asset("assets/icons/green_cam.svg")
                      : SvgPicture.asset("assets/icons/red_cam.svg"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      userProvider.faceFile != null
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 100,
                                  child: Image.file(userProvider.faceFile!),
                                ),
                                TextButton(
                                  child: const Text(
                                    "Retake Image",
                                    style: TextStyle(
                                        color: Colors.deepPurpleAccent),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SelfieScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          : Row(
                              children: const [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 2.0,
                                ),
                                Text(
                                  "Image has not been taken",
                                  style: TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SelfieScreen(),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        child: const Text(
                          "Proceed",
                          style: TextStyle(color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(67, 77, 255, 1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
