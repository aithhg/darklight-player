import 'package:flutter/material.dart';
import 'core/router.dart';
import 'core/theme.dart';

class DarkLightApp extends StatelessWidget {
  const DarkLightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DarkLight Player',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
