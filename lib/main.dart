import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_quran/pages/splashScreen.dart';
import 'package:read_quran/provider.dart/bookmarkProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Read Quran',
      home: SplashScreen(),
    );
  }
}