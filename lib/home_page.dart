import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:s01_day3_am_project/detail_page.dart';
import 'package:s01_day3_am_project/helper/route.dart';
import 'package:s01_day3_am_project/module/event.dart';
import 'package:s01_day3_am_project/my_booking_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Event>>? futureEvents;

  Future<List<Event>> getEvents() async {
    final json = await rootBundle.loadString('rss/data.json');
    final body = jsonDecode(json);
    final events = body.map<Event>((e) => Event.fromJson(e)).toList();

    return events;
  }

  @override
  void initState() {
    super.initState();
    futureEvents = getEvents();
  }

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('FestivalQuest MY'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.push(context, SlideFadeRoute(page: MyBookingPage())),
            icon: Icon(Icons.calendar_month, color: Colors.black),
          ),
          IconButton(
            onPressed: () => SystemNavigator.pop(),
            icon: Icon(Icons.exit_to_app, color: Colors.black),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Event>>(
                future: futureEvents,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text(' No data found'));
                  }

                  final events = snapshot.data!;

                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];

                      return InkWell(
                        child: Card(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Image.asset(
                                    event.img,
                                    height: 180,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
                                  Container(
                                    height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withAlpha(180),
                                        ],
                                        begin: AlignmentGeometry.topCenter,
                                        end: AlignmentGeometry.bottomCenter,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Text(
                                      event.name,
                                      style: ts.titleLarge,
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: EdgeInsetsGeometry.all(12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            event.name,
                                            style: ts.titleMedium,
                                          ),
                                          Text(
                                            event.desc,
                                            style: ts.titleSmall,
                                            maxLines: 3,
                                          ),
                                        ],
                                      ),
                                    ),

                                    IconButton(
                                      onPressed: () => Navigator.push(
                                        context,
                                        SlideFadeRoute(
                                          page: DetailPage(event: event),
                                        ),
                                      ),
                                      icon: Icon(Icons.keyboard_arrow_right),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
