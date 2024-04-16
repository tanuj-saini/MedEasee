part of 'book_apppointment_bloc.dart';

@immutable
sealed class BookApppointmentEvent {}

class BookAppointmentUserEvent extends BookApppointmentEvent {
  final String date;
  final String doctorId;
  final bool isComplete;
  final List<TimeSlots> timeSlotPicks;
  final BuildContext context;
  final bool isVedio;

  BookAppointmentUserEvent(
      {required this.date,
      required this.timeSlotPicks,
      required this.context,
      required this.doctorId,
      required this.isVedio,
      required this.isComplete});
}
