import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/res/constants/constants.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

class MonthlyCalendarView extends StatefulWidget {
  const MonthlyCalendarView({super.key});

  @override
  State<MonthlyCalendarView> createState() => _MonthlyCalendarViewState();
}

class _MonthlyCalendarViewState extends State<MonthlyCalendarView> {
  DateTime currentMonth = DateTime.now();
  DateTime? rangeStart;
  DateTime? rangeEnd;

  List<DateTime> _generateDaysForMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    final start = firstDay.subtract(Duration(days: firstDay.weekday - 1));
    final end = lastDay.add(Duration(days: 7 - lastDay.weekday));

    return List.generate(
      end.difference(start).inDays + 1,
          (i) => start.add(Duration(days: i)),
    );
  }

  bool _isInRange(DateTime day) {
    if (rangeStart == null || rangeEnd == null) return false;
    return !day.isBefore(rangeStart!) && !day.isAfter(rangeEnd!);
  }

  bool _isStart(DateTime day) => rangeStart != null && DateUtils.isSameDay(day, rangeStart!);
  bool _isEnd(DateTime day) => rangeEnd != null && DateUtils.isSameDay(day, rangeEnd!);

  void _onDateTap(DateTime date) {
    setState(() {
      if (rangeStart == null || (rangeStart != null && rangeEnd != null)) {
        rangeStart = date;
        rangeEnd = null;
      } else {
        if (date.isBefore(rangeStart!)) {
          rangeStart = date;
          rangeEnd = null;
        } else {
          final diff = date.difference(rangeStart!).inDays + 1;
          if (diff <= 30) {
            rangeEnd = date;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You can only select up to 30 days.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final days = _generateDaysForMonth(currentMonth);
    final String monthLabel = DateFormat.yMMMM().format(currentMonth);
    final today = DateTime.now();

    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: constraints.maxHeight),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
              //  color: const Color(0xFFFFF5E1),
                color: const Color(0xFFecfbf3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// 🔼 Month Header
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// 🟦 Month-Year Label (Left Side)
                      Expanded(
                        child: Container(
                          height: 36,
                          padding: EdgeInsets.symmetric(
                            horizontal: AppConstants.paddingMedium,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffCEDBF1),
                            borderRadius: BorderRadius.circular(21),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            monthLabel,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textblue,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: AppConstants.spacingSmall),

                      /// ⬅️➡️ Arrows Container
                      Container(
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xffCEDBF1),
                          borderRadius: BorderRadius.circular(21),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// ⬅️ Previous Month
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
                                  rangeStart = null;
                                  rangeEnd = null;
                                });
                              },
                              child: Container(
                                height: 32,
                                width: 32,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: UIHelper.customSvg(svg: "left-svg.svg"),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            /// ➡️ Next Month
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
                                  rangeStart = null;
                                  rangeEnd = null;
                                });
                              },
                              child: Container(
                                height: 32,
                                width: 32,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: UIHelper.customSvg(svg: "right-svg.svg"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// 📅 Weekday Labels
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (index) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            DateFormat.E().format(DateTime(2020, 1, index + 6)), // Mon-Sun
                            style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xff92b5db)),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 10),

                  /// 📆 Calendar Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: days.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                    ),
                    itemBuilder: (_, index) {
                      final day = days[index];
                      final bool isCurrentMonth = day.month == currentMonth.month;
                      final bool isToday = DateUtils.isSameDay(day, today);
                      final bool isSelected = _isInRange(day);
                      final bool isStart = _isStart(day);
                      final bool isEnd = _isEnd(day);

                     // Color bgColor = Color(0xffdaedee);
                      Color bgColor = Color(0xffdaedee);
                      Color textColor = Colors.black87;
                      BorderRadius borderRadius = BorderRadius.circular(12);

                      if (isStart && isEnd) {
                        bgColor = const Color(0xFF03002F);
                        textColor = Colors.white;
                      } else if (isStart) {
                        bgColor = const Color(0xFF03002F);
                        textColor = Colors.white;
                        borderRadius = const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        );
                      } else if (isEnd) {
                        bgColor = const Color(0xFF03002F);
                        textColor = Colors.white;
                        borderRadius = const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        );
                      } else if (isSelected) {
                        bgColor = const Color(0xFFADCAE2);
                        textColor = Colors.black;
                      } else if (isToday) {
                        bgColor = AppColors.primary1;
                        textColor = Colors.white;
                      } else if (!isCurrentMonth) {
                        textColor = Colors.grey;
                      }

                      return GestureDetector(
                        onTap: isCurrentMonth ? () => _onDateTap(day) : null,
                        child: Container(
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: borderRadius,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${day.day}',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 10),

                  // if (rangeStart != null && rangeEnd != null)
                  //   Text(
                  //     "Selected: ${DateFormat.yMMMd().format(rangeStart!)} → ${DateFormat.yMMMd().format(rangeEnd!)}",
                  //     style: const TextStyle(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
