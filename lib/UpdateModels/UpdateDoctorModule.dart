import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/Modules/DoctorModify.dart';
import 'package:med_ease/Modules/DoctorModule.dart';

class DoctorBloc extends Cubit<DoctorModuleE?> {
  DoctorBloc() : super(null);

  void updateDoctor(DoctorModuleE doctorModule) {
    emit(doctorModule);
  }
}
