import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_ease/DoctorScreen/DoctorScreen.dart';
import 'package:med_ease/DoctorScreen/bloc/appointmnet_bloc.dart';
import 'package:med_ease/Login_SignIn/Login.dart';
import 'package:med_ease/Login_SignIn/OtpScreen.dart';
import 'package:med_ease/Login_SignIn/bloc/otp_bloc_bloc.dart';
import 'package:med_ease/DoctorScreen/DoctorModifyScreen.dart';
import 'package:med_ease/Login_SignIn/bloc/sign_up_bloc.dart';
import 'package:med_ease/UserScreens/HomeScreen.dart';
import 'package:med_ease/UserScreens/StartScreen.dart';
import 'package:med_ease/DoctorScreen/doctorInfo.dart';
import 'package:med_ease/UserScreens/bloc/all_doctors_bloc.dart';
import 'package:med_ease/UserScreens/userinfo.dart';
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/Utils/LoderScreen.dart';
import 'package:med_ease/bloc/persist_state_bloc.dart';
import 'package:med_ease/bloc/sendotp_bloc_bloc.dart';
import 'package:med_ease/bloc/user_moduel_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? typeOfUser = prefs.getString('typeOfUser');
  runApp(ProviderScope(
    child: BlocProvider(
      create: (context) => UserBloc(),
      child: BlocProvider(
        create: (context) => DoctorBloc(),
        child: MyApp(
          typeOfUser: typeOfUser,
        ),
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final String? typeOfUser;
  const MyApp({super.key, required this.typeOfUser});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OtpBlocBloc>(
          create: (context) => OtpBlocBloc(),
        ),
        BlocProvider<SendotpBlocBloc>(
          create: (context) => SendotpBlocBloc(),
        ),
        BlocProvider(
          create: (context) => UserModuelBloc(),
        ),
        BlocProvider(
          create: (context) => AppointmnetBloc(),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => AllDoctorsBloc(),
        ),
        BlocProvider(create: (context) {
          if (typeOfUser == "doctor") {
            return PersistStateBloc()..add(persistDoctorEvent());
          }

          return PersistStateBloc()..add(persistEvent());
        })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whatsapp UI',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(
            color: appBarColor,
          ),
        ),
        // home: Login(),
        home: BlocBuilder<PersistStateBloc, PersistStateState>(
            builder: (context, state) {
          if (typeOfUser == "doctor") {
            if (state is PersistLoading) {
              return Loder();
            }
            if (state is PersitDoctorSuccess) {
              final doctorBloc = context.read<DoctorBloc>();
              doctorBloc.updateDoctor(state.doctorModule);
              return DoctorScreen(); // add doctorInfo
            } else {
              return StartScreen();
            }
          }
          if (typeOfUser == "user") {
            if (state is PersistLoading) {
              return Loder();
            }
            if (state is PersitSuccess) {
              final userBloc = context.read<UserBloc>();
              userBloc.updateUser(state.userModule);

              return HomeScreen();
            } else {
              return StartScreen();
            }
          }
          return StartScreen();
        }),
      ),
    );
  }
}
