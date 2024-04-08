import 'dart:convert';
import 'package:med_ease/Utils/timeSlot.dart';

import 'ApointmentModifyModule.dart';

import 'dart:convert';
import 'ApointmentModifyModule.dart';

class DoctorModuleE {
  String id;
  String name;
  String bio;
  String phoneNumber;
  String specialist;
  String currentWorkingHospital;
  String profilePic;
  String registerNumbers;
  String experience;
  String emailAddress;
  String age;
  List<dynamic> applicationLeft;
  List<TimeSlotted> timeSlot;

  final String? token;

  DoctorModuleE({
    required this.id,
    required this.name,
    required this.bio,
    required this.phoneNumber,
    required this.specialist,
    required this.currentWorkingHospital,
    required this.profilePic,
    required this.registerNumbers,
    required this.experience,
    required this.emailAddress,
    required this.age,
    required this.applicationLeft,
    required this.timeSlot,
    this.token,
  });

  factory DoctorModuleE.fromMap(Map<String, dynamic> map) {
    return DoctorModuleE(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      bio: map['bio'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      specialist: map['specialist'] ?? '',
      currentWorkingHospital: map['currentWorkingHospital'] ?? '',
      profilePic: map['profilePic'] ?? '',
      registerNumbers: map['registerNumbers'] ?? '',
      experience: map['experience'] ?? '',
      emailAddress: map['emailAddress'] ?? '',
      age: map['age'] ?? '',
      applicationLeft: map['applicationLeft'] ?? [],
      timeSlot: List<TimeSlotted>.from(
          (map['timeSlot'] ?? []).map((x) => TimeSlotted.fromJson(x))),
      token: map['token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'bio': bio,
      'phoneNumber': phoneNumber,
      'specialist': specialist,
      'currentWorkingHospital': currentWorkingHospital,
      'profilePic': profilePic,
      'registerNumbers': registerNumbers,
      'experience': experience,
      'emailAddress': emailAddress,
      'age': age,
      'applicationLeft': applicationLeft,
      'timeSlot': timeSlot.map((x) => x.toMap()).toList(),
      'token': token,
    };
  }

  String toJson() => json.encode(toMap());

  factory DoctorModuleE.fromJson(String source) =>
      DoctorModuleE.fromMap(json.decode(source) as Map<String, dynamic>);
}
