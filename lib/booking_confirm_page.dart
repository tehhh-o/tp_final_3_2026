import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:s01_day3_am_project/module/booking.dart';

class BookingConfirmPage extends StatelessWidget {
  final box = Hive.box<Booking>('Bookings');
  final Booking booking;
  BookingConfirmPage({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Confirmed',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.deepOrange[500],
      ),

      body: Stack(
        children: [
          Image.asset(
            'images/bg.jpg',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
            color: Colors.white.withAlpha(140),
            colorBlendMode: BlendMode.lighten,
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(booking.event.name, style: ts.titleMedium),
                    Text(booking.package.title, style: ts.bodyLarge),
                    SizedBox(height: 8),
                    Text('Name: ${booking.name}'),
                    Text('Contact: ${booking.phoneEmail}'),
                    Text('Date: ${booking.date.toString().split('')[0]}'),
                    Text('People: ${booking.peopleAmountC.toString()}'),
                    Text('Transport: ${booking.addTransport ? 'Yes' : 'No'}'),
                    Text('Meal: ${booking.addMeal ? 'Yes' : 'No'}'),
                    SizedBox(height: 16),
                    Text('Price Breakdown', style: ts.titleMedium),
                    Text(
                      'Base Price : RM ${booking.basePrice.toStringAsFixed(2)}',
                      style: ts.bodyMedium,
                    ),
                    Text(
                      'Per Person Total : RM ${booking.perPersonTotal.toStringAsFixed(2)}',
                      style: ts.bodyMedium,
                    ),
                    Text(
                      'Transport : RM ${booking.transportTotal.toStringAsFixed(2)}',
                      style: ts.bodyMedium,
                    ),
                    Text(
                      'Meals : RM ${booking.mealTotal.toStringAsFixed(2)}',
                      style: ts.bodyMedium,
                    ),
                    Text(
                      'Discount : RM ${booking.discount.toStringAsFixed(2)}',
                      style: ts.bodyMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(thickness: 2, height: 2),
                    ),
                    Text(
                      'Total: RM${booking.total.toStringAsFixed(2)}',
                      style: ts.titleMedium,
                    ),

                    SizedBox(height: 20),
                    Align(
                      alignment: AlignmentGeometry.center,
                      child: ElevatedButton(
                        onPressed: () {
                          box.add(booking);
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: Text('Back To Home'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
