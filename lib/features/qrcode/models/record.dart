import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  const Record({
    required this.uuid,
    required this.expires,
    required this.data,
  });

  final String uuid;

  final Timestamp expires;

  final Map<String, Map<String, String>> data;

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "expires": expires,
        "data": data,
      };

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        uuid: json["uuid"] as String,
        expires: json["expires"] as Timestamp,
        data: json["data"] as Map<String, Map<String, String>>,
      );
}
