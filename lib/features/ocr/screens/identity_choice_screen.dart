import 'package:flutter/material.dart';
import 'ocr_scan_screen.dart';

class IdentityChoiceScreen extends StatelessWidget {
  const IdentityChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_back),
              const SizedBox(
                height: 12,
              ),
              Image.asset("assets/images/identity_proof_image.png"),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Proof of identity",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              const Flexible(
                child: Text(
                  "We need to see your name clearly printed on an official document or passport",
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "TYPES OF ID YOU CAN UPLOAD",
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 6,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const OcrScanScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text("Passport"),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 6.0),
                          child: const Text(
                            "Recommended",
                            style: TextStyle(
                                color: Color.fromRGBO(232, 222, 248, 1),
                                fontSize: 12.0),
                          ),
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(122, 122, 122, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                        )
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16.0,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Driver's License"),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.0,
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("National ID"),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.0,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
