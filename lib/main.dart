import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/lessons/lesson1_intro_screen.dart';
import 'screens/lessons/lesson2_appbar_screen.dart';
import 'screens/lessons/lesson3_list_grid_screen.dart';
import 'screens/lessons/lesson4_persistent_header_screen.dart';

void main() {
  runApp(const LearningSliversApp());
}

class LearningSliversApp extends StatelessWidget {
  const LearningSliversApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Slivers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
        cardTheme: const CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/lesson1': (context) => const Lesson1IntroScreen(),
        '/lesson2': (context) => const Lesson2AppBarScreen(),
        '/lesson3': (context) => const Lesson3ListGridScreen(),
        '/lesson4': (context) => const Lesson4PersistentHeaderScreen(),
      },
    );
  }
}
