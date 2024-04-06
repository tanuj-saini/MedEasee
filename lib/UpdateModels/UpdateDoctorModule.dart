import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/Modules/DoctorModule.dart';

class DoctorBloc extends Cubit<DoctorModule?> {
  DoctorBloc() : super(null);

  void updateDoctor(DoctorModule doctorModule) {
    emit(doctorModule);
  }
}
