import 'dart:convert';

class UserModuleE {
  String id;
  String name;
  String emailAddress;
  String age;
  String phoneNumber;
  String homeAddress;
  List<Appointment> appointment;
  List<dynamic> medicalShopHistory;
  List<dynamic> emergencyCall;

  UserModuleE({
    required this.id,
    required this.name,
    required this.emailAddress,
    required this.age,
    required this.phoneNumber,
    required this.homeAddress,
    required this.appointment,
    required this.medicalShopHistory,
    required this.emergencyCall,
  });

  factory UserModuleE.fromJson(Map<String, dynamic> json) {
    return UserModuleE(
      id: json['_id'],
      name: json['name'],
      emailAddress: json['emailAddress'],
      age: json['age'],
      phoneNumber: json['phoneNumber'],
      homeAddress: json['homeAddress'],
      appointment: json['appointment'] != null && json['appointment'] is List
          ? (json['appointment'] as List)
              .map((a) => Appointment.fromJson(a))
              .toList()
          : [],
      medicalShopHistory: json['medicalShopHistory'] ?? [],
      emergencyCall: json['emergencyCall'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'emailAddress': emailAddress,
      'age': age,
      'phoneNumber': phoneNumber,
      'homeAddress': homeAddress,
      'appointment':
          appointment.map((appointment) => appointment.toJson()).toList(),
      'medicalShopHistory': medicalShopHistory,
      'emergencyCall': emergencyCall,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModuleE.fromMap(Map<String, dynamic> map) {
    return UserModuleE.fromJson(map);
  }
}

class Appointment {
  String? doctorId;
  List<AppointmentLeft>? apppointLeft;
  String? id;

  Appointment({this.doctorId, this.apppointLeft, this.id});

  Appointment.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    if (json['apppointLeft'] != null) {
      apppointLeft = <AppointmentLeft>[];
      json['apppointLeft'].forEach((v) {
        apppointLeft!.add(new AppointmentLeft.fromJson(v));
      });
    }
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorId'] = this.doctorId;
    if (this.apppointLeft != null) {
      data['apppointLeft'] = this.apppointLeft!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.id;
    return data;
  }
}

class AppointmentLeft {
  String? date;
  String? doctorId;
  String? userId;
  bool? isComplete;
  String? id;

  AppointmentLeft({
    this.date,
    this.doctorId,
    this.userId,
    this.isComplete,
    this.id,
  });

  AppointmentLeft.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    doctorId = json['doctorId'];
    userId = json['userId'];
    isComplete = json['isComplete'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['doctorId'] = this.doctorId;
    data['userId'] = this.userId;
    data['isComplete'] = this.isComplete;
    data['_id'] = this.id;

    return data;
  }
}
