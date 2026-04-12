import 'package:flutter/material.dart';
import 'package:s01_day3_am_project/module/booking.dart';

class BookingProvider extends ChangeNotifier {
  final List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;

  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  void removeBooking(Booking booking) {
    _bookings.remove(booking);
    notifyListeners();
  }

  bool isBooked(Booking booking) {
    return _bookings.contains(booking);
  }
}

class BookingScope extends InheritedNotifier<BookingProvider> {
  const BookingScope({
    super.key,
    required super.notifier,
    required super.child,
  });

  static BookingProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BookingScope>()!
        .notifier!;
  }
}
