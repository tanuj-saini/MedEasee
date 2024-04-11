import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_ease/Modules/testModule.dart';
import 'package:med_ease/UpdateModels/UpdateUserModel.dart';
import 'package:med_ease/UserScreens/bloc/book_apppointment_bloc.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/LoderScreen.dart';
import 'package:upi_india/upi_india.dart';
import 'package:upi_india/upi_response.dart';

class PaymentScreen extends StatefulWidget {
  final bool isComplete;
  final String date;
  final String doctorId;
  PaymentScreen(
      {required this.date,
      required this.doctorId,
      required this.isComplete,
      super.key});
  @override
  State<StatefulWidget> createState() {
    return _PaymentScreen();
  }
}

class _PaymentScreen extends State<PaymentScreen> {
  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "8824598603@paytm",
      receiverName: "Medeasse",
      transactionRefId: 'Doctor Hands on you',
      transactionNote: 'Get ease to success',
      amount: 1,
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps!.length == 0)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    else
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status, BuildContext context) {
    final bookAppointment = BlocProvider.of<BookApppointmentBloc>(context);

    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        showSnackBar("Transaction Successful", context);
        // sendOrder(
        //   productModule: widget.productModule,
        //   FarmerName: widget.farmerModule.name,
        //   FarmerId: widget.farmerModule.FarmerUid,
        //   FarmerLati: widget.farmerModule.Farmerlati,
        //   FarmerLogi: widget.farmerModule.FarmerLogi,
        // );

        // Replace with your screen widget

        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        showSnackBar('Transaction Submitted', context);
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');

        bookAppointment.add(BookAppointmentUserEvent(
            date: widget.date,
            context: context,
            doctorId: widget.doctorId,
            isComplete: widget.isComplete));

        showSnackBar('Transaction Failed', context);
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
              child: Text(
            body,
            style: value,
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookApppointmentBloc, BookApppointmentState>(
        listener: (context, state) {
      if (state is BookApppointmentFailure) {
        showSnackBar(state.error, context);
      }
      if (state is BookApppointmentSuccess) {
        final UserBlocUpdate = context.read<UserBloc>();
        UserBlocUpdate.updateUser(state.userModule);
        showSnackBar("Book Complete", context);
      }
    }, builder: (context, state) {
      if (state is BookApppointmentLoding) {
        return Loder();
      }
      return Scaffold(
        appBar: AppBar(
          title: Text('UPI'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: displayUpiApps(),
            ),
            Expanded(
              child: FutureBuilder(
                future: _transaction,
                builder: (BuildContext context,
                    AsyncSnapshot<UpiResponse> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          _upiErrorHandler(snapshot.error.runtimeType),
                          style: header,
                        ), // Print's text message on screen
                      );
                    }

                    // If we have data then definitely we will have UpiResponse.
                    // It cannot be null
                    UpiResponse _upiResponse = snapshot.data!;

                    // Data in UpiResponse can be null. Check before printing
                    String txnId = _upiResponse.transactionId ?? 'N/A';
                    String resCode = _upiResponse.responseCode ?? 'N/A';
                    String txnRef = _upiResponse.transactionRefId ?? 'N/A';
                    String status = _upiResponse.status ?? 'N/A';
                    String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
                    _checkTxnStatus(status, context);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          displayTransactionData('Transaction Id', txnId),
                          displayTransactionData('Response Code', resCode),
                          displayTransactionData('Reference Id', txnRef),
                          displayTransactionData(
                              'Status', status.toUpperCase()),
                          displayTransactionData('Approval No', approvalRef),
                        ],
                      ),
                    );
                  } else
                    return Center(
                      child: Text(''),
                    );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
