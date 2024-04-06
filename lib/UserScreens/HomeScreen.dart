import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/Gemini/ChatScreen.dart';
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/UserScreens/StartScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
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
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  logout();
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => ChatScreen())),
                  child: Text(userModel!.emailAddress))
            ],
          ),
        ));
  }
}
