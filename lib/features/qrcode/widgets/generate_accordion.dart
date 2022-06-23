import 'package:flutter/material.dart';

class GenerateAccordion extends StatelessWidget {
  const GenerateAccordion({
    Key? key,
    required this.icon,
    required this.title,
    required this.fields,
    required this.onFieldChange,
  }) : super(key: key);

  final IconData icon;

  final String title;

  final Map<String, bool> fields;

  final Function(String) onFieldChange;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
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
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 28, bottom: 8, left: 66),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Column(
                children: [
                  for (final field in fields.keys)
                    ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.only(left: 16),
                      title: Text(
                        field,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      trailing: Switch.adaptive(
                        activeColor: Theme.of(context).primaryColor,
                        value: fields[field]!,
                        onChanged: (_) => onFieldChange(field),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
