import 'package:flutter/material.dart';
import 'package:med_ease/DoctorScreen/doctorInfo.dart';
import 'package:med_ease/Login_SignIn/Login.dart';
import 'package:med_ease/UserScreens/userinfo.dart';

class StartScreen extends StatefulWidget {
  StartScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _StartScreen();
  }
}

class _StartScreen extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you ',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (ctx) => (Login(typeOfUser: "user"))));
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => UserInfo()));
              },
              child: Text('User'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => DoctorInfo()));
              },
              child: Text('Doctor'),
            ),
          ],
        ),
      ),
    );
  }
}
