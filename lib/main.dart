import 'package:flutter/material.dart';

import 'features/game/presentation/pages/splash_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const SpaceGameApp());
}

class SpaceGameApp extends StatelessWidget {
  const SpaceGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space Empire',
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF1a237e),
        scaffoldBackgroundColor: const Color(0xFF0d1117),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1a237e),
          elevation: 0,
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
