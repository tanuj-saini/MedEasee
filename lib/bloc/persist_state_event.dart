part of 'persist_state_bloc.dart';

@immutable
sealed class PersistStateEvent {}

class persistEvent extends PersistStateEvent {}

class persistDoctorEvent extends PersistStateEvent {}
