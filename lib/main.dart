import 'package:flirty/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flirty/utils/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CAppTheme.appTheme,
      initialRoute: "/",
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
