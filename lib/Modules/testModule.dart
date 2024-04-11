import 'dart:convert';

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
  List<ApplicationLeft> applicationLeft;
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
      applicationLeft:
          json['applicationLeft'] != null && json['applicationLeft'] is List
              ? (json['applicationLeft'] as List)
                  .map((a) => ApplicationLeft.fromJson(a))
                  .toList()
              : [],
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
      'applicationLeft':
          applicationLeft.map((appointment) => appointment.toJson()).toList(),
      'timeSlot': timeSlot.map((slot) => slot.toMap()).toList(),
      'token': token,
    };
  }

  String toJson() => json.encode(toMap());

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor.fromJson(map);
  }
}

class ApplicationLeft {
  String? userId;
  List<AppointMentDetails>? appointMentDetails;
  String? id;

  ApplicationLeft({this.userId, this.appointMentDetails});

  ApplicationLeft.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    if (json['appointMentDetails'] != null) {
      appointMentDetails = <AppointMentDetails>[];
      json['appointMentDetails'].forEach((v) {
        appointMentDetails!.add(new AppointMentDetails.fromJson(v));
      });
    }
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    if (this.appointMentDetails != null) {
      data['appointMentDetails'] =
          this.appointMentDetails!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.id;
    return data;
  }
}

class AppointMentDetails {
  String? date;
  String? doctorId;
  String? userId;
  bool? isComplete;
  String? id;

  AppointMentDetails({
    this.date,
    this.doctorId,
    this.userId,
    this.isComplete,
    this.id,
  });

  AppointMentDetails.fromJson(Map<String, dynamic> json) {
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

class TimeSlot {
  List<AppointMentDetailsD>? appointMentDetails;
  String? Id;

  TimeSlot({this.appointMentDetails, this.Id});

  TimeSlot.fromJson(Map<String, dynamic> json) {
    if (json['appointMentDetails'] != null) {
      appointMentDetails = <AppointMentDetailsD>[];
      json['appointMentDetails'].forEach((v) {
        appointMentDetails!.add(new AppointMentDetailsD.fromJson(v));
      });
    }
    Id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appointMentDetails != null) {
      data['appointMentDetails'] =
          this.appointMentDetails!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.Id;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'appointMentDetails': appointMentDetails != null
          ? appointMentDetails!
              .map((appointment) => appointment.toJson())
              .toList()
          : [],
      '_id': Id,
    };
  }
}

class AppointMentDetailsD {
  int? price;
  String? title;
  List<TimeSlotPicks>? timeSlotPicks;
  String? Id;

  AppointMentDetailsD({
    this.price,
    this.title,
    this.timeSlotPicks,
    this.Id,
  });

  AppointMentDetailsD.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    title = json['title'];
    if (json['timeSlotPicks'] != null) {
      timeSlotPicks = <TimeSlotPicks>[];
      json['timeSlotPicks'].forEach((v) {
        timeSlotPicks!.add(new TimeSlotPicks.fromJson(v));
      });
    }
    Id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['title'] = this.title;
    if (this.timeSlotPicks != null) {
      data['timeSlotPicks'] =
          this.timeSlotPicks!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.Id;

    return data;
  }
}

class TimeSlotPicks {
  List<TimeSloted>? timeSlot;
  String? Id;

  TimeSlotPicks({this.timeSlot, this.Id});

  TimeSlotPicks.fromJson(Map<String, dynamic> json) {
    if (json['timeSlot'] != null) {
      timeSlot = <TimeSloted>[];
      json['timeSlot'].forEach((v) {
        timeSlot!.add(new TimeSloted.fromJson(v));
      });
    }
    Id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timeSlot != null) {
      data['timeSlot'] = this.timeSlot!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.Id;
    return data;
  }
}

class TimeSloted {
  String? date;
  List<TimeSlots>? timeSlots;
  String? Id;

  TimeSloted({this.date, this.timeSlots, this.Id});

  TimeSloted.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['timeSlots'] != null) {
      timeSlots = <TimeSlots>[];
      json['timeSlots'].forEach((v) {
        timeSlots!.add(new TimeSlots.fromJson(v));
      });
    }
    Id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.timeSlots != null) {
      data['timeSlots'] = this.timeSlots!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.Id;

    return data;
  }
}

class TimeSlots {
  int? hour;
  int? minute;
  String? Id;

  TimeSlots({this.hour, this.minute, this.Id});

  TimeSlots.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    minute = json['minute'];
    Id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    data['_id'] = this.Id;
    return data;
  }
}
