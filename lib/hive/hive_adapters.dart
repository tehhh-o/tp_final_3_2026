import 'package:hive_ce/hive_ce.dart';
import 'package:s01_day3_am_project/module/booking.dart';
import 'package:s01_day3_am_project/module/event.dart';

@GenerateAdapters([
  AdapterSpec<Booking>(),
  AdapterSpec<Event>(),
  AdapterSpec<Package>(),
])
part 'hive_adapters.g.dart';
