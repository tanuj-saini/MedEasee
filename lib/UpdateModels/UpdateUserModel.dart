import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/Modules/UserModule.dart';

class UserBloc extends Cubit<UserModule?> {
  UserBloc() : super(null);

  // Method to update user model
  void updateUser(UserModule userModel) {
    emit(userModel);
  }
}
