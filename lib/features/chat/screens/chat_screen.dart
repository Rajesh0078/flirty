import 'package:flirty/commons/widgets/custom_bottom_bar.dart';
import 'package:flirty/constants/colors.dart';
import 'package:flirty/features/chat/widgets/chat_page.dart';
import 'package:flirty/models/my_conversations.dart';
import 'package:flirty/provider/coversations_provider.dart';
import 'package:flirty/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _onSearch() {
    print('Searching for: $_searchQuery');
  }

  @override
  Widget build(BuildContext context) {
    final List<MyConversations> conversations =
        ref.watch(conversationsProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 6,
              toolbarHeight: 56,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/logo.svg",
                      height: 24,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      "roaster",
                      style: TextStyle(
                        color: CColors.primary,
                        fontSize: 28,
                        fontFamily: "Gazpacho",
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                SvgPicture.asset(
                  "assets/svg/bell.svg",
                  height: 25,
                  colorFilter: const ColorFilter.mode(
                    Color.fromARGB(255, 127, 123, 123),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 24),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        filled: true,
                        hintStyle: const TextStyle(color: CColors.accent),
                        fillColor: const Color.fromARGB(255, 236, 236, 236),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: conversations.length,
                      itemBuilder: (context, index) {
                        final conversation = conversations[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          splashColor: Colors.transparent,
                          tileColor: Colors.transparent,
                          title: Text(conversation.username ?? ''),
                          subtitle:
                              Text(conversation.lastMessage?.content ?? ''),
                          leading: conversation.profilePic != null
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(conversation.profilePic!),
                                )
                              : null,
                          onTap: () {
                            Navigator.push(
                              context,
                              PageAnimationTransition(
                                page: ChatPage(
                                  userId: conversation.recipientId!,
                                  username: conversation.username!,
                                  profilePic: conversation.profilePic!,
                                ),
                                pageAnimationType: FadeAnimationTransition(),
                              ),
                            );
                          },
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              ref
                                  .read(conversationsProvider.notifier)
                                  .removeConversation(
                                      conversation.recipientId!);
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomBar(currentRoute: AppRoutes.chat),
      ),
    );
  }
}
