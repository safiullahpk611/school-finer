class SchoolRegModel {
  String? princpalId;
  String? schoolName;
  String? schoolAddress;
  String? statusOfSchool;
  String? religionSpecificity;

  String? teacherQualificationPrimary;
  String? teacherQualificationHigh;
  String? quranAndHifzAvailability;
  String? thermalFacility;
  List<String>? schoolImagesUrl;
  String? doctorFacility;

  String? transportFacility;
  String? fundsCriteria;
  String? scholarshipCriteria;

  List<String>? pastMatriculationImages;
  List<int>? pastMatriculationMarks;
  String? schoolGuzzartCode;
  List<String>? availableTimeSlot;

  SchoolRegModel({
    this.schoolName,
    this.schoolAddress,
    this.statusOfSchool,
    this.princpalId,
    this.religionSpecificity,
    this.teacherQualificationPrimary,
    this.teacherQualificationHigh,
    this.quranAndHifzAvailability,
    this.thermalFacility,
    this.schoolImagesUrl,
    this.doctorFacility,
    this.transportFacility,
    this.fundsCriteria,
    this.scholarshipCriteria,
    this.pastMatriculationImages,
    this.pastMatriculationMarks,
    this.schoolGuzzartCode,
    this.availableTimeSlot,
  });

  SchoolRegModel.fromJson(json, id) {
    princpalId = id;
    schoolName:
    json['schoolName'];
    schoolAddress:
    json['schoolAddress'];
    statusOfSchool:
    json['statusOfSchool'];
    religionSpecificity:
    json['religionSpecificity'];
    teacherQualificationPrimary:
    json['teacherQualificationPrimary'];
    teacherQualificationHigh:
    json['teacherQualificationHigh'];
    quranAndHifzAvailability:
    json['quranAndHifzAvailability'];
    thermalFacility:
    json['thermalFacility'];
    schoolImagesUrl:
    List<String>.from(json['schoolImagesUrl']);
    doctorFacility:
    json['doctorFacility'];
    transportFacility:
    json['transportFacility'];
    fundsCriteria:
    json['fundsCriteria'];
    scholarshipCriteria:
    json['scholarshipCriteria'];
    pastMatriculationImages:
    List<String>.from(json['pastMatriculationImages']);
    pastMatriculationMarks:
    List<int>.from(json['pastMatriculationMarks']);
    schoolGuzzartCode:
    json['schoolGuzzartCode'];
    availableTimeSlot:
    List<String>.from(json['availableTimeSlot']);
  }
  toJson() {
    return {
      'princpalId': princpalId,
      'schoolName': schoolName,
      'schoolAddress': schoolAddress,
      'statusOfSchool': statusOfSchool,
      'religionSpecificity': religionSpecificity,
      'teacherQualificationPrimary': teacherQualificationPrimary,
      'teacherQualificaitonHigh': teacherQualificationHigh,
      'quranAndHifzAvailability': quranAndHifzAvailability,
      'thermalFacility': thermalFacility,
      'schoolImagesUrl': schoolImagesUrl,
      'doctorFacility': doctorFacility,
      'transportFacility': transportFacility,
      'fundsCriteria': fundsCriteria,
      'scholarshipCriteria': scholarshipCriteria,
      'pastMatriculationImages': pastMatriculationImages,
      'pastMatriculationMarks': pastMatriculationMarks,
      'schoolGuzzartCode': schoolGuzzartCode,
      'availableTimeSlot': availableTimeSlot,
    };
  }

  //SchoolRegModel({});
}
