import 'package:flutter/material.dart';
import 'package:s01_day3_am_project/booking_form_page.dart';
import 'package:s01_day3_am_project/helper/route.dart';
import 'package:s01_day3_am_project/module/event.dart';

class PackagePage extends StatefulWidget {
  final Event event;
  const PackagePage({super.key, required this.event});

  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final ts = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${event.name} Packages',
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
                    itemCount: event.package.length,
                    itemBuilder: (context, index) {
                      final package = event.package[index];

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(package.title, style: ts.titleMedium),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: Text(package.desc, style: ts.bodyMedium),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Base: RM${package.basePrice.toString()}',
                                    style: ts.bodySmall,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Per Person: RM${package.perPerson.toString()}',
                                    style: ts.bodySmall,
                                  ),
                                ],
                              ),
                              Align(
                                alignment: AlignmentGeometry.centerRight,
                                child: ElevatedButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    SlideFadeRoute(
                                      page: BookingFormPage(
                                        package: package,
                                        event: event,
                                      ),
                                    ),
                                  ),
                                  child: Text('Book Now'),
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
