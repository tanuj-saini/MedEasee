import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_ease/UserScreens/HomeScreen.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/LoderScreen.dart';
import 'package:med_ease/Utils/button.dart';
import 'package:med_ease/Utils/CustomTextfield.dart';
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/bloc/user_moduel_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatelessWidget {
  UserInfo({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sendOtp = BlocProvider.of<UserModuelBloc>(context);
    return BlocConsumer<UserModuelBloc, UserModuelState>(
      listener: (context, state) {
        if (state is userModulefaliure) {
          showSnackBar(state.error, context);
        }
        if (state is userModuleSuccess) {
          final userBloc = context.read<UserBloc>();
          userBloc.updateUser(state.userModule);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => HomeScreen()));
        }
      },
      builder: (context, state) {
        if (state is userModuleLoding) {
          return Loder();
        }
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SvgPicture.asset(
                                'assets/s.svg',
                                color: Colors.white,
                                height: 200,
                              ),
                              SvgPicture.asset(
                                'assets/i.svg',
                                color: Colors.white,
                                height: 150,
                              ),
                              CustomTextField(
                                  iconButton: Icon(Icons.person_2_outlined),
                                  controller: nameController,
                                  hintText: ' Enter your Name'),
                              SizedBox(
                                height: 30,
                              ),
                              CustomTextField(
                                  iconButton:
                                      Icon(Icons.location_city_outlined),
                                  controller: addressController,
                                  hintText: 'Enter your Address'),
                              SizedBox(
                                height: 30,
                              ),
                              CustomTextField(
                                  iconButton: Icon(Icons.email_outlined),
                                  controller: emailController,
                                  hintText: 'Enter your Email Address'),
                              SizedBox(
                                height: 30,
                              ),
                              CustomTextField(
                                  iconButton:
                                      Icon(Icons.phone_android_outlined),
                                  controller: phoneNumberController,
                                  hintText: 'Enter your Phone Number'),
                              SizedBox(
                                height: 30,
                              ),
                              CustomTextField(
                                  iconButton: Icon(Icons.add_outlined),
                                  controller: ageController,
                                  hintText: 'Enter your age'),
                              SizedBox(
                                height: 30,
                              ),
                              CustomizableElevatedButton(
                                  onPressed: () {
                                    sendOtp.add(userModuleEvent(
                                        context: context,
                                        age: ageController.text,
                                        phoneNumber: phoneNumberController.text,
                                        name: nameController.text,
                                        emailAddress: emailController.text,
                                        homeAddress: addressController.text));
                                  },
                                  buttonColor: Colors.blue,
                                  buttonText: 'Submit')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
