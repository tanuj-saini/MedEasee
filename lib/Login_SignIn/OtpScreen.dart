import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/DoctorScreen/BottomNavigation.dart';
import 'package:med_ease/DoctorScreen/DoctorModifyScreen.dart';
import 'package:med_ease/DoctorScreen/DoctorScreen.dart';
import 'package:med_ease/Login_SignIn/bloc/otp_bloc_bloc.dart';
import 'package:med_ease/UserScreens/HomeScreen.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/LoderScreen.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String typeOfUser;
  final String verificationId;
  OtpScreen(
      {required this.typeOfUser, required this.verificationId, super.key});
  @override
  State<StatefulWidget> createState() {
    return _OtpScreen();
  }
}

class _OtpScreen extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final optBloc = BlocProvider.of<OtpBlocBloc>(context);
    return BlocConsumer<OtpBlocBloc, OtpBlocState>(listener: (context, state) {
      if (state is OtpFailure) {
        showSnackBar(state.error, context);
      }
      if (state is OtpSuccess) {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          if (widget.typeOfUser == "doctor") {
            return BottomNavigation();
          }
          return HomeScreen();
        }));
      }
    }, builder: (context, state) {
      if (state is OtpLoding) {
        return Loder();
      }
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img1.png',
                  width: 150,
                  height: 150,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Phone Verification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "We need to register your phone without getting started!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Pinput(
                  length: 6,
                  // defaultPinTheme: defaultPinTheme,
                  // focusedPinTheme: focusedPinTheme,
                  // submittedPinTheme: submittedPinTheme,

                  showCursor: true,
                  onCompleted: (pin) => print(pin),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        optBloc.add(OtpBlocevent(
                            UserOtp: otpController.text,
                            verificationID: widget.verificationId));
                      },
                      child: Text("Verify Phone Number")),
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'phone',
                            (route) => false,
                          );
                        },
                        child: Text(
                          "Edit Phone Number ?",
                          style: TextStyle(color: Colors.grey),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
