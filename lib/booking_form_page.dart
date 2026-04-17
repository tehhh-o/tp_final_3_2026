import 'package:flutter/material.dart';
import 'package:s01_day3_am_project/booking_confirm_page.dart';
import 'package:s01_day3_am_project/helper/route.dart';
import 'package:s01_day3_am_project/helper/snackbar_helper.dart';
import 'package:s01_day3_am_project/module/booking.dart';
import 'package:s01_day3_am_project/module/event.dart';
import 'package:s01_day3_am_project/widgets/animated_price_tag.dart';
import 'package:s01_day3_am_project/widgets/custom_form_field.dart';

class BookingFormPage extends StatefulWidget {
  final Event event;
  final Package package;
  const BookingFormPage({
    super.key,
    required this.package,
    required this.event,
  });

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final formkey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final phoneEmailC = TextEditingController();
  final peopleAmountC = TextEditingController();
  final dateC = TextEditingController();
  DateTime? date;
  bool addTransport = false;
  bool addMeal = false;
  bool isCalcTotal = false;
  bool isSubmitting = false;

  double basePrice = 0,
      perPersonTotal = 0,
      mealTotal = 0,
      transportTotal = 0,
      subTotal = 0,
      discount = 0,
      total = 0;

  void calcTotal() {
    int peopleAmount = int.parse(peopleAmountC.text.trim());
    basePrice = widget.package.basePrice;
    perPersonTotal = widget.package.perPerson * peopleAmount;
    transportTotal = addTransport ? 60 : 0;
    mealTotal = addMeal ? (25.00 * peopleAmount) : 0;
    subTotal = basePrice + perPersonTotal + transportTotal + mealTotal;
    discount = peopleAmount >= 5 ? (subTotal * 0.1) : 0;
    total = subTotal - discount;
    isCalcTotal = true;
  }

  TableRow row(String label, double value) {
    return TableRow(
      children: [
        Text("$label:"),
        AnimatedPriceText(value: value),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final package = widget.package;
    final ts = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book: ${package.title}',
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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          CustomFormField(
                            tController: nameC,
                            hint: 'Full Name (as per ID)',
                            label: 'Name',
                            icon: Icons.person,
                            errMsg: 'Please enter your name',
                          ),
                          CustomFormField(
                            tController: phoneEmailC,
                            hint: '011-12345678',
                            label: 'Phone Number',
                            icon: Icons.phone,
                            errMsg: 'Please enter your phone number',
                            inputType: TextInputType.phone,
                          ),
                          CustomFormField(
                            tController: peopleAmountC,
                            hint: 'e.g. 3',
                            label: 'Number of Guests',
                            icon: Icons.people,
                            errMsg: 'Please enter the number of guests',
                            inputType: TextInputType.number,
                          ),
                          CustomFormField(
                            tController: dateC,
                            hint: 'Tap to select a date',
                            label: 'Preferred Date',
                            icon: Icons.calendar_month,
                            errMsg: 'Please pick a preferred date',
                            canFocus: false,
                            onTap: () async {
                              date = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2028),
                              );
                              if (date != null) {
                                setState(() {
                                  dateC.text = date.toString().split(' ')[0];
                                });
                              }
                            },
                          ),
                          SwitchListTile(
                            title: Text('Add transport (RM60 per booking)'),
                            value: addTransport,
                            onChanged: (value) {
                              setState(() {
                                addTransport = value;
                                isCalcTotal ? calcTotal() : null;
                              });
                            },
                          ),
                          SwitchListTile(
                            title: Text(
                              'Include Festival Meal (RM25 per person)',
                            ),
                            value: addMeal,
                            onChanged: (value) {
                              setState(() {
                                addMeal = value;
                                isCalcTotal ? calcTotal() : null;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: OutlinedButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  setState(() {
                                    calcTotal();
                                  });
                                } else {
                                  SnackbarHelper.show(
                                    context: context,
                                    message:
                                        'Please fill in all the necessary fields.',
                                    isError: true,
                                  );
                                }
                              },
                              child: Text('Calculate Price'),
                            ),
                          ),

                          isCalcTotal
                              ? Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Price Breakdown',
                                          style: ts.titleMedium,
                                        ),
                                        Table(
                                          columnWidths: const {
                                            0: FlexColumnWidth(),
                                            1: FixedColumnWidth(80),
                                          },
                                          children: [
                                            row('Base Price', basePrice),
                                            row('Per Person', perPersonTotal),
                                            row('Transport', transportTotal),
                                            row('Meals', mealTotal),
                                            row('Discount', discount),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                          ),
                                          child: Divider(
                                            thickness: 2,
                                            height: 2,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Total: ',
                                              style: ts.titleMedium?.copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).primaryColor,
                                                fontSize: 18,
                                              ),
                                            ),
                                            AnimatedPriceText(
                                              value: total,
                                              style: ts.titleMedium?.copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).primaryColor,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(),

                          ElevatedButton(
                            onPressed: isSubmitting
                                ? null
                                : () {
                                    if (formkey.currentState!.validate() &&
                                        isCalcTotal) {
                                      isSubmitting = true;
                                      final Booking booking = Booking(
                                        package: package,
                                        name: nameC.text.trim(),
                                        phoneEmail: phoneEmailC.text.trim(),
                                        peopleAmountC: int.parse(
                                          peopleAmountC.text.trim(),
                                        ),
                                        date: date!,
                                        addTransport: addTransport,
                                        addMeal: addMeal,
                                        basePrice: basePrice,
                                        perPersonTotal: perPersonTotal,
                                        transportTotal: transportTotal,
                                        mealTotal: mealTotal,
                                        subTotal: subTotal,
                                        discount: discount,
                                        total: total,
                                        event: widget.event,
                                      );
                                      SnackbarHelper.show(
                                        context: context,
                                        message: 'Booking Created Sucessfully',
                                      );
                                      Navigator.push(
                                        context,
                                        SlideFadeRoute(
                                          page: BookingConfirmPage(
                                            booking: booking,
                                          ),
                                        ),
                                      );
                                      isSubmitting = false;
                                    } else if (!formkey.currentState!
                                        .validate()) {
                                      SnackbarHelper.show(
                                        context: context,
                                        message:
                                            'Please fill in all the necessary fields.',
                                        isError: true,
                                      );
                                    } else {
                                      SnackbarHelper.show(
                                        context: context,
                                        message:
                                            'Please calculate the price first.',
                                        isError: true,
                                      );
                                    }
                                  },
                            child: Text('Confirm Booking'),
                          ),
                        ],
                      ),
                    ),
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
