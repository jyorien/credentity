import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentity/features/qrcode/qrcode.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class GenerateChoose extends StatefulWidget {
  const GenerateChoose({
    Key? key,
    required this.setRecord,
  }) : super(key: key);

  final Function(Record) setRecord;

  @override
  State<GenerateChoose> createState() => _GenerateChooseState();
}

class _GenerateChooseState extends State<GenerateChoose> {
  final _icons = {
    "Personal Information": Icons.person,
    "Medical History": Icons.vaccines,
    "Education": Icons.school,
    "Work": Icons.work,
    "Disabilities": Icons.accessible,
  };

  final _data = {
    "Personal Information": {
      "Name": true,
      "Phone Number": true,
    },
    "Medical History": {
      "Vaccination Status": false,
      "Past Records": false,
      "Health Checklist": false,
    },
    "Education": {
      "Primary School": false,
      "Secondary School": false,
      "University": false,
      "Masters": false,
      "Certificates (Technical/Non Technical)": false,
    },
    "Work": {
      "Work Attestations by previous employers": false,
    },
    "Disabilities": {
      "Physical Disabilities": false,
      "Mental Disabilities": false,
    },
  };

  void handleNextClick() async {
    final record = Record(
      uuid: const Uuid().v4(),
      expires: Timestamp.fromDate(
        DateTime.now().add(const Duration(minutes: 5)),
      ),
      verified: null,
      data: Map.fromEntries(
        _data.entries
            .map(
              (entry) => MapEntry(
                entry.key,
                Map.fromEntries(
                  entry.value.entries.where((entry) => entry.value).map(
                        (entry) => MapEntry(entry.key, null),
                      ),
                ),
              ),
            )
            .where((entry) => entry.value.isNotEmpty),
      ),
    );

    await FirebaseFirestore.instance.collection("records").doc(record.uuid).set(record.toJson());

    widget.setRecord(record);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._data.keys
            .map<Widget>((key) {
              return GenerateAccordion(
                icon: _icons[key]!,
                title: key,
                fields: _data[key]!,
                onFieldChange: (field) {
                  setState(() {
                    _data[key]![field] = !_data[key]![field]!;
                  });
                },
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
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: const Text(
            "Prevent QR Code from Expiring",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          subtitle: const Text(
            "*This option is currently disabled as you are not an authorized company or user",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
          trailing: Switch.adaptive(
            activeColor: Theme.of(context).primaryColor,
            value: false,
            onChanged: (_) {},
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 32,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              onPressed: handleNextClick,
              child: const Text("Next"),
            ),
          ),
        ),
      ],
    );
  }
}
