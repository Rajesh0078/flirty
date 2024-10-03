import 'package:flirty/models/my_conversations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConversationsNotifier extends StateNotifier<List<MyConversations>> {
  ConversationsNotifier() : super([]);

  void updateConversations(List<MyConversations> conversations) {
    state = conversations;
  }

  void addConversation(MyConversations conversation) {
    state = [...state, conversation];
  }

  void removeConversation(String recipientId) {
    state = state.where((c) => c.recipientId != recipientId).toList();
  }
}

final conversationsProvider =
    StateNotifierProvider<ConversationsNotifier, List<MyConversations>>((ref) {
  return ConversationsNotifier();
});
