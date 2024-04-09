part of 'book_apppointment_bloc.dart';

@immutable
sealed class BookApppointmentState {}

final class BookApppointmentInitial extends BookApppointmentState {}

class BookApppointmentFailure extends BookApppointmentState {
  final String error;
  BookApppointmentFailure({required this.error});
}

class BookApppointmentSuccess extends BookApppointmentState {
  // final UserModule userModule;
  // BookApppointmentSuccess({required this.userModule});
}

class BookApppointmentLoding extends BookApppointmentState {}
