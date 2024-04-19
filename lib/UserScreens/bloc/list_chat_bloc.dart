import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:med_ease/Login_SignIn/bloc/sign_up_bloc.dart';
import 'package:med_ease/UserScreens/utils/CharDetailsModel.dart';
import 'package:med_ease/Utils/Colors.dart';
import 'package:med_ease/Utils/errorHandiling.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'list_chat_event.dart';
part 'list_chat_state.dart';

class ListChatBloc extends Bloc<ListChatEvent, ListChatState> {
  ListChatBloc() : super(ListChatInitial()) {
    on<listChatEvents>((event, emit) async {
      emit(listChatLoding());

      try {
        print(event.isDoctor);
        http.Response res = await http.post(Uri.parse("$ip/get/ListChat"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              "isDoctor": event.isDoctor,
              "currentId": event.currentId,
              "reciverId": event.reciverId,
            }));
        print("hello chat");
        print(res.body);
        _httpErrorHandle(res, emit, event.context);
        List<ChatDetailed> chatInfoList = [];
        List<Map<String, dynamic>> jsonDataList =
            List<Map<String, dynamic>>.from(json.decode(res.body));

        chatInfoList =
            jsonDataList.map((json) => ChatDetailed.fromJson(json)).toList();

        return emit(listChatSuccess(chatInfoList: chatInfoList[0]));
      } catch (e) {
        return emit(listChatFailure(error: e.toString()));
      }
    });
  }
}
