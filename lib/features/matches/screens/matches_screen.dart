import 'package:flirty/commons/widgets/custom_bottom_bar.dart';
import 'package:flirty/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchesScreen extends ConsumerStatefulWidget {
  const MatchesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends ConsumerState<MatchesScreen> {
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
          child: Text("Matches screen"),
        ),
        bottomNavigationBar: CustomBottomBar(currentRoute: AppRoutes.matches),
      ),
    );
  }
}
