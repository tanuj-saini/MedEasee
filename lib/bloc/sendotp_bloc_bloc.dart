import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sendotp_bloc_event.dart';
part 'sendotp_bloc_state.dart';

class SendotpBlocBloc extends Bloc<SendotpBlocEvent, SendotpBlocState> {
  SendotpBlocBloc() : super(SendotpBlocInitial()) {
    on<PhoneNumber >((event, emit)async {
      emit(phoneLoding());
      try{
   
        
      }catch(e){
        return emit(phoneFailure(error: e.toString()));

      }
     
    });
  }
}
