class PassportData {
  final String? firstName;
  final String? lastName;
  final String? passportNumber;
  final String? sex;
  final String? dateOfBirth;
  final String? dateOfExpiration;
  final String? countryRegion;
  final String? nationality;

  const PassportData(
      {this.firstName,
      this.lastName,
      this.passportNumber,
      this.sex,
      this.dateOfBirth,
      this.dateOfExpiration,
      this.countryRegion,
      this.nationality});

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
