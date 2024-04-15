import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_ease/UserScreens/StartScreen.dart'; // Updated import

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key); // Fixed key parameter
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Added SingleTickerProviderStateMixin
  late AnimationController _controller; // Added AnimationController
  late Animation<double> _animation; // Added Animation<double>

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      // Initialize AnimationController
      vsync: this,
      duration:
          Duration(milliseconds: 1000), // Adjust animation duration as needed
    );
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(_controller); // Initialize Animation with a Tween
    _controller.forward(); // Start the animation
    splash();
  }

  void splash() async {
    await Future.delayed(
      Duration(milliseconds: 1500),
      () {},
    );
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => StartScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            AnimatedBuilder(
              // Wrap the SVG picture with AnimatedBuilder
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value, // Apply scale transformation
                  child: child,
                );
              },
              child: SvgPicture.asset(
                'assets/s.svg',
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Welcome To MEDEASZZ!!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose AnimationController
    super.dispose();
  }
}
