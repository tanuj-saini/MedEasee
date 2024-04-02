part of 'sendotp_bloc_bloc.dart';

@immutable
sealed class SendotpBlocState {}

final class SendotpBlocInitial extends SendotpBlocState {}
class phoneSuccess extends SendotpBlocState {
  
}

class phoneLoding extends SendotpBlocState {}

class phoneFailure extends SendotpBlocState {
  final String error;

  phoneFailure({required this.error});
}
