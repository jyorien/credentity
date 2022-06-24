import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  const Record({
    required this.uuid,
    required this.expires,
    required this.verified,
    required this.data,
  });

  final String uuid;

  final Timestamp expires;

  final Timestamp? verified;

  final Map<String, Map<String, String?>> data;

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "expires": expires,
        "verified": verified,
        "data": data,
      };

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        uuid: json["uuid"] as String,
        expires: json["expires"] as Timestamp,
        verified: json["verified"] as Timestamp?,
        data: (json["data"] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            (value as Map<String, dynamic>).map(
              (key, value) => MapEntry(key, value as String?),
            ),
          ),
        ),
      );
}
