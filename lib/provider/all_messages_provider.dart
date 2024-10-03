import 'package:flirty/models/my_chat_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllMessagesNotifier extends StateNotifier<List<MyChatList>> {
  AllMessagesNotifier() : super([]);

  void upadateMessages(List<MyChatList> conversations) {
    state = conversations;
  }

  void addMessage(MyChatList conversation) {
    state = [...state, conversation];
  }

  void removeMessage(String recipientId) {
    state = state.where((c) => c.recipient != recipientId).toList();
  }
}

final allMessegesProvider =
    StateNotifierProvider<AllMessagesNotifier, List<MyChatList>>((ref) {
  return AllMessagesNotifier();
});
