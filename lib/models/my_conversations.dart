// ignore_for_file: unnecessary_new, unnecessary_question_mark

class MyConversations {
  String? recipientId;
  String? username;
  String? profilePic;
  LastMessage? lastMessage;

  MyConversations(
      {this.recipientId, this.username, this.profilePic, this.lastMessage});

  MyConversations.fromJson(Map<String, dynamic> json) {
    recipientId = json['recipientId'];
    username = json['username'];
    profilePic = json['profile_pic'];
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipientId'] = recipientId;
    data['username'] = username;
    data['profile_pic'] = profilePic;
    if (lastMessage != null) {
      data['lastMessage'] = lastMessage!.toJson();
    }
    return data;
  }
}

class LastMessage {
  String? sId;
  String? sender;
  String? recipient;
  String? content;
  bool? seen;
  bool? edited;
  bool? deleted;
  Null? deletedAt;
  String? editedAt;
  String? timestamp;

  LastMessage(
      {this.sId,
      this.sender,
      this.recipient,
      this.content,
      this.seen,
      this.edited,
      this.deleted,
      this.deletedAt,
      this.editedAt,
      this.timestamp});

  LastMessage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sender = json['sender'];
    recipient = json['recipient'];
    content = json['content'];
    seen = json['seen'];
    edited = json['edited'];
    deleted = json['deleted'];
    deletedAt = json['deletedAt'];
    editedAt = json['editedAt'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sender'] = sender;
    data['recipient'] = recipient;
    data['content'] = content;
    data['seen'] = seen;
    data['edited'] = edited;
    data['deleted'] = deleted;
    data['deletedAt'] = deletedAt;
    data['editedAt'] = editedAt;
    data['timestamp'] = timestamp;
    return data;
  }
}
