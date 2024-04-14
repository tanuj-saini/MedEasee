import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:med_ease/DoctorScreen/BottomNavigation.dart';
import 'package:med_ease/DoctorScreen/DoctorScreen.dart';
import 'package:med_ease/Login_SignIn/bloc/sign_up_bloc.dart';
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/UserScreens/HomeScreen.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/LoderScreen.dart';

class SignUpDoctor extends StatefulWidget {
  SignUpDoctor({super.key});
  @override
  State<StatefulWidget> createState() {
    return _SignUpDoctor();
  }
}

class _SignUpDoctor extends State<SignUpDoctor> {
  final TextEditingController phoneNumberContoller = TextEditingController();
  String _selectedCountryCode = "91";
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

  @override
  Widget build(BuildContext context) {
    final signUpUser = BlocProvider.of<SignUpBloc>(context);
    return BlocConsumer<SignUpBloc, SignUpState>(
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
      },
      builder: (context, state) {
        if (state is SignUpLoding) {
          return Loder();
        }
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
                            controller: phoneNumberContoller,
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
                        signUpUser.add(SignDoctorEvent(
                            context: context,
                            phoneNumber: phoneNumberContoller.text));
                      },
                      child: Text("Send the code"),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
