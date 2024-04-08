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
