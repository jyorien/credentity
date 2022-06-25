class PassportData {
  final String firstName;
  final String lastName;
  final String passportNumber;
  final String sex;
  final String dateOfBirth;
  final String dateOfExpiration;
  final String countryRegion;
  final String nationality;

  const PassportData({
    required this.firstName,
    required this.lastName,
    required this.passportNumber,
    required this.sex,
    required this.dateOfBirth,
    required this.dateOfExpiration,
    required this.countryRegion,
    required this.nationality,
  });

  factory PassportData.fromJson(Map<String, dynamic> json) => PassportData(
      firstName: json["FirstName"],
      lastName: json["LastName"],
      passportNumber: json["DocumentNumber"],
      sex: json["Sex"],
      dateOfBirth: json["DateOfBirth"],
      dateOfExpiration: json["DateOfExpiration"],
      countryRegion: json["CountryRegion"],
      nationality: json["Nationality"]);
}
