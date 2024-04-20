import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/DoctorScreen/AppointMentHistory.dart';
import 'package:med_ease/DoctorScreen/DoctorScreen.dart';
import 'package:med_ease/DoctorScreen/ListAppointMent.dart';
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _bottomNavigation createState() => _bottomNavigation();
}

class _bottomNavigation extends State<BottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final doctorModel = context.watch<DoctorBloc>().state;
    List<Widget> _widgetOptions = <Widget>[
      DoctorScreen(),
      ListAppointmentScreen(),
      AppointMentHistory(
        doctorId: doctorModel!.id,
      )
    ];
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
