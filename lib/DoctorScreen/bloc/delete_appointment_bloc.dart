import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_appointment_event.dart';
part 'delete_appointment_state.dart';

class DeleteAppointmentBloc
    extends Bloc<DeleteAppointmentEvent, DeleteAppointmentState> {
  DeleteAppointmentBloc() : super(DeleteAppointmentInitial()) {
    on<deleteAppoint>((event, emit) {
      emit(DeleteAppointLoding());
      try {} catch (e) {
        return emit(DeleteAppointFailure(error: e.toString()));
      }
    });
  }
}
