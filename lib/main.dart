import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/Login_SignIn/Login.dart';
import 'package:med_ease/Login_SignIn/bloc/otp_bloc_bloc.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:med_ease/bloc/sendotp_bloc_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OtpBlocBloc>(
          create: (context) => OtpBlocBloc(), // Provide your OTP BLoC here
        ),
        BlocProvider<SendotpBlocBloc>(
          create: (context) => SendotpBlocBloc(),
        )
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
        home: Login(),
      ),
    );
  }
}
