import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/Modules/DoctorModify.dart';
import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/Utils/DoctorModule.dart';

class DoctorBloc extends Cubit<Doctor?> {
  DoctorBloc() : super(null);

  void updateDoctor(Doctor doctorModule) {
    emit(doctorModule);
  }
}
