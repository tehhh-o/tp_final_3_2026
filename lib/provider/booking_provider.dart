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
