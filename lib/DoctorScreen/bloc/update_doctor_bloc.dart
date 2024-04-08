import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_doctor_event.dart';
part 'update_doctor_state.dart';

class UpdateDoctorBloc extends Bloc<UpdateDoctorEvent, UpdateDoctorState> {
  UpdateDoctorBloc() : super(UpdateDoctorInitial()) {
    on<UpdateModifyDoctorEvent>((event, emit) {
      emit(updateDoctorLoding());
      try {} catch (e) {
        return emit(updateDoctorFailure(error: e.toString()));
      }
    });
  }
}
