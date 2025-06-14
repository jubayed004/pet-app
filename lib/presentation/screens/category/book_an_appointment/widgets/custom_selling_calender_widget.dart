import 'package:flutter/material.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CustomCalendar extends StatefulWidget {
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Example mock data for colored dates
  final List<DateTime> greenDates = [
    DateTime(2025, 5, 3),
    DateTime(2025, 5, 10),
    DateTime(2025, 5, 13),
    DateTime(2025, 5, 20),
  ];

  final List<DateTime> orangeDates = [
    DateTime(2025, 5, 1),
    DateTime(2025, 5, 7),
    DateTime(2025, 5, 18),
    DateTime(2025, 5, 24),
    DateTime(2025, 5, 27),
    DateTime(2025, 5, 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding8,
      // margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        currentDay: _selectedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextFormatter: (date, locale) => DateFormat.yMMMM(locale).format(date),
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          leftChevronIcon: const Icon(Icons.chevron_left),
          rightChevronIcon: const Icon(Icons.chevron_right),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          isTodayHighlighted: false,
          cellMargin: const EdgeInsets.all(6),
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            return _buildDayCell(day);
          },
          todayBuilder: (context, day, focusedDay) {
            return _buildDayCell(day);
          },
          selectedBuilder: (context, day, focusedDay) {
            return _buildDayCell(day, isSelected: true);
          },
        ),
      ),
    );
  }

  Widget _buildDayCell(DateTime day, {bool isSelected = false}) {
    final isGreen = greenDates.any((d) => isSameDay(d, day));
    final isOrange = orangeDates.any((d) => isSameDay(d, day));

    Color? bgColor;
    if (isGreen) {
      bgColor = AppColors.kGreenColor;
    } else if (isOrange) {
      bgColor = AppColors.kPrimaryColor;
    }

    return Container(
      margin: padding4,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          color: isSelected ? Colors.black : Colors.transparent,
          width: 1.2,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: (isGreen || isOrange) ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
