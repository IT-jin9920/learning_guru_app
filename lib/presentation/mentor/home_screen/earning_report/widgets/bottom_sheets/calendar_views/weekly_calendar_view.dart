// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class WeeklyCalendarView extends StatefulWidget {
//   const WeeklyCalendarView({super.key});
//
//   @override
//   State<WeeklyCalendarView> createState() => _WeeklyCalendarViewState();
// }
//
// class _WeeklyCalendarViewState extends State<WeeklyCalendarView> {
//   DateTime selectedDate = DateTime.now();
//
//   /// Get start of the week (Monday)
//   DateTime get startOfWeek {
//     return selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
//   }
//
//   /// Get end of the week (Sunday)
//   DateTime get endOfWeek {
//     return selectedDate.add(Duration(days: 7 - selectedDate.weekday));
//   }
//
//   /// Move to previous week
//   void _goToPreviousWeek() {
//     setState(() {
//       selectedDate = selectedDate.subtract(const Duration(days: 7));
//     });
//   }
//
//   /// Move to next week
//   void _goToNextWeek() {
//     setState(() {
//       selectedDate = selectedDate.add(const Duration(days: 7));
//     });
//   }
//
//   /// Build each day cell in the week
//   List<Widget> _buildWeekDays() {
//     List<Widget> days = [];
//     DateTime current = startOfWeek;
//
//     for (int i = 0; i < 7; i++) {
//       bool isToday = DateTime.now().day == current.day &&
//           DateTime.now().month == current.month &&
//           DateTime.now().year == current.year;
//
//       days.add(
//         Expanded(
//           child: Column(
//             children: [
//               Text(
//                 DateFormat.E().format(current), // e.g., Mon
//                 style: const TextStyle(fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 4),
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: isToday ? Colors.blue : Colors.transparent,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Text(
//                   current.day.toString(),
//                   style: TextStyle(
//                     color: isToday ? Colors.white : Colors.black,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//       current = current.add(const Duration(days: 1));
//     }
//
//     return days;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String currentMonth = DateFormat.yMMMM().format(selectedDate); // e.g., July 2025
//     String weekRange =
//         "${DateFormat.d().format(startOfWeek)} - ${DateFormat.d().format(endOfWeek)} ${DateFormat.MMMM().format(endOfWeek)}";
//
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFEAF9F2),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header: Month and arrows
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 currentMonth,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back_ios, size: 18),
//                     onPressed: _goToPreviousWeek,
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.arrow_forward_ios, size: 18),
//                     onPressed: _goToNextWeek,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 8),
//
//           // Week range
//           Text(
//             "Selected Week: $weekRange",
//             style: const TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: 14,
//               color: Colors.black54,
//             ),
//           ),
//
//           const SizedBox(height: 12),
//
//           // Weekdays row
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: _buildWeekDays(),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/res/constants/constants.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

class WeeklyCalendarView extends StatefulWidget {
  const WeeklyCalendarView({super.key});

  @override
  State<WeeklyCalendarView> createState() => _WeeklyCalendarViewState();
}

class _WeeklyCalendarViewState extends State<WeeklyCalendarView> {
  DateTime _currentMonth = DateTime.now();
  DateTime? _startDate;
  DateTime? _endDate;

  List<DateTime> _getMonthDays(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final offset = firstDay.weekday % 7;
    final start = firstDay.subtract(Duration(days: offset));
    final end = DateTime(month.year, month.month + 1, 0);
    final total = end.difference(start).inDays + 1;
    return List.generate(((total / 7).ceil()) * 7, (i) => start.add(Duration(days: i)));
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

  void _onDateTap(DateTime date) {
    setState(() {
      if (_startDate == null || (_startDate != null && _endDate != null)) {
        _startDate = date;
        _endDate = null;
      } else if (_startDate != null && _endDate == null) {
        if (date.isBefore(_startDate!)) {
          _endDate = _startDate;
          _startDate = date;
        } else {
          final difference = date.difference(_startDate!).inDays + 1;
          if (difference <= 7) {
            _endDate = date;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Maximum 7 days allowed')),
            );
          }
        }
      }
    });
  }

  bool _isInSelectedRange(DateTime day) {
    if (_startDate != null && _endDate != null) {
      return !day.isBefore(_startDate!) && !day.isAfter(_endDate!);
    }
    return _startDate != null && DateUtils.isSameDay(day, _startDate!);
  }

  @override
  Widget build(BuildContext context) {
    final days = _getMonthDays(_currentMonth);
    final today = DateTime.now();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFecfbf3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       DateFormat.yMMMM().format(_currentMonth),
              //       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //     ),
              //     Row(
              //       children: [
              //         IconButton(
              //           icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              //           onPressed: _goToPreviousMonth,
              //         ),
              //         IconButton(
              //           icon: const Icon(Icons.arrow_forward_ios, size: 18),
              //           onPressed: _goToNextMonth,
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
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
                        DateFormat.yMMMM().format(_currentMonth),
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
                          onTap: _goToPreviousMonth,
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
                          onTap: _goToNextMonth,
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

              const SizedBox(height: 12),

              /// Weekdays
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (i) {
                  final label = DateFormat.E().format(DateTime(2020, 1, i + 6));
                  return Expanded(
                    child: Center(
                      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xff92b5db))),
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
                itemBuilder: (_, i) {
                  final day = days[i];
                  final isToday = DateUtils.isSameDay(day, today);
                  final isInMonth = day.month == _currentMonth.month;

                  final isStart = _startDate != null && DateUtils.isSameDay(day, _startDate!);
                  final isEnd = _endDate != null && DateUtils.isSameDay(day, _endDate!);
                  final isInRange = _startDate != null &&
                      _endDate != null &&
                      day.isAfter(_startDate!) &&
                      day.isBefore(_endDate!);

                  // Color logic
                  //Color bgColor = AppColors.white; // Default faded background
                  Color bgColor = Color(0xffdaedee); // Default faded background
                  Color textColor = Colors.black;
                  BorderRadius borderRadius = BorderRadius.circular(12);

                  if (isStart && isEnd) {
                    bgColor = const Color(0xFF03002F); // Single-day selection
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
                  } else if (isInRange) {
                    bgColor = const Color(0xFFADCAE2);
                    textColor = Colors.black;
                  } else if (isToday) {
                    bgColor =AppColors.primary1;
                    textColor = Colors.white;
                  } else if (!isInMonth) {
                    bgColor = Colors.grey.shade200;
                    textColor = Colors.grey;
                  }

                  return GestureDetector(
                    onTap: isInMonth ? () {
                      final isValidStart = _startDate == null || (_startDate != null && _endDate != null);
                      final isValidEnd = _startDate != null && _endDate == null;

                      setState(() {
                        if (isValidStart) {
                          _startDate = day;
                          _endDate = null;
                        } else if (isValidEnd) {
                          int dayDiff = day.difference(_startDate!).inDays.abs() + 1;
                          if (dayDiff <= 7) {
                            if (day.isBefore(_startDate!)) {
                              _endDate = _startDate;
                              _startDate = day;
                            } else {
                              _endDate = day;
                            }
                          }
                        }
                      });
                    } : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: borderRadius,
                        // border: isToday && !isStart && !isEnd
                        //     ? Border.all(color: Colors.blue, width: 2)
                        //     : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },

              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // if (_startDate != null) ...[
        //   const SizedBox(height: 10),
        //   Text(
        //     _endDate == null
        //         ? 'Selected: ${DateFormat('d MMM yyyy').format(_startDate!)}'
        //         : 'Selected: ${DateFormat('d MMM').format(_startDate!)} - ${DateFormat('d MMM yyyy').format(_endDate!)}',
        //     style: const TextStyle(fontWeight: FontWeight.w600),
        //   ),
        // ],

        /// Show Report Button
        // SizedBox(
        //   width: double.infinity,
        //   child: ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: const Color(0xFF03002F),
        //       padding: const EdgeInsets.symmetric(vertical: 16),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(32),
        //       ),
        //     ),
        //     onPressed: () {
        //       if (_startDate != null) {
        //         final df = DateFormat('yyyy-MM-dd');
        //         final start = df.format(_startDate!);
        //         final end = _endDate != null ? df.format(_endDate!) : start;
        //         debugPrint("🗓️ Selected range: $start → $end");
        //       } else {
        //         debugPrint("⚠️ No dates selected.");
        //       }
        //       Navigator.pop(context);
        //     },
        //     child: const Text(
        //       'Show Report',
        //       style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         fontSize: 14,
        //         fontFamily: 'BeVietnamPro',
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),

      ],
    );
  }
}
