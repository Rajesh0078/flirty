import 'package:flirty/commons/widgets/custom_bottom_bar.dart';
import 'package:flirty/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      },
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text("Chat screen"),
        ),
        bottomNavigationBar: CustomBottomBar(currentRoute: AppRoutes.chat),
      ),
    );
  }
}
