import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:med_ease/Modules/DoctorModify.dart';
import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/UserScreens/CardDoctorDetailScreen.dart';
import 'package:med_ease/UserScreens/utils/MessageScreen.dart';
import 'package:med_ease/Utils/Colors.dart';
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
    List<TimeSlots> selectedTimeSlots = [];
    if (widget.doctorModuleE.selectedTimeSlot != null &&
        widget.doctorModuleE.selectedTimeSlot!.timeSlotPicks != null &&
        widget.doctorModuleE.selectedTimeSlot!.timeSlotPicks!.timeSlots !=
            null) {
      selectedTimeSlots.addAll(
          widget.doctorModuleE.selectedTimeSlot!.timeSlotPicks!.timeSlots!);
    }
    print(selectedTimeSlots);

    List<TimeSlots> timeSlotsList = [];
    for (var applicationLeft in widget.doctorModuleE.applicationLeft) {
      if (applicationLeft.appointMentDetails != null) {
        for (var appointMentDetails in applicationLeft.appointMentDetails!) {
          if (appointMentDetails.timeSlotPicks != null &&
              appointMentDetails.timeSlotPicks!.timeSlots != null) {
            timeSlotsList.addAll(appointMentDetails.timeSlotPicks!.timeSlots!);
          }
        }
      }
    }
    print(timeSlotsList);

    // Merge the two lists and convert to Set to remove duplicates
    Set<TimeSlots> mergedSet = {...selectedTimeSlots, ...timeSlotsList}.toSet();
    print(mergedSet);

    // Create a method to filter duplicates based on hour and minute
    List<TimeSlots> removeDuplicates(List<TimeSlots> list) {
      List<TimeSlots> uniqueList = [];
      Set<String> seenCombos = Set<String>();

      for (var slot in list) {
        String combo = '${slot.hour}:${slot.minute}';

        // If this combo is already in the set, remove it from the uniqueList
        if (seenCombos.contains(combo)) {
          uniqueList.removeWhere(
              (element) => '${element.hour}:${element.minute}' == combo);
        } else {
          uniqueList.add(slot);
        }

        seenCombos.add(combo); // Add all combos to the set to mark as seen
      }

      return uniqueList;
    }

    // Remove all occurrences of duplicates based on hour and minute
    List<TimeSlots> _itemses = removeDuplicates(mergedSet.toList());
    print("items");
    print(_itemses);

    setState(() {
      _items = _itemses; // Assign values to _items here
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
                      selectedColor: const Color.fromARGB(255, 110, 116, 122),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 113, 120, 126)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          color: const Color.fromARGB(255, 138, 190, 232),
                          width: 2,
                        ),
                      ),
                      buttonIcon: Icon(
                        Icons.access_time,
                        color: const Color.fromARGB(255, 105, 112, 117),
                      ),
                      buttonText: Text(
                        "Selected Time Slot",
                        style: TextStyle(
                          color: Color.fromARGB(255, 116, 122, 129),
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
                        widget.doctorModuleE.selectedTimeSlot!.isVedio == true
                            ? ElevatedButton(
                                onPressed: () {
                                  if (_selectedTimeSlots.length == 1) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (ctx) => CardDoctorDetails(
                                                  isVedio: true,
                                                  timeSlotPicks:
                                                      _selectedTimeSlots,
                                                  doctorModule:
                                                      widget.doctorModuleE,
                                                )));
                                  } else {
                                    showSnackBar(
                                        "Select only One time slot", context);
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 99, 103, 106)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                                child: Text('Video Appointment'),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  if (_selectedTimeSlots.length == 1) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (ctx) => CardDoctorDetails(
                                                  isVedio: false,
                                                  timeSlotPicks:
                                                      _selectedTimeSlots,
                                                  doctorModule:
                                                      widget.doctorModuleE,
                                                )));
                                  } else {
                                    showSnackBar(
                                        "Select only One time slot", context);
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 68, 72, 75)),
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
