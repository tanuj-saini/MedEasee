import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/DoctorScreen/bloc/appointmnet_bloc.dart';
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';
import 'package:med_ease/Utils/CustomTextfield.dart';
import 'package:med_ease/Utils/timeSlot.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class DoctorModifyScreen extends StatefulWidget {
  const DoctorModifyScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DoctorModifyScreenState();
}

class _DoctorModifyScreenState extends State<DoctorModifyScreen> {
  List<TimeSlotD> _items = [];
  List<TimeSlotD> _selectedTimeSlots = [];
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _titleContoller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _generateTimeSlots();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _titleContoller.dispose();
    super.dispose();
  }

  void _generateTimeSlots() {
    for (var i = 0; i < 24; i++) {
      _items.add(TimeSlotD(hour: i)); // 정시
      _items.add(TimeSlotD(hour: i, minute: 15)); // 15분
      _items.add(TimeSlotD(hour: i, minute: 30)); // 30분
      _items.add(TimeSlotD(hour: i, minute: 45)); // 45분
    }
  }

  @override
  Widget build(BuildContext context) {
    final sendModifyAppointMent = BlocProvider.of<AppointmnetBloc>(context);
    final doctorModel = context.watch<DoctorBloc>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select title"),
        actions: [
          IconButton(
            onPressed: () {
              sendModifyAppointMent.add(AppointMentRefresh(
                  context: context, doctorId: doctorModel!.id));
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: BlocConsumer<AppointmnetBloc, AppointmnetState>(
        listener: (context, state) {
          if (state is AppointmentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
          if (state is AppointmentSuccess) {
            final doctorBloc = context.read<DoctorBloc>();
            doctorBloc.updateDoctor(state.doctorModule);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is AppointmentLoding) ...[
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                ],
                context.watch<DoctorBloc>().state?.timeSlot.length == 0
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No TimeSlot Selected",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: context
                                  .watch<DoctorBloc>()
                                  .state
                                  ?.timeSlot
                                  .length ??
                              0,
                          itemBuilder: (BuildContext context, int index) {
                            final timeSlot = context
                                .watch<DoctorBloc>()
                                .state!
                                .timeSlot[index];
                            //  print(timeSlot.appointMentDetails.length);
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: ListTile(
                                trailing: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.mode)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.delete))
                                  ],
                                ),
                                title: Text('Time Slot ${index + 1}'),
                                subtitle: Text(
                                    'Number of Appointments: ${timeSlot.appointMentDetails}'),
                                onTap: () {
                                  // Handle onTap event if needed
                                },
                              ),
                            );
                          },
                        ),
                      ),
                const SizedBox(height: 20),
                Center(
                  child: MultiSelectDialogField(
                    items: _items
                        .map((timeSlot) => MultiSelectItem<TimeSlotD>(
                            timeSlot, timeSlot.toString()))
                        .toList(),
                    title: const Text("Time"),
                    selectedColor: Colors.blue,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.access_time,
                      color: Colors.blue,
                    ),
                    buttonText: const Text(
                      "Selected Time Slot",
                      style: TextStyle(
                        color: Colors.blue,
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
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _priceController,
                        hintText: "Price",
                        iconButton: const Icon(Icons.price_change),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _titleContoller,
                        hintText: "Title",
                        iconButton:
                            const Icon(Icons.text_rotation_none_rounded),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          sendModifyAppointMent.add(
                            AppointMentDetailsEvent(
                              title: _titleContoller.text,
                              context: context,
                              price: _priceController.text,
                              timeSlots: _selectedTimeSlots,
                            ),
                          );
                          setState(() {});
                        },
                        child: const Text("add"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
