import 'package:flutter/material.dart';
import 'package:s01_day3_am_project/booking_confirm_page.dart';
import 'package:s01_day3_am_project/module/booking.dart';
import 'package:s01_day3_am_project/module/event.dart';

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
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameC,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Enter Your Name',
                              labelText: 'Your Name',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: phoneEmailC,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              hintText: 'Enter Your Phone Number',
                              labelText: 'Phone or Email',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: peopleAmountC,
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.people),
                              hintText: 'Enter the Amount of People',
                              labelText: 'Number of People',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the amounr of people';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: dateC,
                            canRequestFocus: false,
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
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.calendar_month),
                              hintText: 'Pick a Date',
                              labelText: 'Preferred Date',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please pick a date';
                              }
                              return null;
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
                            child: ElevatedButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  setState(() {
                                    calcTotal();
                                  });
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
                                        Text(
                                          'Base Price : RM ${basePrice.toStringAsFixed(2)}',
                                          style: ts.titleSmall,
                                        ),
                                        Text(
                                          'Per Person Total : RM ${perPersonTotal.toStringAsFixed(2)}',
                                          style: ts.titleSmall,
                                        ),
                                        Text(
                                          'Transport : RM ${transportTotal.toStringAsFixed(2)}',
                                          style: ts.titleSmall,
                                        ),
                                        Text(
                                          'Meals : RM ${mealTotal.toStringAsFixed(2)}',
                                          style: ts.titleSmall,
                                        ),
                                        Text(
                                          'Discount : RM ${discount.toStringAsFixed(2)}',
                                          style: ts.titleSmall,
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
                                        Text(
                                          'Total: RM${total.toStringAsFixed(2)}',
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BookingConfirmPage(
                                                booking: booking,
                                              ),
                                        ),
                                      );
                                      isSubmitting = false;
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
