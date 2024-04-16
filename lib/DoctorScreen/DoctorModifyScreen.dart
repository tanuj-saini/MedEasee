import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/DoctorScreen/bloc/appointmnet_bloc.dart';
import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/CustomTextfield.dart';
import 'package:med_ease/Utils/timeSlot.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class DoctorModifyScreen extends StatefulWidget {
  const DoctorModifyScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DoctorModifyScreenState();
}

enum AppointmentType { Normal, Video }

class _DoctorModifyScreenState extends State<DoctorModifyScreen> {
  List<TimeSlotD> _items = [];
  List<TimeSlotD> _selectedTimeSlots = [];
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _titleContoller = TextEditingController();
  AppointmentType _selectedType = AppointmentType.Normal;

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
          ),
          IconButton(
              onPressed: () {
                sendModifyAppointMent.add(AppointMentSelectedTimeSlot(
                    context: context,
                    isVedio:
                        _selectedType == AppointmentType.Normal ? false : true,
                    doctorId: doctorModel!.id,
                    price: _priceController.text,
                    title: _titleContoller.text,
                    timeSlots: _selectedTimeSlots,
                    date: DateTime.now().toString()));
                showSnackBar("Successfully Updated Time Slot", context);
              },
              icon: Icon(Icons.save))
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

                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        doctorModel!.selectedTimeSlot!.title ==
                                                timeSlot.appointMentDetails![0]
                                                    .title
                                            ? Border.all(
                                                color: Colors
                                                    .greenAccent, // Change this to your desired bright green color
                                                width:
                                                    2.0, // Adjust the border width as needed
                                              )
                                            : null),
                                child: ListTile(
                                  title: Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        Text(
                                          '${timeSlot.appointMentDetails![0].title}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            'Price: ${timeSlot.appointMentDetails![0].price}'),
                                        timeSlot.appointMentDetails![0]
                                                    .isVedio ==
                                                false
                                            ? Text('isVedio: False')
                                            : Text("isVedio: True")
                                      ],
                                    ),
                                  ),
                                  subtitle: SingleChildScrollView(
                                    scrollDirection: Axis
                                        .horizontal, // Set the scroll direction to horizontal
                                    child: Row(
                                      children: [
                                        for (int i = 0;
                                            i <
                                                timeSlot
                                                    .appointMentDetails![0]
                                                    .timeSlotPicks![0]
                                                    .timeSlot![0]
                                                    .timeSlots!
                                                    .length;
                                            i++)
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Text(
                                              '${timeSlot.appointMentDetails![0].timeSlotPicks![0].timeSlot![0].timeSlots![i].hour.toString().padLeft(2, '0')}:${timeSlot.appointMentDetails![0].timeSlotPicks![0].timeSlot![0].timeSlots![i].minute.toString().padLeft(2, '0')}',
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    int length = timeSlot
                                        .appointMentDetails![0]
                                        .timeSlotPicks![0]
                                        .timeSlot![0]
                                        .timeSlots!
                                        .length;
                                    List<TimeSlotD> selectedTimeSlots = [];
                                    for (int i = 0; i < length; i++) {
                                      int hour = timeSlot
                                              .appointMentDetails![0]
                                              .timeSlotPicks![0]
                                              .timeSlot![0]
                                              .timeSlots![i]
                                              .hour ??
                                          0;
                                      0;
                                      int minute = timeSlot
                                              .appointMentDetails![0]
                                              .timeSlotPicks![0]
                                              .timeSlot![0]
                                              .timeSlots![i]
                                              .minute ??
                                          0;
                                      0;

                                      TimeSlotD timeSlotsed =
                                          TimeSlotD(hour: hour, minute: minute);
                                      selectedTimeSlots.add(timeSlotsed);
                                    }
                                    sendModifyAppointMent.add(
                                      AppointMentSelectedTimeSlot(
                                          isVedio: timeSlot
                                                      .appointMentDetails![0]
                                                      .isVedio ==
                                                  false
                                              ? false
                                              : true,
                                          context: context,
                                          doctorId: doctorModel.id,
                                          price: timeSlot
                                              .appointMentDetails![0].price
                                              .toString(),
                                          title: timeSlot.appointMentDetails![0]
                                                  .title ??
                                              "",
                                          timeSlots: selectedTimeSlots,
                                          date: DateTime.now().toString()),
                                    );
                                    showSnackBar(
                                        "Successfully Updated Time Slot",
                                        context);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  child: Center(
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
                      Row(
                        children: [
                          Radio(
                            value: AppointmentType.Normal,
                            groupValue: _selectedType,
                            onChanged: (AppointmentType? value) {
                              setState(() {
                                _selectedType = value!;
                              });
                            },
                          ),
                          Text('Normal'),
                          SizedBox(width: 20),
                          Radio(
                            value: AppointmentType.Video,
                            groupValue: _selectedType,
                            onChanged: (AppointmentType? value) {
                              setState(() {
                                _selectedType = value!;
                              });
                            },
                          ),
                          Text('Video'),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          sendModifyAppointMent.add(
                            AppointMentDetailsEvent(
                              isVedio: _selectedType == AppointmentType.Normal
                                  ? false
                                  : true,
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
