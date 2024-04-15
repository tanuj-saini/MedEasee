import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/UserScreens/HomeScreen.dart';

class OrderSplash extends StatefulWidget {
  final String dateTimeOrder;
  final String AppointMentId;
  final TimeSlots timeSlot;

  OrderSplash(
      {required this.timeSlot,
      required this.AppointMentId,
      required this.dateTimeOrder,
      Key? key})
      : super(key: key);

  @override
  _OrderSplashState createState() => _OrderSplashState();
}

class _OrderSplashState extends State<OrderSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
    //splash();
  }

  void splash() async {
    // await Future.delayed(Duration(milliseconds: 3000), () {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => HomeScreen()),
    );
    //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: Image.asset(
                      'assets/nobg.png',
                      width: 150,
                      height: 150,
                    ),
                  );
                },
              ),
              SizedBox(height: 25),
              Text(
                "Appointment Completed !!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Appointment Id: ${widget.AppointMentId}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 134, 132, 132),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Date ${widget.dateTimeOrder}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 134, 132, 132),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "TimeSlot Booked: ${widget.timeSlot.hour}:${widget.timeSlot.minute}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 134, 132, 132),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 380),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                    onPressed: () {
                      splash();
                    },
                    icon: Icon(Icons.done),
                    label: Text("Done")),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
