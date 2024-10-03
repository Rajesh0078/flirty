import 'package:flirty/relatime/ably_service.dart';
import 'package:flirty/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flirty/utils/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtain the ProviderContainer
    final container = ProviderScope.containerOf(context);

    // Initialize AblyService
    final ablyService = AblyService(container);
    ablyService.initialize();
    ablyService.subscribeToOnlineUsers();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CAppTheme.appTheme,
      title: "Flirty",
      initialRoute: "/",
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
