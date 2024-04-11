class AppointmentD {
  String? userId;
  List<AppointmentDetailsD>? appointMentDetails;
  String? id;

  AppointmentD({this.userId, this.appointMentDetails, this.id});

  AppointmentD.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    if (json['appointMentDetails'] != null) {
      appointMentDetails = <AppointmentDetailsD>[];
      json['appointMentDetails'].forEach((v) {
        appointMentDetails!.add(new AppointmentDetailsD.fromJson(v));
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

class AppointmentDetailsD {
  String? date;
  String? doctorId;
  String? userId;
  bool? isComplete;
  String? id;

  AppointmentDetailsD({
    this.date,
    this.doctorId,
    this.userId,
    this.isComplete,
    this.id,
  });

  AppointmentDetailsD.fromJson(Map<String, dynamic> json) {
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
