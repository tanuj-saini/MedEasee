import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/DoctorScreen/DoctorModifyScreen.dart';
import 'package:med_ease/DoctorScreen/bloc/appointmnet_bloc.dart';
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';
import 'package:med_ease/UserScreens/StartScreen.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/LoderScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorScreen extends StatefulWidget {
  DoctorScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _DoctorScreen();
  }
}

class _DoctorScreen extends State<DoctorScreen> {
  void removeuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("x-auth-token-D", "");
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
    final doctorModel = context.watch<DoctorBloc>().state;
    String doctorName = doctorModel!.name;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello '$doctorName"),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => DoctorModifyScreen())),
            child: Text("Next"),
          ),
        ),
      ),
    );
  }
}
