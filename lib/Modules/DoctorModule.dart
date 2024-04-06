// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class DoctorModule {
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
  final List<dynamic> timeSlot;
  final String id;
  String? token;

  DoctorModule(
    this.name,
    this.bio,
    this.phoneNumber,
    this.specialist,
    this.currentWorkingHospital,
    this.profilePic,
    this.registerNumbers,
    this.experience,
    this.emailAddress,
    this.age,
    this.applicationLeft,
    this.timeSlot,
    this.id,
    this.token,
  );

  DoctorModule copyWith({
    String? name,
    String? bio,
    String? phoneNumber,
    String? specialist,
    String? currentWorkingHospital,
    String? profilePic,
    String? registerNumbers,
    String? experience,
    String? emailAddress,
    String? age,
    List<dynamic>? applicationLeft,
    List<dynamic>? timeSlot,
    String? id,
    String? token,
  }) {
    return DoctorModule(
      name ?? this.name,
      bio ?? this.bio,
      phoneNumber ?? this.phoneNumber,
      specialist ?? this.specialist,
      currentWorkingHospital ?? this.currentWorkingHospital,
      profilePic ?? this.profilePic,
      registerNumbers ?? this.registerNumbers,
      experience ?? this.experience,
      emailAddress ?? this.emailAddress,
      age ?? this.age,
      applicationLeft ?? this.applicationLeft,
      timeSlot ?? this.timeSlot,
      id ?? this.id,
      token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
      'timeSlot': timeSlot,
      'id': id,
      'token': token,
    };
  }

  factory DoctorModule.fromMap(Map<String, dynamic> map) {
    return DoctorModule(
      map['name'] as String,
      map['bio'] as String,
      map['phoneNumber'] as String,
      map['specialist'] as String,
      map['currentWorkingHospital'] as String,
      map['profilePic'] as String,
      map['registerNumbers'] as String,
      map['experience'] as String,
      map['emailAddress'] as String,
      map['age'] as String,
      List<dynamic>.from((map['applicationLeft'] as List<dynamic>)),
      List<dynamic>.from((map['timeSlot'] as List<dynamic>)),
      map['_id'] as String,
      map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModule.fromJson(String source) =>
      DoctorModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DoctorModule(name: $name, bio: $bio, phoneNumber: $phoneNumber, specialist: $specialist, currentWorkingHospital: $currentWorkingHospital, profilePic: $profilePic, registerNumbers: $registerNumbers, experience: $experience, emailAddress: $emailAddress, age: $age, applicationLeft: $applicationLeft, timeSlot: $timeSlot, id: $id, token: $token)';
  }

  @override
  bool operator ==(covariant DoctorModule other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.bio == bio &&
        other.phoneNumber == phoneNumber &&
        other.specialist == specialist &&
        other.currentWorkingHospital == currentWorkingHospital &&
        other.profilePic == profilePic &&
        other.registerNumbers == registerNumbers &&
        other.experience == experience &&
        other.emailAddress == emailAddress &&
        other.age == age &&
        listEquals(other.applicationLeft, applicationLeft) &&
        listEquals(other.timeSlot, timeSlot) &&
        other.id == id &&
        other.token == token;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        bio.hashCode ^
        phoneNumber.hashCode ^
        specialist.hashCode ^
        currentWorkingHospital.hashCode ^
        profilePic.hashCode ^
        registerNumbers.hashCode ^
        experience.hashCode ^
        emailAddress.hashCode ^
        age.hashCode ^
        applicationLeft.hashCode ^
        timeSlot.hashCode ^
        id.hashCode ^
        token.hashCode;
  }
}
