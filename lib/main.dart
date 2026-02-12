import 'package:flutter/material.dart';
import 'package:website/core/theme/app_theme.dart';
import 'package:website/pages/home_page.dart';

void main() {
  runApp(const CricketTournamentWebApp());
}

class CricketTournamentWebApp extends StatelessWidget {
  const CricketTournamentWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cricket Tournament Website',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      home: const HomePage(),
    );
  }
}
