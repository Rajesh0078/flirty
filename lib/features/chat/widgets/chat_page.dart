import 'package:flirty/features/chat/widgets/chat_bubble.dart';
import 'package:flirty/models/my_chat_list.dart';
import 'package:flirty/provider/all_messages_provider.dart';
import 'package:flirty/provider/user_provider.dart';
import 'package:flirty/routes/api_routes.dart';
import 'package:flirty/utils/dio/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String userId; // Current user ID
  final String username; // Current user name
  final String profilePic; // Current user profile picture

  const ChatPage({
    super.key,
    required this.userId,
    required this.username,
    required this.profilePic,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final DioClient dioClient = DioClient();

  void _sendMessage(id) async {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      final result = await dioClient.post(ApiRoutes.sendMessage, {
        "sender": id,
        "recipient": widget.userId,
        "content": message,
        "seen": false,
        "edited": true,
        "deleted": false,
      });
      print(result.data);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<MyChatList> chatList = ref.watch(allMessegesProvider);
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.profilePic),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Text(widget.username),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                final chatItem = chatList[index];
                final isSender = chatItem.sender == widget.userId;
                return ChatBubble(
                  message: chatItem.message ?? '',
                  isSender: !isSender,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 244, 241, 241),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(user!['_id']);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
