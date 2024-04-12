part of 'persist_state_bloc.dart';

@immutable
sealed class PersistStateState {}

final class PersistStateInitial extends PersistStateState {}

class PersitSuccess extends PersistStateState {
  final bool isPersist;
  final UserModuleE userModule;
  final String sugesstion;
  PersitSuccess(
      {required this.sugesstion,
      required this.userModule,
      required this.isPersist});
}

class PersitDoctorSuccess extends PersistStateState {
  final bool isPersist;
  final Doctor doctorModule;
  final String suggesstion;

  PersitDoctorSuccess(
      {required this.isPersist,
      required this.doctorModule,
      required this.suggesstion});
}

class PersistLoading extends PersistStateState {}

class PersistError extends PersistStateState {
  final String error;
  PersistError({required this.error});
}

class PersistHttpError extends PersistStateState {
  final String errorMessage;

  PersistHttpError({required this.errorMessage});
}
