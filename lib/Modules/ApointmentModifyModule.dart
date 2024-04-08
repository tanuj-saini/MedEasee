// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:med_ease/Utils/timeSlot.dart';

class TimeSlotted {
  List<AppointmentModule> appointmentDetails;

  TimeSlotted({
    required this.appointmentDetails,
  });

  factory TimeSlotted.fromJson(Map<String, dynamic> json) {
    return TimeSlotted(
      appointmentDetails: List<AppointmentModule>.from(
          json['appointmentDetails'].map((x) => AppointmentModule.fromJson(x))),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'appointmentDetails': appointmentDetails.map((x) => x.toJson()).toList(),
    };
  }
}

class AppointmentModule {
  final String price;
  final String date;
  final String title;
  final List<TimeSlotD> timeSlots;

  AppointmentModule({
    required this.price,
    required this.date,
    required this.title,
    required this.timeSlots,
  });

  AppointmentModule copyWith({
    String? price,
    String? date,
    String? title,
    List<TimeSlotD>? timeSlots,
  }) {
    return AppointmentModule(
      price: price ?? this.price,
      date: date ?? this.date,
      title: title ?? this.title,
      timeSlots: timeSlots ?? this.timeSlots,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price': price,
      'date': date,
      'title': title,
      'timeSlots': timeSlots.map((x) => x.toMap()).toList(),
    };
  }

  factory AppointmentModule.fromMap(Map<String, dynamic> map) {
    return AppointmentModule(
      price: map['price'] as String,
      date: map['date'] as String,
      title: map['title'] as String,
      timeSlots: List<TimeSlotD>.from(
        (map['timeSlots'] as List<int>).map<TimeSlotD>(
          (x) => TimeSlotD.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentModule.fromJson(String source) =>
      AppointmentModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppointmentModule(price: $price, date: $date, title: $title, timeSlots: $timeSlots)';
  }

  @override
  bool operator ==(covariant AppointmentModule other) {
    if (identical(this, other)) return true;

    return other.price == price &&
        other.date == date &&
        other.title == title &&
        listEquals(other.timeSlots, timeSlots);
  }

  @override
  int get hashCode {
    return price.hashCode ^ date.hashCode ^ title.hashCode ^ timeSlots.hashCode;
  }
}
