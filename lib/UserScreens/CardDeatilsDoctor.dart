import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:med_ease/Modules/DoctorModify.dart';
import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/UserScreens/CardDoctorDetailScreen.dart';
import 'package:med_ease/UserScreens/utils/MessageScreen.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class BookAppointment extends StatefulWidget {
  final Doctor doctorModuleE;

  BookAppointment({
    required this.doctorModuleE,
    Key? key,
  }) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  List<TimeSlots> _items = [];
  List<TimeSlots> _selectedTimeSlots = [];

  @override
  void initState() {
    super.initState();
    _loadSelectedTimeSlots();
    print(widget.doctorModuleE);
  }

  void _loadSelectedTimeSlots() {
    int length =
        widget.doctorModuleE.selectedTimeSlot!.timeSlotPicks!.timeSlots!.length;
    List<TimeSlots> selectedTimeSlots = [];
    for (int i = 0; i < length; i++) {
      int hour = widget.doctorModuleE.selectedTimeSlot!.timeSlotPicks!
              .timeSlots![i].hour ??
          0;
      int minute = widget.doctorModuleE.selectedTimeSlot!.timeSlotPicks!
              .timeSlots![i].minute ??
          0;
      TimeSlots timeSlotsed = TimeSlots(hour: hour, minute: minute);
      selectedTimeSlots.add(timeSlotsed);
    }
    setState(() {
      // _selectedTimeSlots = selectedTimeSlots;
      _items = selectedTimeSlots.toList(); // Assign values to _items here
    });
  }

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<UserBloc>().state;
    // print(widget
    //     .doctorModuleE.selectedTimeSlot!.timeSlotPicks!.timeSlots![0].minute);
    // print(_selectedTimeSlots.length);
    print(_selectedTimeSlots.length);
    print('hello');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text('Book Appointment'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            child: SvgPicture.asset('assets/s.svg'),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: MultiSelectDialogField(
                      items: _items
                          .map((timeSlot) => MultiSelectItem<TimeSlots>(
                                timeSlot,
                                "${timeSlot.hour}:${timeSlot.minute}",
                                //timeSlot.minute.toString(),
                              ))
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
                      initialValue: _selectedTimeSlots,
                      onConfirm: (results) {
                        setState(() {
                          _selectedTimeSlots = results ?? [];
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
                          child: Text('Video Appointment'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => CardDoctorDetails(
                                      timeSlotPicks: _selectedTimeSlots,
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
                // SizedBox(
                //   height: 20,
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (ctx) => MessageScreen(userID: userModel!.id,
                //               doctor: widget.doctorModuleE,
                //             )));
                //   },
                //   style: ButtonStyle(
                //     backgroundColor:
                //         MaterialStateProperty.all<Color>(Colors.blue),
                //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //       RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20.0),
                //       ),
                //     ),
                //   ),
                //   child: Text('Message Screen'),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// _generateTimeSlots();
 // void _generateTimeSlots() {
  //   for (var i = 0; i < 24; i++) {
  //     _items.add(TimeSlots(hour: i, minute: 0));
  //     _items.add(TimeSlots(hour: i, minute: 15));
  //     _items.add(TimeSlots(hour: i, minute: 30));
  //     _items.add(TimeSlots(hour: i, minute: 45));
  //   }
  // }
