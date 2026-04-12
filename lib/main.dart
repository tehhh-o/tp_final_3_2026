import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s01_day3_am_project/home_page.dart';
import 'package:s01_day3_am_project/provider/booking_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BookingProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
          titleMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          titleSmall: TextStyle(
            color: Colors.black54,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(fontSize: 14),
          bodySmall: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 241, 53, 116),
        ),
      ),
      home: const HomePage(),
    );
  }
}
