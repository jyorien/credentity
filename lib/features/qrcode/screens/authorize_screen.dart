import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentity/features/qrcode/qrcode.dart';
import 'package:flutter/material.dart';

class AuthorizeScreen extends StatefulWidget {
  const AuthorizeScreen({
    Key? key,
    required this.record,
  }) : super(key: key);

  final Record record;

  static Route route(Record record) {
    return MaterialPageRoute(
      builder: (_) => AuthorizeScreen(
        record: record,
      ),
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

  final _data = {
    "Personal Information": {
      "Name": "Darren Ong Yan En",
      "Phone Number": "90101010",
    },
    "Medical History": {
      "Vaccination Status": "Vaccinated",
      "Past Records": "NIL",
      "Health Checklist": "NIL",
    },
    "Education": {
      "Primary School": "Saint Andrews Junior School",
      "Secondary School": "Saint Andrews Secondary School",
      "University": "NIL",
      "Masters": "NIL",
      "Certificates (Technical/Non Technical)": "NIL",
    },
    "Work": {
      "Work Attestations by previous employers": "NIL",
    },
    "Disabilities": {
      "Physical Disabilities": "NIL",
      "Mental Disabilities": "NIL",
    },
  };

  void onAuthorizeClick() async {
    await FirebaseFirestore.instance.collection("records").doc(widget.record.uuid).update({
      "verified": Timestamp.now(),
      "data": widget.record.data.map(
        (key, value) => MapEntry(
          key,
          value.map(
            (key2, value) => MapEntry(
              key2,
              _data[key]![key2]!,
            ),
          ),
        ),
      ),
    });

    showDialog(
      context: context,
      builder: (_) {
        return const SuccessDialog();
      },
    ).then((_) {
      Navigator.of(context).pop();
    });
  }

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
                .toList()
              ..removeLast(),
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
                  onPressed: onAuthorizeClick,
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
                  onPressed: Navigator.of(context).pop,
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
