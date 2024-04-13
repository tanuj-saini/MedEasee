import 'package:flutter/material.dart';
import 'package:med_ease/DoctorScreen/DoctorScreen.dart';
import 'package:med_ease/DoctorScreen/DoctorSignUpScreen.dart';
import 'package:med_ease/DoctorScreen/doctorInfo.dart';
import 'package:med_ease/Login_SignIn/Login.dart';
import 'package:med_ease/UserScreens/userinfo.dart';
import 'package:med_ease/UserScreens/utils/SignUpScreen.dart';

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
                                "Hey Doctor!!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => DoctorInfo()));
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
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => SignUpDoctor()));
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
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => UserInfo()));
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
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => SignUpScreen()));
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



// class StartScreen extends StatefulWidget {
//   StartScreen({super.key});
//   @override
//   State<StatefulWidget> createState() {
//     return _StartScreen();
//   }
// }

// class _StartScreen extends State<StartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Are you ',
//               style: TextStyle(fontSize: 24.0),
//             ),
//             SizedBox(height: 50.0),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigator.of(context).push(MaterialPageRoute(
//                 //     builder: (ctx) => (Login(typeOfUser: "user"))));
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (ctx) => UserInfo()));
//               },
//               child: Text('User'),
//             ),
//             TextButton(
//                 onPressed: () => Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (ctx) => SignUpScreen())),
//                 child: Text("Login")),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () {
//                 //   Navigator.of(context).push(MaterialPageRoute(
//                 //       builder: (ctx) => Login(typeOfUser: 'doctor')));
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (ctx) => DoctorInfo()));
//               },
//               child: Text('Doctor'),
//             ),
//             SizedBox(height: 20.0),
//             TextButton(
//                 onPressed: () => Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (ctx) => SignUpDoctor())),
//                 child: Text("Login")),
//           ],
//         ),
//       ),
//     );
//   }
// }