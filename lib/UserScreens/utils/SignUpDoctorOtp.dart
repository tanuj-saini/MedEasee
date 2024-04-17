import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:med_ease/DoctorScreen/BottomNavigation.dart';
import 'package:med_ease/DoctorScreen/doctorInfo.dart';
import 'package:med_ease/Login_SignIn/OtpScreen.dart';
import 'package:med_ease/Login_SignIn/bloc/otp_bloc_bloc.dart';
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/UserScreens/HomeScreen.dart';
import 'package:med_ease/UserScreens/userinfo.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/LoderScreen.dart';
import 'package:med_ease/bloc/login_new_otp_bloc.dart';
import 'package:med_ease/bloc/sendotp_bloc_bloc.dart';

class SignUpDoctorOtp extends StatefulWidget {
  final String typeOfUser;
  SignUpDoctorOtp({required this.typeOfUser, super.key});
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<SignUpDoctorOtp> {
  final TextEditingController phoneNumberContoller = TextEditingController();
  String _selectedCountryCode = "91"; // Default country code
  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final sendOtp = BlocProvider.of<LoginNewOtpBloc>(context);
    void _openCountryPicker() {
      showCountryPicker(
        context: context,
        onSelect: (Country country) {
          setState(() {
            _selectedCountryCode = country.phoneCode;
          });
        },
      );
    }

    String typeOfUser = widget.typeOfUser;
    String verificationId = "";
    return BlocConsumer<LoginNewOtpBloc, LoginNewOtpState>(
        listener: (context, state) {
      if (state is SignUpFailure) {
        showSnackBar(state.error, context);
      }
      if (state is SignUpDoctorSucess) {
        final UserDoctorBloc = context.read<DoctorBloc>();
        UserDoctorBloc.updateDoctor(state.doctorModuleE);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => BottomNavigation()));
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => BottomNavigation()));
      }
      if (state is SignUpSuccess) {
        final UsersBloc = context.read<UserBloc>();
        UsersBloc.updateUser(state.userModule);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => HomeScreen()));
      }
      if (state is LoginScreenLoadedState) {
        if (widget.typeOfUser == 'doctor') {
          sendOtp.add(SignDoctorEvent(
              context: context, phoneNumber: phoneNumberContoller.text));
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (ctx) => DoctorInfo(phoneNumber: "4234")));
        } else {
          sendOtp.add(SignUpEventPhone(
              context: context, phoneNumber: phoneNumberContoller.text));
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (ctx) => UserInfo(phoneNumber: "43")));
        }
      } else if (state is LoginScreenErrorState) {
        showSnackBar(state.error, context);
      } else if (state is PhoneAuthCodeSentSuccess) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Please Enter Otp"),
              content: TextField(
                  controller: otpController,
                  decoration: InputDecoration(hintText: "Enter Otp")),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      sendOtp.add(VerifySendOtp(
                          otpCode: otpController.text,
                          verificationId: state.verificationId));
                      Navigator.of(context).pop();
                    },
                    child: Text("Send Otp"))
              ],
            );
          },
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/s.svg',
                  color: Colors.white,
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
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: _openCountryPicker,
                        child: Text(
                          "+$_selectedCountryCode",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                        ),
                      ),
                    ],
                  ),
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      sendOtp.add(
                          sendOtpToPhoneEvent(phoneNumber: "+919327900836"));
                    },
                    child: Text("Send the code"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
//+919307032542