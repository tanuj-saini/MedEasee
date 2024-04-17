import 'package:flutter/material.dart';
import 'package:med_ease/Delete/SignUpD.dart';
import 'package:med_ease/Delete/SignUpUserD.dart';
import 'package:med_ease/DoctorScreen/DoctorScreen.dart';
import 'package:med_ease/DoctorScreen/DoctorSignUpScreen.dart';
import 'package:med_ease/DoctorScreen/doctorInfo.dart';
import 'package:med_ease/Login_SignIn/Login.dart';
import 'package:med_ease/UserScreens/userinfo.dart';
import 'package:med_ease/UserScreens/utils/SignUpDoctorOtp.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            SvgPicture.asset('assets/i.svg'),
            Text(
              'Get Logged in or Sign up',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/d.webp',
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 200,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Text(
                                "Hey Doctor!!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                Login(typeOfUser: 'doctor')));
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      gradient: LinearGradient(
                                        colors: [Colors.blue, Colors.green],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'To Sign Up',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) => DoctorInfo(
                                                phoneNumber: "dnlsk"))),
                                    child: Text("To Sign Up"))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) => SignUpDoctorOtp(
                                                typeOfUser: 'doctor')));
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      gradient: LinearGradient(
                                        colors: [Colors.blue, Colors.green],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'To Logged ip',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) => SignUpDoctorD())),
                                    child: Text("To Logged in"))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/R.svg',
                        fit: BoxFit.contain,
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/d.webp',
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 200,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Text(
                                "Hey User!!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                Login(typeOfUser: 'user')));
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      gradient: LinearGradient(
                                        colors: [Colors.blue, Colors.green],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'To Sign Up',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) => UserInfo(
                                                  phoneNumber: "3242")));
                                    },
                                    child: Text("To Sign Up"))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) => SignUpDoctorOtp(
                                                typeOfUser: 'user')));
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      gradient: LinearGradient(
                                        colors: [Colors.blue, Colors.green],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'To Logged in',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) => SignUpUserD()));
                                    },
                                    child: Text("To Logged in"))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        'assets/u.svg',
                        fit: BoxFit.contain,
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
