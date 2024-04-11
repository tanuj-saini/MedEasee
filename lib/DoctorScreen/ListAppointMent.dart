import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/DoctorScreen/bloc/refresh_doctor_bloc.dart';
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/LoderScreen.dart';

class ListAppointmentScreen extends StatefulWidget {
  ListAppointmentScreen({Key? key}) : super(key: key);

  @override
  _ListAppointmentScreenState createState() => _ListAppointmentScreenState();
}

class _ListAppointmentScreenState extends State<ListAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    final doctorModel = context.watch<DoctorBloc>().state;
    print(doctorModel!.applicationLeft.length);
    print("heoolo");
    final refreshDoctorModule = BlocProvider.of<RefreshDoctorBloc>(context);
    return BlocConsumer<RefreshDoctorBloc, RefreshDoctorState>(
      listener: (context, state) {
        if (state is RefreshDoctorFailure) {
          showSnackBar(state.error, context);
        }
        if (state is RefreshDoctorSuccess) {
          final doctorBloc = context.read<DoctorBloc>();
          doctorBloc.updateDoctor(state.doctor);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text("List of Appointments"),
              actions: [
                IconButton(
                    onPressed: () => refreshDoctorModule.add(
                        RefreshDoctorListEvent(
                            context: context, doctorId: doctorModel.id)),
                    icon: Icon(Icons.refresh_rounded))
              ],
            ),
            body: doctorModel.applicationLeft.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Appointments Found",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: doctorModel.applicationLeft.length,
                    itemBuilder: (BuildContext context, int index) {
                      final appointment = doctorModel.applicationLeft[index];
                      if (state is RefreshDoctorLoding) {
                        return Loder();
                      }
                      return Card(
                        child: ListTile(
                          title: Text('Appointment ID: ${appointment.id}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('User ID: ${appointment.userId}'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: appointment.appointMentDetails!
                                    .map((detail) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Date: ${detail.date}'),
                                      Text('User ID: ${detail.userId}'),
                                      Text('Is Complete: ${detail.isComplete}'),
                                      Divider(),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ));
      },
    );
  }
}
