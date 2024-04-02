import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/Login_SignIn/Login.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:med_ease/bloc/sendotp_bloc_bloc.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
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
          home: Login()),
    );
  }
}
