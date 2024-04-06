// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:med_ease/Utils/timeSlot.dart'; // 경로가 프로젝트 구조와 일치하는지 확인하세요.

class AppointmentModule {
  final String price;
  final String date;
  final List<TimeSlot> timeSlots;

  AppointmentModule({
    required this.price,
    required this.date,
    required this.timeSlots,
  });

  AppointmentModule copyWith({
    String? price,
    String? date,
    List<TimeSlot>? timeSlots,
  }) {
    return AppointmentModule(
      price: price ?? this.price,
      date: date ?? this.date,
      timeSlots: timeSlots ?? this.timeSlots,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price': price,
      'date': date,
      'timeSlots': timeSlots.map((x) => x.toMap()).toList(),
    };
  }

  factory AppointmentModule.fromMap(Map<String, dynamic> map) {
    return AppointmentModule(
      price: map['price'] as String,
      date: map['date'] as String,
      timeSlots: List<TimeSlot>.from(
        (map['timeSlots'] as List<int>).map<TimeSlot>(
          (x) => TimeSlot.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentModule.fromJson(String source) =>
      AppointmentModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AppointmentModule(price: $price, date: $date, timeSlots: $timeSlots)';

  @override
  bool operator ==(covariant AppointmentModule other) {
    if (identical(this, other)) return true;

    return other.price == price &&
        other.date == date &&
        listEquals(other.timeSlots, timeSlots);
  }

  @override
  int get hashCode => price.hashCode ^ date.hashCode ^ timeSlots.hashCode;
}





// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:med_ease/Utils/timeSlot.dart'; // 경로가 프로젝트 구조와 일치하는지 확인하세요.

// class AppointmentModule {
//   final String price;
//   final List<TimeSlot> timeSlots;

//   AppointmentModule({
//     required this.price,
//     required this.timeSlots,
//   });

//   AppointmentModule copyWith({
//     String? price,
//     List<TimeSlot>? timeSlots,
//   }) {
//     return AppointmentModule(
//       price: price ?? this.price,
//       timeSlots: timeSlots ?? this.timeSlots,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'price': price,
//       'timeSlots': timeSlots.map((x) => x.toMap()).toList(),
//     };
//   }

//   factory AppointmentModule.fromMap(Map<String, dynamic> map) {
//     return AppointmentModule(
//       price: map['price'],
//       timeSlots: List<TimeSlot>.from(
//         (map['timeSlots'] as List).map<TimeSlot>(
//           (x) => TimeSlot.fromMap(x as Map<String, dynamic>),
//         ),
//       ),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory AppointmentModule.fromJson(String source) =>
//       AppointmentModule.fromMap(json.decode(source));

//   @override
//   String toString() =>
//       'AppointmentModule(price: $price, timeSlots: $timeSlots)';

//   @override
//   bool operator ==(covariant AppointmentModule other) {
//     if (identical(this, other)) return true;

//     return other.price == price && listEquals(other.timeSlots, timeSlots);
//   }

//   @override
//   int get hashCode => price.hashCode ^ timeSlots.hashCode;
// }
