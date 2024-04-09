import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:med_ease/Modules/testUserModule.dart';

class UserBloc extends Cubit<UserModuleE?> {
  UserBloc() : super(null);

  // Method to update user model
  void updateUser(UserModuleE userModel) {
    emit(userModel);
  }
}
