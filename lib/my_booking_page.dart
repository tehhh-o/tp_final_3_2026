import 'package:flutter/material.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:s01_day3_am_project/module/booking.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({super.key});

  @override
  State<MyBookingPage> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  final box = Hive.box<Booking>('Bookings');
  @override
  Widget build(BuildContext context) {
    final bookings = box.values.toList();
    final ts = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Bookings',
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
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      return Card(
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
                              Text(
                                'Date: ${booking.date.toString().split('')[0]}',
                              ),
                              Text(
                                'People: ${booking.peopleAmountC.toString()}',
                              ),
                              Text(
                                'Transport: ${booking.addTransport ? 'Yes' : 'No'}',
                              ),
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
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
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
                                    setState(() {
                                      box.delete(box.keyAt(index));
                                    });
                                  },
                                  child: Text('Remove Booking.'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
