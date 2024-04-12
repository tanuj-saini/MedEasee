import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:med_ease/Utils/timeSlot.dart';

class SelectedTimeSlotU {
  final String price;
  final String title;
  final String date;
  final List<TimeSlotD> timeSlots;

  SelectedTimeSlotU({
    required this.price,
    required this.title,
    required this.date,
    required this.timeSlots,
  });

  SelectedTimeSlotU copyWith({
    String? price,
    String? title,
    String? date,
    List<TimeSlotD>? timeSlots,
  }) {
    return SelectedTimeSlotU(
      price: price ?? this.price,
      title: title ?? this.title,
      date: date ?? this.date,
      timeSlots: timeSlots ?? this.timeSlots,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price': price,
      'title': title,
      'date': date,
      'timeSlots': timeSlots.map((x) => x.toMap()).toList(),
    };
  }

  factory SelectedTimeSlotU.fromMap(Map<String, dynamic> map) {
    return SelectedTimeSlotU(
      price: map['price'] as String,
      title: map['title'] as String,
      date: map['date'] as String,
      timeSlots: List<TimeSlotD>.from(
        (map['timeSlots'] as List<dynamic>).map<TimeSlotD>(
          (x) => TimeSlotD.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SelectedTimeSlotU.fromJson(String source) =>
      SelectedTimeSlotU.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SelectedTimeSlotU(price: $price, title: $title, date: $date, timeSlots: $timeSlots)';
  }

  @override
  bool operator ==(covariant SelectedTimeSlotU other) {
    if (identical(this, other)) return true;

    return other.price == price &&
        other.title == title &&
        other.date == date &&
        listEquals(other.timeSlots, timeSlots);
  }

  @override
  int get hashCode {
    return price.hashCode ^ title.hashCode ^ date.hashCode ^ timeSlots.hashCode;
  }
}
