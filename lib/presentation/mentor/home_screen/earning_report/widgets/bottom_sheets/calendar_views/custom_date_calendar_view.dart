import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/res/constants/constants.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

class CustomDateCalendarView extends StatefulWidget {
  const CustomDateCalendarView({super.key});

  @override
  State<CustomDateCalendarView> createState() => _CustomDateCalendarViewState();
}

class _CustomDateCalendarViewState extends State<CustomDateCalendarView> {
  DateTime _currentMonth = DateTime.now();
  DateTime? rangeStart;
  DateTime? rangeEnd;

  // Generate full month grid with leading/trailing days
  List<DateTime> _generateMonthDays(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);

    // Start on previous Sunday
    final startDay = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday % 7));
    final endDay = lastDayOfMonth.add(Duration(days: 6 - lastDayOfMonth.weekday % 7));

    return List.generate(
      endDay.difference(startDay).inDays + 1,
          (index) => startDay.add(Duration(days: index)),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _onDateTap(DateTime date) {
    setState(() {
      if (rangeStart == null || (rangeStart != null && rangeEnd != null)) {
        rangeStart = date;
        rangeEnd = null;
      } else {
        if (date.isBefore(rangeStart!)) {
          rangeEnd = rangeStart;
          rangeStart = date;
        } else {
          rangeEnd = date;
        }
      }
    });
  }

  void _goToPreviousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final days = _generateMonthDays(_currentMonth);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFECFBF3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: AppConstantsSpacing.paddingMedium),
                      decoration: BoxDecoration(
                        color: const Color(0xffCEDBF1),
                        borderRadius: BorderRadius.circular(21),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        DateFormat.yMMMM().format(_currentMonth),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'BeVietnamPro',
                          color: AppColors.textblue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppConstantsSpacing.spacingSmall),
                  Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xffCEDBF1),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _goToPreviousMonth,
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: UIHelper.customSvg(svg: "left-svg.svg", height: 18, width: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _goToNextMonth,
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: UIHelper.customSvg(svg: "right-svg.svg", height: 18, width: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              /// Weekday labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (i) {
                  final label = DateFormat.E().format(DateTime(2020, 1, i + 6));
                  return Expanded(
                    child: Center(
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'BeVietnamPro',
                          color: Color(0xff92b5db),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 8),

              /// Calendar Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: days.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (_, index) {
                  final day = days[index];
                  final isToday = _isSameDay(day, today);
                  final isInMonth = day.month == _currentMonth.month;
                  final isStart = rangeStart != null && _isSameDay(day, rangeStart!);
                  final isEnd = rangeEnd != null && _isSameDay(day, rangeEnd!);
                  final isInRange = rangeStart != null &&
                      rangeEnd != null &&
                      day.isAfter(rangeStart!) &&
                      day.isBefore(rangeEnd!);

                  Color bgColor = const Color(0xffdaedee);
                  Color textColor = isInMonth ? Colors.black87 : Colors.grey;
                  FontWeight fontWeight = FontWeight.w500;

                  if (isToday) {
                    bgColor = AppColors.primary1;
                    textColor = Colors.white;
                    fontWeight = FontWeight.bold;
                  }

                  if (isStart || isEnd) {
                    bgColor = const Color(0xFF03002F);
                    textColor = Colors.white;
                    fontWeight = FontWeight.bold;
                  } else if (isInRange) {
                    bgColor = const Color(0xFFB0C4DE); // light blue range
                    textColor = Colors.black;
                  }

                  return GestureDetector(
                    onTap: () => _onDateTap(day),
                    child: Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: fontWeight,
                          fontSize: 14,
                          fontFamily: 'BeVietnamPro',
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
