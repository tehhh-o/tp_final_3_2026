import 'package:flutter/material.dart';
import 'package:s01_day3_am_project/module/event.dart';
import 'package:s01_day3_am_project/package_page.dart';

class DetailPage extends StatelessWidget {
  final Event event;
  const DetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          event.name,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  event.img,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Text(
                  event.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(event.desc, style: ts.titleSmall),
                ),
                Text(event.info, style: ts.bodyMedium),
                SizedBox(height: 32),
                Align(
                  alignment: AlignmentGeometry.center,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PackagePage(event: event),
                      ),
                    ),
                    child: Text('View Festival Package'),
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
