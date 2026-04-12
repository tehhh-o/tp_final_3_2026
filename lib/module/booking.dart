import 'package:s01_day3_am_project/module/event.dart';

class Booking {
  final Event event;
  final Package package;
  final String name;
  final String phoneEmail;
  final int peopleAmountC;
  final DateTime date;
  final bool addTransport;
  final bool addMeal;
  final double basePrice;
  final double perPersonTotal;
  final double transportTotal;
  final double mealTotal;
  final double subTotal;
  final double discount;
  final double total;

  Booking({
    required this.event,
    required this.package,
    required this.name,
    required this.phoneEmail,
    required this.peopleAmountC,
    required this.date,
    required this.addTransport,
    required this.addMeal,
    required this.basePrice,
    required this.perPersonTotal,
    required this.transportTotal,
    required this.mealTotal,
    required this.subTotal,
    required this.discount,
    required this.total,
  });
}
