class PassportData {
  String? firstName;
  String? lastName;
  String? passportNumber;
  String? sex;
  String? dateOfBirth;
  String? dateOfExpiration;
  String? countryRegion;
  String? nationality;

  PassportData(
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
