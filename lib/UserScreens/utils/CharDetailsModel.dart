class ChatDetailed {
  String? reciverId;
  List<ChatDetails>? chatDetails;
  String? Id;

  ChatDetailed({this.reciverId, this.chatDetails, this.Id});

  ChatDetailed.fromJson(Map<String, dynamic> json) {
    reciverId = json['reciverId'];
    if (json['chatDetails'] != null) {
      chatDetails = <ChatDetails>[];
      json['chatDetails'].forEach((v) {
        chatDetails!.add(new ChatDetails.fromJson(v));
      });
    }
    Id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reciverId'] = this.reciverId;
    if (this.chatDetails != null) {
      data['chatDetails'] = this.chatDetails!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.Id;
    return data;
  }
}

class ChatDetails {
  String? reciverId;
  String? message;
  String? time;
  bool? itsMe;
  String? Id;

  ChatDetails({
    this.reciverId,
    this.message,
    this.time,
    this.itsMe,
    this.Id,
  });

  ChatDetails.fromJson(Map<String, dynamic> json) {
    reciverId = json['reciverId'];
    message = json['message'];
    time = json['time'];
    itsMe = json['itsMe'];
    Id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reciverId'] = this.reciverId;
    data['message'] = this.message;
    data['time'] = this.time;
    data['itsMe'] = this.itsMe;
    data['_id'] = this.Id;

    return data;
  }
}
