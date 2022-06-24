import 'package:flutter/material.dart';

class AuthorizeAccordion extends StatelessWidget {
  const AuthorizeAccordion({
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
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
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
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Text(
                    "•  " + entry.key,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
