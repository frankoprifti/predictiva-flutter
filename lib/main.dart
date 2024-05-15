import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:predictiva_flutter/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Predictiva',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.black,
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.black,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.white,
        ),
        fontFamily: GoogleFonts.inter().fontFamily,
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
