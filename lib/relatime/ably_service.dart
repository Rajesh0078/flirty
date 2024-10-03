import 'dart:async';

import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:flirty/models/my_chat_list.dart';
import 'package:flirty/provider/all_messages_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AblyService {
  ably.Realtime? realtime;
  final ProviderContainer container;

  AblyService(this.container);

  Future<void> initialize() async {
    realtime = ably.Realtime(
      key: "SWusOw.bTcFEw:A6a7c0ohXKvts1_z_T8rfDiBFR2nnVuKYu6DQCm0dKk",
    );
  }

  Future<void> subscribeToOnlineUsers() async {
    ably.RealtimeChannel channel = realtime!.channels.get('chat');
    channel.subscribe(name: "message").listen((ably.Message message) {
      if (message.data is Map) {
        final data = message.data as Map;

        final msgData = {
          'id': data['_id'],
          'sender': data['sender'],
          'recipient': data['recipient'],
          'message': data['content'],
          'timestamp': data['timestamp'],
          'seen': data['seen'],
          'edited': data['edited'],
          'deleted': data['deleted'],
        };
        final newMessage = MyChatList.fromJson(msgData);

        container.read(allMessegesProvider.notifier).addMessage(newMessage);
      } else {
        print('Unexpected data format: ${message.data}');
      }
    });
  }
}
