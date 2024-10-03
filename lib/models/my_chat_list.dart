// ignore_for_file: prefer_collection_literals, unnecessary_this, unnecessary_new

class MyChatList {
  String? id;
  String? sender;
  String? recipient;
  String? message;
  String? timestamp;
  bool? seen;
  bool? edited;
  bool? deleted;

  MyChatList(
      {this.id,
      this.sender,
      this.recipient,
      this.message,
      this.timestamp,
      this.seen,
      this.edited,
      this.deleted});

  MyChatList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = json['sender'];
    recipient = json['recipient'];
    message = json['message'];
    timestamp = json['timestamp'];
    seen = json['seen'];
    edited = json['edited'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender'] = this.sender;
    data['recipient'] = this.recipient;
    data['message'] = this.message;
    data['timestamp'] = this.timestamp;
    data['seen'] = this.seen;
    data['edited'] = this.edited;
    data['deleted'] = this.deleted;
    return data;
  }
}
