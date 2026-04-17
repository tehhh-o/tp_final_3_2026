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

    TableRow row(String label, String value) {
      return TableRow(children: [Text("$label:"), Text(value)]);
    }

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
          Opacity(
            opacity: 0.15,
            child: Image.asset(
              'images/bg.jpg',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
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
                    Text(
                      booking.event.name,
                      style: ts.titleMedium?.copyWith(fontSize: 28),
                    ),
                    Text(
                      booking.package.title,
                      style: ts.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(),
                        1: FixedColumnWidth(80),
                      },
                      children: [
                        row('Name', booking.name),
                        row('Contact', booking.phoneEmail),
                        row('Date', booking.date.toString().split(' ')[0]),
                        row('People', booking.peopleAmountC.toString()),
                        row('Transport', booking.addTransport ? 'Yes' : 'No'),
                        row('Meal', booking.addMeal ? 'Yes' : 'No'),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text('Price Breakdown', style: ts.titleMedium),
                    SizedBox(height: 8),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(),
                        1: FixedColumnWidth(80),
                      },
                      children: [
                        row(
                          'Base Price',
                          'RM ${booking.basePrice.toStringAsFixed(2)}',
                        ),
                        row(
                          'Per Person',
                          'RM ${booking.perPersonTotal.toStringAsFixed(2)}',
                        ),
                        row(
                          'Transport',
                          'RM ${booking.transportTotal.toStringAsFixed(2)}',
                        ),
                        row(
                          'Meals',
                          'RM ${booking.mealTotal.toStringAsFixed(2)}',
                        ),
                        row(
                          'Discount',
                          'RM ${booking.discount.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(thickness: 2, height: 2),
                    ),
                    Text(
                      'Total: RM${booking.total.toStringAsFixed(2)}',
                      style: ts.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                      ),
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
