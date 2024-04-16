part of 'appointmnet_bloc.dart';

@immutable
sealed class AppointmnetEvent {}

class AppointMentDetailsEvent extends AppointmnetEvent {
  final String price;
  final List<TimeSlotD> timeSlots;
  final BuildContext context;
  final String title;
  final bool isVedio;

  AppointMentDetailsEvent(
      {required this.title,
      required this.context,
      required this.price,
      required this.isVedio,
      required this.timeSlots});
}

class AppointMentRefresh extends AppointmnetEvent {
  final String doctorId;
  final BuildContext context;
  AppointMentRefresh({required this.context, required this.doctorId});
}

class AppointMentSelectedTimeSlot extends AppointmnetEvent {
  final String price;
  final String title;
  final List<TimeSlotD> timeSlots;
  final bool isVedio;
  final String date;
  final String doctorId;
  final BuildContext context;

  AppointMentSelectedTimeSlot(
      {required this.context,
      required this.doctorId,
      required this.price,
      required this.title,
      required this.isVedio,
      required this.timeSlots,
      required this.date});
}

class AppointmentUpdateEvent extends AppointmnetEvent {
  final String price;
  final String title;
  final String date;
  final bool isVedio;
  final List<TimeSlotD> timeSlots;
  final BuildContext context;

  AppointmentUpdateEvent(
      {required this.context,
      required this.isVedio,
      required this.date,
      required this.price,
      required this.timeSlots,
      required this.title});
}
