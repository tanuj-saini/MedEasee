import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/Login_SignIn/OtpScreen.dart';
import 'package:med_ease/Login_SignIn/bloc/otp_bloc_bloc.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/LoderScreen.dart';
import 'package:med_ease/bloc/sendotp_bloc_bloc.dart';

class Login extends StatefulWidget {
  Login({super.key});
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  final TextEditingController phoneNumberContoller = TextEditingController();
  String _selectedCountryCode = "91"; // Default country code

  @override
  Widget build(BuildContext context) {
    final sendOtp = BlocProvider.of<SendotpBlocBloc>(context);
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

    return BlocConsumer<SendotpBlocBloc, SendotpBlocState>(
        listener: (context, state) {
      if (state is PhoneFailure) {
        showSnackBar(state.error, context);
      }
      if (state is PhoneSuccess) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => OtpScreen(verificationId: state.verificationID)));
      }
    }, builder: (context, state) {
      if (state is PhoneLoading) {
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
                // SvgPicture.asset(
                //   'assets/s.svg',
                //   color: Colors.white,
                // ),
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
                      sendOtp.add(SendPhoneNumber(
                          context: context, phoneNumber: "+919307033442"));
                    },
                    child: Text("Send the code"),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
