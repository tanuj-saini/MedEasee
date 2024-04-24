import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:med_ease/DoctorScreen/AppointDoctorCard.dart';
import 'package:med_ease/DoctorScreen/AppointLessDoctor.dart';
import 'package:med_ease/DoctorScreen/bloc/hist_appoint_bloc.dart';
import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/Modules/testUserModule.dart';
import 'package:med_ease/UpdateModels/UpdateDoctorModule.dart';
import 'package:med_ease/UserScreens/bloc/list_chat_bloc.dart';
import 'package:med_ease/UserScreens/utils/AppointMentHistoryCard.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/LoderScreen.dart';

class AppointMentHistory extends StatefulWidget {
  final String doctorId;
  AppointMentHistory({required this.doctorId, super.key});
  @override
  State<StatefulWidget> createState() {
    return _AppointMentHistory();
  }
}

class _AppointMentHistory extends State<AppointMentHistory> {
  @override
  Widget build(BuildContext context) {
    final doctorModel = context.watch<DoctorBloc>().state;
    List<AppointMentDetails>? appointmentHistory =
        doctorModel?.appointMentHistory;

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment History'),
      ),
      body: appointmentHistory != null && appointmentHistory.isNotEmpty
          ? ListView.builder(
              itemCount: appointmentHistory.length,
              itemBuilder: (context, index) {
                return AppointmentHistorylessDoctor(
                  appointment: appointmentHistory[index],
                );
              },
            )
          : Center(
              child: Text(
                'No Appointments',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
    );
  }
}




// return BlocConsumer<ListChatBloc, ListChatState>(
//       listener: (context, state) {
//         if (state is listChatFailure) {
//           showSnackBar(state.error, context);
//         }
//         if (state is ) {
//           final userBloc = context.read<UserBloc>();
//           userBloc.updateUser(state.user);
//           setState(() {
//             newMessages = state.messageCountSee;
//           });
//         }
//       },
//       builder: (context, state) {
//         if (state is listChatLoding) {
//           return Loder();
//         }
//         return Scaffold(
//           appBar: AppBar(
//             title: Text('Appointment History'),
//           ),
//           body: appointmentHistory != null && appointmentHistory.isNotEmpty
//               ? ListView.builder(
//                   itemCount: appointmentHistory.length,
//                   itemBuilder: (context, index) {
//                     allDoctorData.add(setMessageCountUpdateUser(
//                         appointMentId: appointmentHistory[index].id ?? "",
//                         context: context));
//                     return AppointmentHistoryCardUser(
//                       newMessages: newMessages,
//                       appointment: appointmentHistory[index],
//                     );
//                   },
//                 )
//               : Center(
//                   child: Text(
//                     'No Appointments',
//                     style: TextStyle(fontSize: 20.0),
//                   ),
//                 ),
//         );
//       },
//     );
//   }
// }
