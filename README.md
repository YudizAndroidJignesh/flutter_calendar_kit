# Flutter Calendar Kit

Flutter Calendar Kit is a highly customizable and flexible calendar widget for Flutter applications. It offers a range of features including single and multi-date selection, blocked and booked date handling, flexible date validation, and extensive visual customization options.

## Features

- 📅 Single and multi-date selection
- 🚫 Blocked date highlighting and optional selection
- 🏨 Booked date highlighting
- ✅ Dynamic date validation (e.g., restrict past dates, future dates, or specific days of the week)
- 🎨 Extensive color customization for various calendar elements
- 🖌️ Customizable text styles for weekday headers and date cells
- 📊 Option to show or hide adjacent month dates
- 🔤 Support for custom font families

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_calendar_kit: ^0.1.0
```

Then run:

```
$ flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_calendar_kit/flutter_calendar_kit.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Calendar Kit Example')),
      body: CustomCalendar(
        onDatesSelected: (dates) {
          print('Selected dates: $dates');
        },
      ),
    );
  }
}
```

### Advanced Usage

```dart
CustomCalendar(
  onDatesSelected: (dates) {
    print('Selected dates: $dates');
  },
  initialBlockedDates: [DateTime(2023, 10, 15), DateTime(2023, 10, 16)],
  initialBookedDates: [DateTime(2023, 10, 20), DateTime(2023, 10, 21)],
  dateValidationCallback: (date) {
    final now = DateTime.now();
    final thirtyDaysFromNow = now.add(Duration(days: 30));
    return date.isAfter(now.subtract(Duration(days: 1))) &&
           date.isBefore(thirtyDaysFromNow) &&
           date.weekday != DateTime.saturday &&
           date.weekday != DateTime.sunday;
  },
  primaryColor: Colors.green,
  blockedColor: Colors.red.withOpacity(0.5),
  bookedColor: Colors.orange,
  allowBlockedSelection: true,
  showAdjacentMonths: true,
)
```

## Customization

Flutter Calendar Kit offers extensive customization options:

- `primaryColor`: The main color used for selection and highlighting.
- `blockedColor`: Color used for blocked dates.
- `bookedColor`: Color used for booked dates.
- `nonSelectableDateColor`: Color for dates that are not selectable.
- `currentMonthTextColor`: Text color for dates in the current month.
- `otherMonthTextColor`: Text color for dates from adjacent months.
- `selectedDateTextColor`: Text color for selected dates.
- `todayColor`: Color used to highlight today's date.
- `fontFamily`: Custom font family for the calendar text.
- `weekdayTextStyle`: Custom text style for weekday headers.

## Contributing

Contributions are welcome! If you find a bug or want a feature, please open an issue. If you want to contribute code, please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.