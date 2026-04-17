import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:s01_day3_am_project/hive/hive_registrar.g.dart';
import 'package:s01_day3_am_project/home_page.dart';
import 'package:s01_day3_am_project/module/booking.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapters();
  await Hive.openBox<Booking>('Bookings');
  runApp(MyApp());
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
        cardTheme: CardThemeData(
          elevation: 2,
          color: const Color.fromARGB(255, 254, 245, 248),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(elevation: 1.5),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      home: const HomePage(),
    );
  }
}
