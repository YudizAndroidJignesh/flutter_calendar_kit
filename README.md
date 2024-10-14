![](https://raw.githubusercontent.com/YudizAndroidJignesh/flutter_calendar_kit/main/screenshot/banner.png)

![GitHub code size](https://img.shields.io/github/languages/code-size/YudizAndroidJignesh/flutter_calendar_kit)
[![All Contributors](https://img.shields.io/github/all-contributors/YudizAndroidJignesh/flutter_calendar_kit)](#contributors-)
[![Pub](https://img.shields.io/pub/v/flutter_calendar_kit.svg)](https://pub.dartlang.org/packages/flutter_calendar_kit)

# Flutter Calendar Kit

A Flutter package that provides a highly customizable calendar widget for picking dates. This widget
supports various customization options including single and multi-date selection, blocked and booked date handling,
and flexible date validation.

## Description

`flutter_calendar_kit` is designed to simplify the process of integrating a customizable calendar
into your Flutter application. Whether you need a simple date picker or a complex booking system,
this package offers the flexibility to meet your needs.

<img src="https://raw.githubusercontent.com/YudizAndroidJignesh/flutter_calendar_kit/main/screenshot/example.gif" width="240"/>

## Sample Code

Here's a basic example demonstrating how to use the `flutter_calendar_kit` package:

```dart
CustomCalendar(
  onDatesSelected: (dates) {
    print('Selected dates: $dates');
  },
  initialBlockedDates: [DateTime(2023, 10, 15), DateTime(2023, 10, 16)],
  initialBookedDates: [DateTime(2023, 10, 20), DateTime(2023, 10, 21)],
  primaryColor: Colors.green,
  blockedColor: Colors.red.withOpacity(0.5),
  bookedColor: Colors.orange,
  allowBlockedSelection: true,
  showAdjacentMonths: true,
)
```

## Features

| Feature                  | Description                                                            |
|--------------------------|------------------------------------------------------------------------|
| Single/Multi-date Selection | Allow users to select one or multiple dates                         |
| Blocked Date Handling    | Highlight and optionally allow selection of blocked dates              |
| Booked Date Highlighting | Visually distinguish booked dates                                      |
| Dynamic Date Validation  | Implement custom logic for date selection (e.g., restrict past dates)  |
| Extensive Customization  | Customize colors, text styles, and more to match your app's design     |
| Adjacent Month Display   | Option to show or hide dates from adjacent months                      |

| <img src="https://raw.githubusercontent.com/yourusername/flutter_calendar_kit/main/screenshot/ss_single_select.png" width="240"/> | <img src="https://raw.githubusercontent.com/yourusername/flutter_calendar_kit/main/screenshot/ss_multi_select.png" width="240"/> | <img src="https://raw.githubusercontent.com/yourusername/flutter_calendar_kit/main/screenshot/ss_blocked_dates.png" width="240"/> |
|:--------------------------------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------------------------------------:|
|                                                     Single Date Selection                                                         |                                                     Multi-Date Selection                                                          |                                                     Blocked and Booked Dates                                                        |

## Properties

| Name                    | Type                      | Description                                                   |
|-------------------------|---------------------------|---------------------------------------------------------------|
| onDatesSelected         | ValueChanged<List<DateTime>> | Callback for when dates are selected                          |
| initialBlockedDates     | List<DateTime>            | List of initially blocked dates                               |
| initialBookedDates      | List<DateTime>            | List of initially booked dates                                |
| dateValidationCallback  | bool Function(DateTime)   | Custom logic for date validation                              |
| primaryColor            | Color                     | Main color used for selection and highlighting                |
| blockedColor            | Color                     | Color used for blocked dates                                  |
| bookedColor             | Color                     | Color used for booked dates                                   |
| allowBlockedSelection   | bool                      | Whether to allow selection of blocked dates                   |
| showAdjacentMonths      | bool                      | Whether to show dates from adjacent months                    |
| fontFamily              | String                    | Custom font family for the calendar text                      |
| weekdayTextStyle        | TextStyle                 | Custom text style for weekday headers                         |

## Getting Started

1. Add the dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_calendar_kit: ^0.1.0
```

2. Install the package:

```
flutter pub get
```

3. Import the package in your Dart code:

```dart
import 'package:flutter_calendar_kit/flutter_calendar_kit.dart';
```

4. Use the `CustomCalendar` widget in your app:

```dart
CustomCalendar(
  onDatesSelected: (dates) {
    // Handle selected dates
  },
  // Add other customization options as needed
)
```

## Contributions

Contributions of any kind are more than welcome! Feel free to fork and improve flutter_calendar_kit
in any way you want, make a pull request, or open an issue.

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

## Getting Involved

We appreciate your interest in getting involved! You're a superstar ⭐ and we ❤️ you!

### Reporting Bugs and Issues

Use the configured [Github issue report template](https://github.com/yourusername/flutter_calendar_kit/issues/new?assignees=&labels=&template=bug_report.md&title=) when reporting an issue. Please provide clear details about your observations and expectations to help us troubleshoot effectively.

### Discussions and Ideas

We're open to discussions and ideas. Post your questions on [StackOverflow](https://stackoverflow.com/questions/tagged/flutter_calendar_kit) with the tag `flutter_calendar_kit`.

---

## Visitors Count
<img align="left" src = "https://profile-counter.glitch.me/flutter_calendar_kit/count.svg" alt ="Loading">