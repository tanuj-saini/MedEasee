// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:med_ease/Modules/DoctorModify.dart';
import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/UserScreens/CardDoctorDetailScreen.dart';

import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class BookAppointment extends StatefulWidget {
  final Doctor doctorModuleE;
  BookAppointment({
    required this.doctorModuleE,
    super.key,
  });

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  List<TimeSlots> _items = [];
  List<TimeSlots> _selectedTimeSlots = [];
  TimeSlots? selectedTimeSlot;
  @override
  void initState() {
    super.initState();
    _generateTimeSlots();
  }

  void _generateTimeSlots() {
    for (var i = 0; i < 24; i++) {
      _items.add(TimeSlots(hour: i, minute: 0));
      _items.add(TimeSlots(hour: i, minute: 15));
      _items.add(TimeSlots(hour: i, minute: 30));
      _items.add(TimeSlots(hour: i, minute: 45));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text('Book Appointment'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            child: Image.asset('assets/img1.png'),
          ),
          Card(
            color: Colors.black87,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              NetworkImage(widget.doctorModuleE.profilePic),
                        ),
                      ),
                      SizedBox(width: 30),
                      Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.doctorModuleE.name,
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              widget.doctorModuleE.specialist,
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              widget.doctorModuleE.experience,
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.message,
                                ),
                                Text(
                                  '99 patient stories',
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.green),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                children: [Icon(Icons.thumb_up), Text('98%')],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        'Recommend...',
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.purple),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.star_border),
                                  Text('4.5%'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text('Rating'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: MultiSelectDialogField(
                      items: _items
                          .map((timeSlot) => MultiSelectItem<TimeSlots>(
                              timeSlot, timeSlot.toString()))
                          .toList(),
                      title: Text("Time"),
                      selectedColor: Colors.blue,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      buttonIcon: Icon(
                        Icons.access_time,
                        color: Colors.blue,
                      ),
                      buttonText: Text(
                        "Selected Time Slot",
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {
                        setState(() {
                          _selectedTimeSlots = List.from(results);
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          child: Text('video Appointment'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => CardDoctorDetails(
                                      doctorModule: widget.doctorModuleE,
                                    )));
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          child: Text('Clinic Appointment'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
