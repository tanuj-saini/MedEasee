// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModule {
  final String name;
  final String emailAddress;
  final String age;
  final String id;
  final String phoneNumber;
  String? token;
  final String homeAddress;
  final List<dynamic> appointment;
  final List<dynamic> medicalShopHistory;
  final List<dynamic> emergencyCall;
  UserModule({
    required this.name,
    required this.emailAddress,
    required this.age,
    required this.id,
    required this.phoneNumber,
    this.token,
    required this.homeAddress,
    required this.appointment,
    required this.medicalShopHistory,
    required this.emergencyCall,
  });

  UserModule copyWith({
    String? name,
    String? emailAddress,
    String? age,
    String? id,
    String? phoneNumber,
    String? token,
    String? homeAddress,
    List<dynamic>? appointment,
    List<dynamic>? medicalShopHistory,
    List<dynamic>? emergencyCall,
  }) {
    return UserModule(
      name: name ?? this.name,
      emailAddress: emailAddress ?? this.emailAddress,
      age: age ?? this.age,
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      token: token ?? this.token,
      homeAddress: homeAddress ?? this.homeAddress,
      appointment: appointment ?? this.appointment,
      medicalShopHistory: medicalShopHistory ?? this.medicalShopHistory,
      emergencyCall: emergencyCall ?? this.emergencyCall,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'emailAddress': emailAddress,
      'age': age,
      'id': id,
      'phoneNumber': phoneNumber,
      'token': token,
      'homeAddress': homeAddress,
      'appointment': appointment,
      'medicalShopHistory': medicalShopHistory,
      'emergencyCall': emergencyCall,
    };
  }

  factory UserModule.fromMap(Map<String, dynamic> map) {
    return UserModule(
        name: map['name'] as String,
        emailAddress: map['emailAddress'] as String,
        age: map['age'] as String,
        id: map['_id'] as String,
        phoneNumber: map['phoneNumber'] as String,
        token: map['token'] != null ? map['token'] as String : null,
        homeAddress: map['homeAddress'] as String,
        appointment: List<dynamic>.from(
          (map['appointment'] as List<dynamic>),
        ),
        medicalShopHistory: List<dynamic>.from(
          (map['medicalShopHistory'] as List<dynamic>),
        ),
        emergencyCall: List<dynamic>.from(
          (map['emergencyCall'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory UserModule.fromJson(String source) =>
      UserModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModule(name: $name, emailAddress: $emailAddress, age: $age, id: $id, phoneNumber: $phoneNumber, token: $token, homeAddress: $homeAddress, appointment: $appointment, medicalShopHistory: $medicalShopHistory, emergencyCall: $emergencyCall)';
  }

  @override
  bool operator ==(covariant UserModule other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.emailAddress == emailAddress &&
        other.age == age &&
        other.id == id &&
        other.phoneNumber == phoneNumber &&
        other.token == token &&
        other.homeAddress == homeAddress &&
        listEquals(other.appointment, appointment) &&
        listEquals(other.medicalShopHistory, medicalShopHistory) &&
        listEquals(other.emergencyCall, emergencyCall);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        emailAddress.hashCode ^
        age.hashCode ^
        id.hashCode ^
        phoneNumber.hashCode ^
        token.hashCode ^
        homeAddress.hashCode ^
        appointment.hashCode ^
        medicalShopHistory.hashCode ^
        emergencyCall.hashCode;
  }
}
