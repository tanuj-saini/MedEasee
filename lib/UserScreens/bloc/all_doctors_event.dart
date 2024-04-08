part of 'all_doctors_bloc.dart';

@immutable
sealed class AllDoctorsEvent {}

class AllDoctorsDataEvent extends AllDoctorsEvent {
  final BuildContext context;
  final String search;
  AllDoctorsDataEvent({required this.search, required this.context});
}
