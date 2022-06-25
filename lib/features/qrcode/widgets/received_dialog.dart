import 'package:credentity/features/qrcode/qrcode.dart';
import 'package:flutter/material.dart';

class ReceivedDialog extends StatelessWidget {
  const ReceivedDialog({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, Map<String, String?>> data;

  @override
  Widget build(BuildContext context) {
    final icons = {
      "Personal Information": Icons.person,
      "Medical History": Icons.vaccines,
      "Education": Icons.school,
      "Work": Icons.work,
      "Disabilities": Icons.accessible,
    };

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: (MediaQuery.of(context).size.width - 325) / 2,
        vertical: (MediaQuery.of(context).size.height - 576 - 60 - kToolbarHeight) / 2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            color: Colors.transparent,
            child: Container(
              width: 325,
              height: 576,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 56),
                    Image.asset(
                      "assets/images/darren.png",
                      width: 106,
                      height: 106,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Darren Ong",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Text(
                      "has shared selected information with you",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 48),
                    ...data.keys
                        .map<Widget>((key) {
                          return ReceivedAccordion(
                            icon: icons[key]!,
                            title: key,
                            fields: data[key]!,
                          );
                        })
                        .map((val) => [
                              val,
                              const Divider(height: 1),
                            ])
                        .expand((widgets) => widgets)
                        .toList()
                      ..removeLast(),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: Navigator.of(context).pop,
            child: const Icon(
              Icons.cancel,
              color: Color(0xFFD9D9D9),
              size: 38,
            ),
          ),
        ],
      ),
    );
  }
}
