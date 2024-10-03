import 'package:flirty/models/my_chat_list.dart';
import 'package:flirty/models/my_conversations.dart';
import 'package:flirty/provider/all_messages_provider.dart';
import 'package:flirty/provider/coversations_provider.dart';
import 'package:flirty/routes/api_routes.dart';
import 'package:flirty/utils/dio/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatService {
  final DioClient dioClient = DioClient();

  Future<void> fetchConversations(WidgetRef ref) async {
    try {
      final response = await dioClient.get(ApiRoutes.getConvo);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        List<MyConversations> conversations =
            data.map((json) => MyConversations.fromJson(json)).toList();

        ref
            .read(conversationsProvider.notifier)
            .updateConversations(conversations);
      } else {
        throw Exception('Failed to load conversations');
      }
    } catch (e) {
      print('Error fetching conversations: $e');
      throw Exception('Error fetching conversations');
    }
  }

  Future<void> fetchMyChatList(WidgetRef ref) async {
    try {
      final response = await dioClient.get(ApiRoutes.getChatList);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];

        List<MyChatList> messages =
            data.map((json) => MyChatList.fromJson(json)).toList();

        ref.read(allMessegesProvider.notifier).upadateMessages(messages);
      } else {
        throw Exception('Failed to load conversations');
      }
    } catch (e) {
      print('Error fetching conversations: $e');
      throw Exception('Error fetching conversations');
    }
  }
}
