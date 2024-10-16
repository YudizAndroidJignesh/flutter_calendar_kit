// File: lib/flutter_calendar_kit.dart

import 'package:flutter/material.dart';
typedef DateValidationCallback = bool Function(DateTime date);

class CustomCalendar extends StatefulWidget {
  final Function(List<DateTime>) onDatesSelected;
  final List<DateTime> initialBlockedDates;
  final List<DateTime> initialBookedDates;
  final DateTime? initialDate;
  final Color primaryColor;
  final Color blockedColor;
  final Color blockedTextColor;
  final Color bookedColor;
  final Color bookedTextColor;
  final Color pastDateColor;
  final Color pastDateTextColor;
  final Color currentMonthTextColor;
  final Color otherMonthTextColor;
  final Color selectedDateTextColor;
  final Color todayColor;
  final Color todayTextColor;
  final TextStyle? weekdayTextStyle;
  final String? fontFamily;
  final bool allowBlockedSelection;
  final bool showAdjacentMonths;


   DateValidationCallback? dateValidationCallback;
  final Color nonSelectableDateColor;
  final Color nonSelectableTextColor;


   CustomCalendar({
    Key? key,
    required this.onDatesSelected,
    this.initialBlockedDates = const [],
    this.initialBookedDates = const [],
    this.dateValidationCallback, // Now optional
    this.initialDate,
    this.primaryColor = Colors.blue,
    this.blockedColor = Colors.grey,
    this.blockedTextColor = Colors.white,
    this.bookedColor = Colors.orange,
    this.bookedTextColor = Colors.white,
    this.nonSelectableDateColor = const Color(0xFFE0E0E0),
    this.nonSelectableTextColor = Colors.grey,
    this.currentMonthTextColor = Colors.black,
    this.otherMonthTextColor = Colors.grey,
    this.selectedDateTextColor = Colors.white,
    this.todayColor = Colors.blue,
    this.todayTextColor = Colors.white,
    this.weekdayTextStyle,
    this.fontFamily,
    this.allowBlockedSelection = false,
    this.showAdjacentMonths = true, required this.pastDateColor, required this.pastDateTextColor,
  }) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime _currentMonth;
  List<DateTime> _selectedDates = [];
  DateTime? _dragStart;
  DateTime? _dragEnd;
  List<DateTime> _blockedDates = [];
  List<DateTime> _bookedDates = [];
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.initialDate ?? DateTime.now();
    _blockedDates = List.from(widget.initialBlockedDates);
    _bookedDates = List.from(widget.initialBookedDates);
  }

  void _changeMonth(int monthsToAdd) {
    setState(() {
      _currentMonth = DateTime(
        _currentMonth.year,
        _currentMonth.month + monthsToAdd,
        1,
      );
    });
  }

  void _handleTap(DateTime date) {
    final today = DateTime.now();
    if (date.isBefore(DateTime(today.year, today.month, today.day))) {
      return; // Do nothing for past dates
    }

    setState(() {
      if (_selectedDates.contains(date)) {
        _selectedDates.remove(date);
      } else {
        _selectedDates.add(date);
      }
    });
    widget.onDatesSelected(_selectedDates);
  }

  void _updateDragSelection(DateTime date) {
    final today = DateTime.now();
    if (date.isBefore(DateTime(today.year, today.month, today.day))) {
      return; // Do nothing for past dates
    }

    setState(() {
      if (_dragStart == null) {
        _dragStart = date;
        _dragEnd = null;
      } else {
        _dragEnd = date;
      }
    });
  }

  void _finalizeDragSelection() {
    if (_dragStart != null && _dragEnd != null) {
      DateTime start = _dragStart!;
      DateTime end = _dragEnd!;
      if (end.isBefore(start)) {
        final temp = start;
        start = end;
        end = temp;
      }

      List<DateTime> visibleDates = _getVisibleDates();
      List<DateTime> draggedDates = [];
      for (DateTime date = start;
      !date.isAfter(end);
      date = date.add(Duration(days: 1))) {
        if (visibleDates.contains(date)) {
          draggedDates.add(date);
        }
      }

      setState(() {
        bool allSelected = draggedDates.every((date) => _selectedDates.contains(date));
        if (allSelected) {
          // If all dragged dates are already selected, deselect them
          _selectedDates.removeWhere((date) => draggedDates.contains(date));
        } else {
          // Select all dragged dates
          _selectedDates.addAll(draggedDates);
        }
      });

      widget.onDatesSelected(_selectedDates);
    }
    setState(() {
      _dragStart = null;
      _dragEnd = null;
    });
  }

  bool _isDateBlocked(DateTime date) {
    return _blockedDates.any((blockedDate) =>
    blockedDate.year == date.year &&
        blockedDate.month == date.month &&
        blockedDate.day == date.day);
  }

  bool _isDateBooked(DateTime date) {
    return _bookedDates.any((bookedDate) =>
    bookedDate.year == date.year &&
        bookedDate.month == date.month &&
        bookedDate.day == date.day);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          _buildHeader(),
          _buildWeekdayHeaders(),
          _buildCalendarGrid(),
        ],
      ),
    );
  }


  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left, color: widget.primaryColor),
            onPressed: () => _changeMonth(-1),
          ),
          Column(
            children: [
              Text(
                '${_getMonthName(_currentMonth.month)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: widget.fontFamily,
                  color: widget.currentMonthTextColor,
                ),
              ),
              Text(
                '${_currentMonth.year}',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: widget.fontFamily,
                  color: widget.currentMonthTextColor,
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.chevron_right, color: widget.primaryColor),
            onPressed: () => _changeMonth(1),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeaders() {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weekdays
            .map((day) => Text(
          day,
          style: widget.weekdayTextStyle ??
              TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontFamily: widget.fontFamily,
              ),
        ))
            .toList(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final visibleDates = _getVisibleDates();

    return GestureDetector(
      onPanStart: (details) {
        final date = _getDateFromPosition(details.localPosition, visibleDates);
        if (date != null) {
          setState(() {
            _isDragging = true;
            _updateDragSelection(date);
          });
        }
      },
      onPanUpdate: (details) {
        if (_isDragging) {
          final date = _getDateFromPosition(details.localPosition, visibleDates);
          if (date != null) {
            _updateDragSelection(date);
          }
        }
      },
      onPanEnd: (_) {
        if (_isDragging) {
          _finalizeDragSelection();
        }
        setState(() {
          _isDragging = false;
        });
      },
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1,
        ),
        itemCount: visibleDates.length,
        itemBuilder: (context, index) {
          final date = visibleDates[index];
          return _buildDateCell(date, date.day, _currentMonth.month);
        },
      ),
    );
  }

  Widget _buildDateCell(DateTime date, int day, int currentMonth) {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    bool isCurrentMonth = date.month == currentMonth;
    bool isSelected = _selectedDates.contains(date);
    bool isDragging = _isDragging && _isDateInDragRange(date);
    bool isBlocked = _isDateBlocked(date);
    bool isBooked = _isDateBooked(date);
    bool isPastDate = date.isBefore(todayStart);
    bool isToday = date.isAtSameMomentAs(todayStart);

    if (!widget.showAdjacentMonths && !isCurrentMonth) {
      return Container();
    }

    return GestureDetector(
      onTap: isPastDate ? null : () => _handleTap(date),
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: _getCellColor(isCurrentMonth, isSelected, isDragging, isBlocked, isBooked, isPastDate, isToday),
          borderRadius: BorderRadius.circular(10),
          border: isToday ? Border.all(color: widget.todayColor, width: 2) : null,
        ),
        child: Center(
          child: Text(
            day.toString(),
            style: TextStyle(
              fontSize: 15,
              color: _getDateColor(isCurrentMonth, isSelected, isDragging, isBlocked, isBooked, isPastDate, isToday),
              fontFamily: widget.fontFamily,
            ),
          ),
        ),
      ),
    );
  }

  bool _isDateInDragRange(DateTime date) {
    if (_dragStart == null || _dragEnd == null) return false;
    DateTime start = _dragStart!;
    DateTime end = _dragEnd!;
    if (end.isBefore(start)) {
      final temp = start;
      start = end;
      end = temp;
    }
    return date.isAtSameMomentAs(start) ||
        date.isAtSameMomentAs(end) ||
        (date.isAfter(start) && date.isBefore(end));
  }

  Color _getCellColor(bool isCurrentMonth, bool isSelected, bool isDragging, bool isBlocked, bool isBooked, bool isPastDate, bool isToday) {
    if (isPastDate) return widget.pastDateColor;
    if (isBlocked) {
      return isSelected && widget.allowBlockedSelection ? widget.primaryColor : widget.blockedColor;
    }
    if (isDragging) return widget.primaryColor.withOpacity(0.1);
    if (isSelected) return isBooked ? widget.bookedColor.withOpacity(0.3) : widget.primaryColor;
    if (isToday) return widget.todayColor;
    return Colors.transparent;
  }

  Color _getDateColor(bool isCurrentMonth, bool isSelected, bool isDragging, bool isBlocked, bool isBooked, bool isPastDate, bool isToday) {
    if (isPastDate) return widget.pastDateTextColor;
    if (isBlocked) return widget.blockedTextColor;
    if (!isCurrentMonth) return widget.otherMonthTextColor;
    if (isBooked) return widget.bookedTextColor;
    if (isDragging) return widget.currentMonthTextColor;
    if (isSelected) return widget.selectedDateTextColor;
    if (isToday) return widget.todayTextColor;
    return widget.currentMonthTextColor;
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }

  List<DateTime> _getVisibleDates() {
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final firstVisibleDay = firstDayOfMonth.subtract(Duration(days: (firstDayOfMonth.weekday - 1) % 7));
    final numberOfWeeks = _getNumberOfWeeksInMonth(_currentMonth);

    List<DateTime> visibleDates = [];
    for (int i = 0; i < numberOfWeeks * 7; i++) {
      visibleDates.add(firstVisibleDay.add(Duration(days: i)));
    }

    return visibleDates;
  }

  int _getNumberOfWeeksInMonth(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    final daysFromFirstMonday = lastDayOfMonth.day + (firstDayOfMonth.weekday - 1) % 7;
    return (daysFromFirstMonday / 7).ceil();
  }

  DateTime? _getDateFromPosition(Offset position, List<DateTime> visibleDates) {
    final cellWidth = context.size!.width / 7;
    final cellHeight = cellWidth;
    final row = (position.dy / cellHeight).floor();
    final col = (position.dx / cellWidth).floor();
    final index = row * 7 + col;

    if (index >= 0 && index < visibleDates.length) {
      return visibleDates[index];
    }
    return null;
  }
}