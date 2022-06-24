import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentity/features/qrcode/qrcode.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AuthorizeScreen extends StatefulWidget {
  AuthorizeScreen({Key? key}) : super(key: key);

  final record = Record(
    uuid: const Uuid().v4(),
    expires: Timestamp.now(),
    data: {
      "Personal Information": {
        "Name": null,
        "Phone Number": null,
      },
      "Medical History": {
        "Vaccination Status": null,
        "Past Records": null,
        "Health Checklist": null,
      },
      "Education": {
        "Primary School": null,
        "Secondary School": null,
        "University": null,
        "Masters": null,
        "Certificates (Technical/Non Technical)": null,
      },
      "Work": {
        "Work Attestations by previous employers": null,
      },
      "Disabilities": {
        "Physical Disabilities": null,
        "Mental Disabilities": null,
      },
    },
  );

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => AuthorizeScreen(),
    );
  }

  @override
  State<AuthorizeScreen> createState() => _AuthorizeScreenState();
}

class _AuthorizeScreenState extends State<AuthorizeScreen> {
  final _icons = {
    "Personal Information": Icons.person,
    "Medical History": Icons.vaccines,
    "Education": Icons.school,
    "Work": Icons.work,
    "Disabilities": Icons.accessible,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          splashRadius: 20,
          onPressed: Navigator.of(context).pop,
        ),
        title: const Text(
          "Are you sure?",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/darren.png",
                        width: 72,
                        height: 72,
                      ),
                      const SizedBox(height: 8),
                      const Text("Darren Ong")
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/arrow.png",
                        width: 50,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/ibm.png",
                        width: 72,
                        height: 72,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text("IBM"),
                          const SizedBox(width: 2),
                          Icon(Icons.verified, color: Theme.of(context).primaryColor),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "IBM Pte Ltd",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text("will need these information"),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...widget.record.data.keys
                .map((key) {
                  return AuthorizeAccordion(
                    icon: _icons[key]!,
                    title: key,
                    fields: widget.record.data[key]!,
                  );
                })
                .map((val) => [
                      val,
                      const Divider(height: 1),
                    ])
                .expand((widgets) => widgets)
                .take(9)
                .toList(),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 32,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Authorize"),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 32,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFFF5A43),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Terminate"),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
