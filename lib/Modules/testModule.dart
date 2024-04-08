import 'dart:convert'; // Add this import statement

class Doctor {
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
  List<TimeSlot> timeSlot;
  final String? token;

  Doctor({
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

  factory Doctor.fromJson(Map<String, dynamic> json) {
    List<TimeSlot> timeSlots = [];

    if (json['timeSlot'] != null) {
      timeSlots = List<TimeSlot>.from(
        json['timeSlot'].map((x) => TimeSlot.fromJson(x)),
      );
    }

    return Doctor(
      id: json['_id'],
      name: json['name'],
      bio: json['bio'],
      phoneNumber: json['phoneNumber'],
      specialist: json['specialist'],
      currentWorkingHospital: json['currentWorkingHospital'],
      profilePic: json['profilePic'],
      registerNumbers: json['registerNumbers'],
      experience: json['experience'],
      emailAddress: json['emailAddress'],
      age: json['age'],
      applicationLeft: json['applicationLeft'] ?? [],
      timeSlot: timeSlots,
      token: json['token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
      'timeSlot': timeSlot.map((slot) => slot.toMap()).toList(),
      'token': token,
    };
  }

  String toJson() => json.encode(toMap());

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor.fromJson(map);
  }
}

class TimeSlot {
  List<AppointmentDetails> appointmentDetails;

  TimeSlot({
    required this.appointmentDetails,
  });
  Map<String, dynamic> toJson() {
    return {
      'appointmentDetails':
          appointmentDetails.map((detail) => detail.toJson()).toList(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'appointmentDetails':
          appointmentDetails.map((detail) => detail.toMap()).toList(),
    };
  }

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    List<AppointmentDetails> appointments = [];

    if (json['appointmentDetails'] != null) {
      appointments = List<AppointmentDetails>.from(json['appointmentDetails']
          .map((x) => AppointmentDetails.fromJson(x)));
    }

    return TimeSlot(
      appointmentDetails: appointments,
    );
  }
}

class AppointmentDetails {
  String price;
  String title;
  final String date;
  List<TimeSlotPick> timeSlotPicks;

  AppointmentDetails({
    required this.date,
    required this.price,
    required this.title,
    required this.timeSlotPicks,
  });
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'price': price,
      'title': title,
      'timeSlotPicks': timeSlotPicks.map((pick) => pick.toJson()).toList(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'price': price,
      'title': title,
      'timeSlotPicks': timeSlotPicks.map((pick) => pick.toMap()).toList(),
    };
  }

  factory AppointmentDetails.fromJson(Map<String, dynamic> json) {
    return AppointmentDetails(
      date: json['date'],
      price: json['price'],
      title: json['title'],
      timeSlotPicks: List<TimeSlotPick>.from(
          json['timeSlotPicks'].map((x) => TimeSlotPick.fromJson(x))),
    );
  }
}

class TimeSlotPick {
  List<TimeSlotData> timeSlot;

  TimeSlotPick({
    required this.timeSlot,
  });
  Map<String, dynamic> toJson() {
    return {
      'timeSlot': timeSlot.map((data) => data.toJson()).toList(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'timeSlot': timeSlot.map((data) => data.toMap()).toList(),
    };
  }

  factory TimeSlotPick.fromJson(Map<String, dynamic> json) {
    return TimeSlotPick(
      timeSlot: List<TimeSlotData>.from(
          json['timeSlot'].map((x) => TimeSlotData.fromJson(x))),
    );
  }
}

class TimeSlotData {
  String date;
  List<TimeSlotDataHour> timeSlots;
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'timeSlots': timeSlots.map((hour) => hour.toJson()).toList(),
    };
  }

  TimeSlotData({
    required this.date,
    required this.timeSlots,
  });
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'timeSlots': timeSlots.map((hour) => hour.toMap()).toList(),
    };
  }

  factory TimeSlotData.fromJson(Map<String, dynamic> json) {
    return TimeSlotData(
      date: json['date'],
      timeSlots: List<TimeSlotDataHour>.from(
          json['timeSlots'].map((x) => TimeSlotDataHour.fromJson(x))),
    );
  }
}

class TimeSlotDataHour {
  int hour;
  int minute;

  TimeSlotDataHour({
    required this.hour,
    required this.minute,
  });
  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'minute': minute,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'hour': hour,
      'minute': minute,
    };
  }

  factory TimeSlotDataHour.fromJson(Map<String, dynamic> json) {
    return TimeSlotDataHour(
      hour: json['hour'],
      minute: json['minute'],
    );
  }
}
