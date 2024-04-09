import 'dart:convert';

class UserModuleE {
  String id;
  String name;
  String emailAddress;
  String age;
  String phoneNumber;
  String homeAddress;
  List<Appointment> appointments;
  List<dynamic> medicalShopHistory;
  List<dynamic> emergencyCall;

  UserModuleE({
    required this.id,
    required this.name,
    required this.emailAddress,
    required this.age,
    required this.phoneNumber,
    required this.homeAddress,
    required this.appointments,
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
      appointments: json['appointments'] != null && json['appointments'] is List
          ? (json['appointments'] as List)
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
      'appointments':
          appointments.map((appointment) => appointment.toJson()).toList(),
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
  String id;
  String doctorId;
  List<AppointmentDetails> appointLeft;

  Appointment({
    required this.id,
    required this.doctorId,
    required this.appointLeft,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'],
      doctorId: json['doctorId'],
      appointLeft: (json['appointLeft'] as List)
          .map((al) => AppointmentDetails.fromJson(al))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'doctorId': doctorId,
      'appointLeft': appointLeft.map((al) => al.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}

class AppointmentDetails {
  String date;
  String doctorId;
  String userId;
  bool isComplete;
  String id;

  AppointmentDetails({
    required this.date,
    required this.doctorId,
    required this.userId,
    required this.isComplete,
    required this.id,
  });

  factory AppointmentDetails.fromJson(Map<String, dynamic> json) {
    return AppointmentDetails(
      date: json['date'],
      doctorId: json['doctorId'],
      userId: json['userId'],
      isComplete: json['isComplete'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'doctorId': doctorId,
      'userId': userId,
      'isComplete': isComplete,
      '_id': id,
    };
  }

  String toJson() => json.encode(toMap());
}
