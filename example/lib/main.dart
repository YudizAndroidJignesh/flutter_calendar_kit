import 'package:flutter/material.dart';
import 'package:flutter_custom_calendar/flutter_calendar_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Custom Calendar Example')),
        body: CustomCalendar(
          initialBlockedDates: [ DateTime(2024, 10, 16), DateTime(2024, 10, 17),DateTime(2024, 10, 17)],
          initialBookedDates: [DateTime(2024, 10, 20), DateTime(2024, 10, 21),DateTime(2024, 10, 22)],
          onDatesSelected: (dates) {

          },
          bookedColor: Colors.orange,
          primaryColor: Colors.green,
          blockedColor: Colors.red.withOpacity(0.5),
          blockedTextColor: Colors.black,
          bookedTextColor: Colors.white,
          pastDateColor: Colors.grey[200]!,
          pastDateTextColor: Colors.grey,
          currentMonthTextColor: Colors.black,
          otherMonthTextColor: Colors.red,
          selectedDateTextColor: Colors.white,
          todayColor: Colors.blue.withOpacity(0.3),
          todayTextColor: Colors.blue,
          fontFamily: 'Roboto',
          allowBlockedSelection: false,
          showAdjacentMonths: false,
          weekdayTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),

        ),
      ),
    );
  }
}