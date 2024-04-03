part of 'sendotp_bloc_bloc.dart';

@immutable
abstract class SendotpBlocEvent {}

class SendPhoneNumber extends SendotpBlocEvent {
  final String phoneNumber;
  final BuildContext context;

  SendPhoneNumber({required this.context, required this.phoneNumber});
}
