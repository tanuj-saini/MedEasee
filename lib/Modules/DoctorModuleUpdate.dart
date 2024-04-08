class DoctorModule {
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
  final List<TimeSlot> timeSlot;
  final String? token; // 추가된 token 필드

  DoctorModule({
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
    this.token, // 초기화 리스트에 token 추가
  });

  factory DoctorModule.fromJson(Map<String, dynamic> json) {
    return DoctorModule(
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
      timeSlot:
          (json['timeSlot'] as List).map((e) => TimeSlot.fromJson(e)).toList(),
      token: json['token'], // JSON에서 token 값을 읽습니다.
    );
  }
}

class TimeSlot {
  final String id;
  final List<AppointmentDetails> appointMentDetails;

  TimeSlot({
    required this.id,
    required this.appointMentDetails,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['_id'],
      appointMentDetails: (json['appointMentDetails'] as List)
          .map((e) => AppointmentDetails.fromJson(e))
          .toList(),
    );
  }
}

class AppointmentDetails {
  final int price;
  final String title;
  final List<TimeSlotPick> timeSlotPicks;

  AppointmentDetails({
    required this.price,
    required this.title,
    required this.timeSlotPicks,
  });

  factory AppointmentDetails.fromJson(Map<String, dynamic> json) {
    return AppointmentDetails(
      price: json['price'],
      title: json['title'],
      timeSlotPicks: (json['timeSlotPicks'] as List)
          .map((e) => TimeSlotPick.fromJson(e))
          .toList(),
    );
  }
}

class TimeSlotPick {
  final String id;
  final List<TimeSlot> timeSlot;

  TimeSlotPick({
    required this.id,
    required this.timeSlot,
  });

  factory TimeSlotPick.fromJson(Map<String, dynamic> json) {
    return TimeSlotPick(
      id: json['_id'],
      timeSlot:
          (json['timeSlot'] as List).map((e) => TimeSlot.fromJson(e)).toList(),
    );
  }
}
