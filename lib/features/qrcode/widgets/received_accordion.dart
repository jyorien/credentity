import 'package:flutter/material.dart';

class ReceivedAccordion extends StatelessWidget {
  const ReceivedAccordion({
    Key? key,
    required this.icon,
    required this.title,
    required this.fields,
  }) : super(key: key);

  final IconData icon;

  final String title;

  final Map<String, String?> fields;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ListTileTheme(
          horizontalTitleGap: 8,
          child: ExpansionTile(
            leading: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // This is to make sure the width is maxed out. The default is wrap
              const SizedBox(width: double.infinity),
              Container(
                padding: const EdgeInsets.only(left: 56),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: fields.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 1, right: 12, bottom: 1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "•  ",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Colors.black,
                                    ),
                                children: [
                                  TextSpan(
                                    text: entry.key + ": ",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  TextSpan(
                                    text: fields[entry.key] ?? "281 Singapore, Punggol ",
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
