import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/DoctorScreen/bloc/appointmnet_bloc.dart';
import 'package:med_ease/Gemini/ChatScreen.dart';
import 'package:med_ease/Modules/DoctorModify.dart';
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';
import 'package:med_ease/UserScreens/StartScreen.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/CustomTextfield.dart';
import 'package:med_ease/Utils/LoderScreen.dart';
import 'package:med_ease/Utils/timeSlot.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorModifyScreen extends StatefulWidget {
  DoctorModifyScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _DoctorScreen();
  }
}

class _DoctorScreen extends State<DoctorModifyScreen> {
  List<TimeSlot> _items = [];
  List<TimeSlot> _selectedTimeSlots = [];

  @override
  void initState() {
    super.initState();
    _generateTimeSlots();
  }

  void _generateTimeSlots() {
    for (var i = 0; i < 24; i++) {
      _items.add(TimeSlot(hour: i)); // 정시
      _items.add(TimeSlot(hour: i, minute: 15)); // 15분
      _items.add(TimeSlot(hour: i, minute: 30)); // 30분
      _items.add(TimeSlot(hour: i, minute: 45)); // 45분
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController priceController = TextEditingController();
    final TextEditingController titleContoller = TextEditingController();

    final sendModifyAppointMent = BlocProvider.of<AppointmnetBloc>(context);
    return BlocConsumer<AppointmnetBloc, AppointmnetState>(
        listener: (context, state) {
      if (state is AppointmentFailure) {
        showSnackBar(state.error, context);
      }
      if (state is AppointmentSuccess) {
        // final doctorBloc = context.read<DoctorBloc>();

        // doctorBloc.updateDoctor(state.doctorModule);
        Navigator.of(context).pop();
      }
    }, builder: (context, state) {
      if (state is AppointmentLoding) {
        return Loder();
      }
      return Scaffold(
        appBar: AppBar(
          title: Text("Select title"),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.save))],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: MultiSelectDialogField(
                items: _items
                    .map((timeSlot) => MultiSelectItem<TimeSlot>(
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
            SizedBox(
              height: 20,
            ),
            CustomTextField(
                controller: priceController,
                hintText: "Price",
                iconButton: Icon(Icons.price_change)),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
                controller: titleContoller,
                hintText: "Title",
                iconButton: Icon(Icons.text_rotation_none_rounded)),
            ElevatedButton(
                onPressed: () {
                  sendModifyAppointMent.add(AppointMentDetailsEvent(
                      title: titleContoller.text,
                      context: context,
                      price: priceController.text,
                      timeSlots: _selectedTimeSlots));
                },
                child: Text("add")),
          ],
        ),
      );
    });
  }
}
