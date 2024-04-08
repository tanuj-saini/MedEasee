import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:med_ease/Login_SignIn/OtpScreen.dart';
import 'package:med_ease/Login_SignIn/bloc/otp_bloc_bloc.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/LoderScreen.dart';
import 'package:med_ease/bloc/sendotp_bloc_bloc.dart';

class Login extends StatefulWidget {
  final String typeOfUser;
  Login({required this.typeOfUser, super.key});
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

    String typeOfUser = widget.typeOfUser;
    String verificationId = "";
    return BlocConsumer<SendotpBlocBloc, SendotpBlocState>(
        listener: (context, state) {
      if (state is PhoneFailure) {
        showSnackBar(state.error, context);
      }
      if (state is PhoneVerificationID) {
        verificationId = state.verificationID;
        print(verificationId);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OtpScreen(
                typeOfUser: widget.typeOfUser,
                verificationId: state.verificationID)));
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
                      sendOtp.add(SendPhoneNumber(
                          context: context, phoneNumber: "+918824598603"));
                    },
                    child: Text("Send the code"),
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
                      print(typeOfUser);
                      print(verificationId);
                      print(
                          """tpScreen으로 네비게이션하는 로직을 구현했습니다. 이 방식을 사용하면, 상태에 따라 적절한 화면으로 사용자를 안내할 수 있습니다
다만, 위의 예시에서 widget.typeOfUser가 사용되고 있는데, 이는 현재 위젯의 프로퍼티로 typeOfUser가 정의되어 있어야 합니다. 만약 이 프로퍼티가 현재 위젯에 없다면, 해당 부분을 제거하거나 적절한 값을 설정해야 합니다.
이러한 방식으로 BlocConsumer를 정의하고, 위젯 트리 내에 위치시키면, SendotpBlocBloc의 상태 변화에 따라 적절한 UI 변화나 네비게이션 처리를 할 수 있습니다.""");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => OtpScreen(
                              typeOfUser: typeOfUser,
                              verificationId: verificationId)));
                    },
                    child: Text("Enter Otp"),
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
//+919307032542