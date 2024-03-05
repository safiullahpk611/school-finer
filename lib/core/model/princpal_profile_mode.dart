class PrincpalProfileModel {
  String? appUserId;
  String? principalName;
  String? cnic;
  String? phoneNumber;
  String? schoolRegNo;
  String? schoolName;

  PrincpalProfileModel(
      {this.appUserId,
      this.principalName,
      this.cnic,
      this.phoneNumber,
      this.schoolName,
      this.schoolRegNo});
  PrincpalProfileModel.fromJson(json, id) {
    appUserId = id;
    principalName = json['principalName'];

    cnic = json['cnic'] ?? '';

    phoneNumber = json['phoneNumber'];
    schoolName = json['schoolName'];
    schoolRegNo = json['schoolRegNo'];
    phoneNumber = json['phoneNumber'] ?? '';
  }
  toJson() {
    return {
      'appUserId': appUserId,
      'principalName': principalName,
      'cnic': cnic,
      'phoneNumber': phoneNumber,
      'schoolName': schoolName,
      'schoolRegNo': schoolRegNo,
    };
  }
}
