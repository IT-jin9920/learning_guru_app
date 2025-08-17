import 'package:flutter/material.dart';
import 'weekly_calendar_view.dart';
import 'monthly_calendar_view.dart';
import 'yearly_calendar_view.dart';
import 'custom_date_calendar_view.dart';

class CalendarViewFactory {
  static Widget getCalendarView(String preference) {
    switch (preference) {
      case 'Weekly':
        return const WeeklyCalendarView();
      case 'Monthly':
        return const MonthlyCalendarView();
      case 'Yearly':
        return const YearlyCalendarView();
      case 'Custom Date':
        return const CustomDateCalendarView();
      default:
        return const WeeklyCalendarView();
    }
  }
}
