import 'package:flirty/commons/widgets/custom_bottom_bar.dart';
import 'package:flirty/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
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
          child: Text("Profile screen"),
        ),
        bottomNavigationBar: CustomBottomBar(currentRoute: AppRoutes.profile),
      ),
    );
  }
}
