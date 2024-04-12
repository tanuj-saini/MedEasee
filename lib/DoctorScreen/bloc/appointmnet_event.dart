part of 'appointmnet_bloc.dart';

@immutable
sealed class AppointmnetEvent {}

class AppointMentDetailsEvent extends AppointmnetEvent {
  final String price;
  final List<TimeSlotD> timeSlots;
  final BuildContext context;
  final String title;

  AppointMentDetailsEvent(
      {required this.title,
      required this.context,
      required this.price,
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
  final String date;
  final String doctorId;
  final BuildContext context;

  AppointMentSelectedTimeSlot(
      {required this.context,
      required this.doctorId,
      required this.price,
      required this.title,
      required this.timeSlots,
      required this.date});
}
