import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/Gemini/ChatScreen.dart';

import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/UserScreens/AppointMentHist.dart';
import 'package:med_ease/UserScreens/CardDeatilsDoctor.dart';
import 'package:med_ease/UserScreens/CardDoctorDetailScreen.dart';
import 'package:med_ease/UserScreens/StartScreen.dart';
import 'package:med_ease/UserScreens/bloc/all_doctors_bloc.dart';
import 'package:med_ease/UserScreens/bloc/list_chat_bloc.dart';
import 'package:med_ease/UserScreens/bookedAppointmentList.dart';
import 'package:med_ease/UserScreens/utils/CardScreenDoctor.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/CustomTextfield.dart';
import 'package:med_ease/Utils/LoderScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final allDoctorData =
          BlocProvider.of<AllDoctorsBloc>(context, listen: false);
      allDoctorData.add(
          AllDoctorsDataEvent(search: searchController.text, context: context));
    });
    super.initState();
  }

  void removeuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("x-auth-token-w", "");
    await prefs.setString("typeOfUser", "");

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => StartScreen()));
  }

  void logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure to LogOut?"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                removeuser();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<UserBloc>().state;
    String name = userModel!.name;
    List<Doctor> list = [];
    final allDoctorSeach = BlocProvider.of<AllDoctorsBloc>(context);
    return BlocConsumer<AllDoctorsBloc, AllDoctorsState>(
      listener: (context, state) {
        if (state is AllDoctorsDataFailure) {
          showSnackBar(state.error, context);
        }

        if (state is AllDoctorsDataSuccess) {
          list = state.allDoctorsData;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Appointments $name'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: ClipOval(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    width: 55, // Increase width to stretch horizontally
                    height: 40, // Increase height to stretch vertically
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: AssetImage('assets/gemini.png'),
                      // Adjust radius as needed
                      radius: 20,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => ChatScreen()),
                  );
                },
              )
            ],
          ),
          drawer: Drawer(
            backgroundColor: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) => BookedAppointmentList())),
                    icon: Icon(Icons.list),
                    label: Text("Booked Appointment")),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => AppointHisUser(
                                userId: userModel.id,
                              )));
                    },
                    icon: Icon(Icons.history),
                    label: Text("History AppointMents")),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    onPressed: () => logout(),
                    icon: Icon(Icons.logout),
                    label: Text("LogOut")),
              ],
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[200],
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: searchController,
                      onChanged: (value) {
                        Future.delayed(Duration(milliseconds: 200), () {
                          allDoctorSeach.add(AllDoctorsDataEvent(
                              search: searchController.text, context: context));
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_rounded),
                        prefixIconColor: Colors.grey,
                        fillColor: Colors.black,
                        hintText: "Search Doctor or Specialist",
                        hintStyle:
                            TextStyle(color: const Color.fromARGB(99, 0, 0, 0)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: list.map((doctor) {
                        return buildDoctorCard(
                            OnTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => BookAppointment(
                                          doctorModuleE: doctor,
                                        ))),
                            imageUrl: doctor.profilePic,
                            doctorName: doctor.name,
                            experience: doctor.experience,
                            specialization: doctor.specialist);
                      }).toList(),
                    ),
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
