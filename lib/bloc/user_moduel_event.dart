part of 'user_moduel_bloc.dart';

@immutable
sealed class UserModuelEvent {}

class userModuleEvent extends UserModuelEvent {
  final String age;
  final String phoneNumber;
  final String name;
  final String emailAddress;
  final String homeAddress;
  final BuildContext context;

  userModuleEvent(
      {required this.context,
      required this.age,
      required this.phoneNumber,
      required this.name,
      required this.emailAddress,
      required this.homeAddress});
}

class doctorModuleEvent extends UserModuelEvent {
  final BuildContext context;
  final String name;
  final String bio;
  final String phoneNumber;
  final String specialist;
  final String currentWorkingHospital;
  final String profilePic;
  final String registerNumbers;
  final String experience;
  final String emailAddress;
  final String age;

  doctorModuleEvent(
      {required this.context,
      required this.name,
      required this.bio,
      required this.phoneNumber,
      required this.specialist,
      required this.currentWorkingHospital,
      required this.profilePic,
      required this.registerNumbers,
      required this.experience,
      required this.emailAddress,
      required this.age});
}
