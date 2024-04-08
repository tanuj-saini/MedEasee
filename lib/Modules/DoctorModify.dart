// import 'dart:convert';

// DoctorModuleE doctorModuleEFromJson(String str) => DoctorModuleE.fromJson(json.decode(str));

// String doctorModuleEToJson(DoctorModuleE data) => json.encode(data.toJson());

// class DoctorModuleE {
//   DoctorModuleE({
//     this.id,
//     this.name,
//     this.bio,
//     this.phoneNumber,
//     this.specialist,
//     this.currentWorkingHospital,
//     this.profilePic,
//     this.registerNumbers,
//     this.experience,
//     this.emailAddress,
//     this.age,
//     this.applicationLeft,
//     this.timeSlot,
//   });

//   String? id;
//   String? name;
//   String? bio;
//   String? phoneNumber;
//   String? specialist;
//   String? currentWorkingHospital;
//   String? profilePic;
//   String? registerNumbers;
//   String? experience;
//   String? emailAddress;
//   String? age;
//   List<dynamic>? applicationLeft;
//   List<TimeSlot>? timeSlot;

//   factory DoctorModuleE.fromJson(Map<String, dynamic> json) => DoctorModuleE(
//         id: json["_id"],
//         name: json["name"],
//         bio: json["bio"],
//         phoneNumber: json["phoneNumber"],
//         specialist: json["specialist"],
//         currentWorkingHospital: json["currentWorkingHospital"],
//         profilePic: json["profilePic"],
//         registerNumbers: json["registerNumbers"],
//         experience: json["experience"],
//         emailAddress: json["emailAddress"],
//         age: json["age"],
//         applicationLeft: List<dynamic>.from(json["applicationLeft"].map((x) => x)),
//         timeSlot: List<TimeSlot>.from(json["timeSlot"].map((x) => TimeSlot.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "bio": bio,
//         "phoneNumber": phoneNumber,
//         "specialist": specialist,
//         "currentWorkingHospital": currentWorkingHospital,
//         "profilePic": profilePic,
//         "registerNumbers": registerNumbers,
//         "experience": experience,
//         "emailAddress": emailAddress,
//         "age": age,
//         "applicationLeft": List<dynamic>.from(applicationLeft!.map((x) => x)),
//         "timeSlot": List<dynamic>.from(timeSlot!.map((x) => x.toJson())),
//       };
// }

// class TimeSlot {
//   TimeSlot({
//     this.appointMentDetails,
//   });

//   List<AppointMentDetail>? appointMentDetails;

//   factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
//         appointMentDetails: List<AppointMentDetail>.from(json["appointMentDetails"].map((x) => AppointMentDetail.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "appointMentDetails": List<dynamic>.from(appointMentDetails!.map((x) => x.toJson())),
//       };
// }

// class AppointMentDetail {
//   AppointMentDetail({
//     this.price,
//     this.title,
//     this.timeSlotPicks,
//   });

//   int? price;
//   String? title;
//   List<TimeSlot>? timeSlotPicks;

//   factory AppointMentDetail.fromJson(Map<String, dynamic> json) => AppointMentDetail(
//         price: json["price"],
//         title: json["title"],
//         timeSlotPicks: List<TimeSlot>.from(json["timeSlotPicks"].map((x) => TimeSlot.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "price": price,
//         "title": title,
//         "timeSlotPicks": List<dynamic>.from(timeSlotPicks!.map((x) => x.toJson())),
//       };
// }

// TimeSlotPick 및 기타 필요한 클래스 구현은 생략되었습니다.

import 'dart:convert';
import 'package:med_ease/Utils/timeSlot.dart';

import 'ApointmentModifyModule.dart';

class DoctorModuleE {
  final String id;
  final String name;
  final String bio;
  final String phoneNumber;
  final String specialist;
  final String currentWorkingHospital;
  final String profilePic;
  final String registerNumbers;
  final String experience;
  final String emailAddress;
  final String age;
  final List<dynamic> applicationLeft;
  final List<AppointmentModule> timeSlot;
  // final List<TimeSlot> time;
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
      timeSlot: (map['timeSlot'] as List<dynamic>?)
              ?.map((x) => AppointmentModule.fromMap(x as Map<String, dynamic>))
              .toList() ??
          [],
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
