// // custom_date_bottom_sheet.dart
// import 'package:flutter/material.dart';
//
// import '../presentation/home_screen/earning_report/widgets/bottom_sheets/preference_selector/preference_selector_bottom_sheet.dart';
//
//
//
// class CustomDateBottomSheet extends StatefulWidget {
//   const CustomDateBottomSheet({super.key});
//
//   @override
//   State<CustomDateBottomSheet> createState() => _CustomDateBottomSheetState();
//
//   static Widget _weekDay(String label) => Text(
//     label,
//     style: TextStyle(
//       fontSize: 12,
//       color: Colors.blueGrey.shade400,
//       fontWeight: FontWeight.w600,
//     ),
//   );
//
//   static Widget _calendarRow(List<int> days,
//       {List<int>? highlighted, int? selected}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: days.map((day) {
//         final isHighlighted = highlighted?.contains(day) ?? false;
//         final isSelected = selected == day;
//         final isNormalRange = day >= 1 && day <= 28;
//
//         Color bgColor = Colors.transparent;
//
//         if (isSelected) {
//           bgColor = const Color(0xFF2962FF);
//         } else if (isHighlighted) {
//           bgColor = const Color(0xFF03002F);
//         } else if (isNormalRange) {
//           bgColor = const Color(0xFFDAEDEE);
//         }
//
//         return Container(
//           margin: const EdgeInsets.all(4),
//           width: 32,
//           height: 32,
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Center(
//             child: Text(
//               '$day',
//               style: TextStyle(
//                 color: isSelected || isHighlighted
//                     ? Colors.white
//                     : Colors.black87,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 13,
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   static Widget _roundArrow(IconData icon, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(4),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//         ),
//         child: Icon(icon, size: 12),
//       ),
//     );
//   }
// }
//
// class _CustomDateBottomSheetState extends State<CustomDateBottomSheet> {
//   String selectedPreference = 'Weekly';
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 480,
//       padding: const EdgeInsets.all(20),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: const [
//               CircleAvatar(
//                 backgroundColor: Color(0xFF03002F),
//                 radius: 16,
//                 child: Icon(Icons.calendar_month, color: Colors.white, size: 16),
//               ),
//               SizedBox(width: 10),
//               Text(
//                 'Date Selection',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xFF03002F),
//                   fontFamily: 'BeVietnamPro',
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//
//           /// Dynamic Dropdown
//           GestureDetector(
//             onTap: () async {
//               await showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 backgroundColor: Colors.transparent,
//                 builder: (_) => PreferenceSelectorBottomSheet(
//                   selectedOption: selectedPreference,
//                   onSelect: (value) {
//                     setState(() {
//                       selectedPreference = value;
//                     });
//                   },
//                 ),
//               );
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFEFF7F1),
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     selectedPreference,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'BeVietnamPro',
//                     ),
//                   ),
//                   const Icon(Icons.keyboard_arrow_down_rounded),
//                 ],
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 20),
//
//           /// Calendar Header
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: const Color(0xFFEFF7F1),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const SizedBox(width: 24),
//                     const Text(
//                       'July 2024',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'BeVietnamPro',
//                         fontSize: 14,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         CustomDateBottomSheet._roundArrow(Icons.arrow_back_ios_new, () {}),
//                         const SizedBox(width: 5),
//                         CustomDateBottomSheet._roundArrow(Icons.arrow_forward_ios, () {}),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CustomDateBottomSheet._weekDay('MON'),
//                     CustomDateBottomSheet._weekDay('TUE'),
//                     CustomDateBottomSheet._weekDay('WED'),
//                     CustomDateBottomSheet._weekDay('THU'),
//                     CustomDateBottomSheet._weekDay('FRI'),
//                     CustomDateBottomSheet._weekDay('SAT'),
//                     CustomDateBottomSheet._weekDay('SUN'),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 CustomDateBottomSheet._calendarRow([1, 2, 3, 4, 5, 6, 7]),
//                 CustomDateBottomSheet._calendarRow([8, 9, 10, 11, 12, 13, 14]),
//                 CustomDateBottomSheet._calendarRow(
//                   [15, 16, 17, 18, 19, 20, 21],
//                   highlighted: [16, 17, 18, 19, 20, 21],
//                 ),
//                 CustomDateBottomSheet._calendarRow(
//                   [22, 23, 24, 25, 26, 27, 28],
//                   selected: 22,
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF03002F),
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(32),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text(
//                 'Show Report',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'BeVietnamPro',
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';
import '../presentation/mentor/home_screen/earning_report/widgets/bottom_sheets/calendar_views/calendar_view_factory.dart';
import '../presentation/mentor/home_screen/earning_report/widgets/bottom_sheets/preference_selector/preference_selector_bottom_sheet.dart';

class CustomDateBottomSheet extends StatefulWidget {
  const CustomDateBottomSheet({super.key});

  @override
  State<CustomDateBottomSheet> createState() => _CustomDateBottomSheetState();

  static Widget _weekDay(String label) => Text(
    label,
    style: TextStyle(
      fontSize: 12,
      color: Colors.blueGrey.shade400,
      fontWeight: FontWeight.w600,
    ),
  );

  static Widget _calendarRow(List<int> days,
      {List<int>? highlighted, int? selected}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((day) {
        final isHighlighted = highlighted?.contains(day) ?? false;
        final isSelected = selected == day;
        final isNormalRange = day >= 1 && day <= 28;

        Color bgColor = Colors.transparent;

        if (isSelected) {
          bgColor = const Color(0xFF2962FF);
        } else if (isHighlighted) {
          bgColor = const Color(0xFF03002F);
        } else if (isNormalRange) {
          bgColor = const Color(0xFFDAEDEE);
        }

        return Container(
          margin: const EdgeInsets.all(4),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: UIHelper.boldText(text: '$day', fontSize: 14, color: AppColors.black),

          ),
        );
      }).toList(),
    );
  }

  static Widget _roundArrow(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 12),
      ),
    );
  }
}

class _CustomDateBottomSheetState extends State<CustomDateBottomSheet> {
  String selectedPreference = 'Weekly';

  @override
  Widget build(BuildContext context) {
    // Adjust height for yearly
    final isYearly = selectedPreference == "Yearly";
    final initialHeight = isYearly ? 0.45 : 0.70; // smaller for yearly
    final maxHeight = isYearly ? 0.50 : 0.70;

    return SafeArea(
      bottom: false,
      child: DraggableScrollableSheet(
        initialChildSize: initialHeight,
        maxChildSize: maxHeight,
        minChildSize: 0.4,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFF03002F),
                        radius: 16,
                        child: Icon(Icons.calendar_month, color: Colors.white, size: 16),
                      ),
                      SizedBox(width: 10),
                      UIHelper.boldText(
                        text: 'Date Selection',
                        fontSize: 14,
                        color: AppColors.text,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Dropdown Selector
                  GestureDetector(
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => PreferenceSelectorBottomSheet(
                          selectedOption: selectedPreference,
                          onSelect: (value) {
                            setState(() {
                              selectedPreference = value;
                            });
                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, right: 4, top: 10, bottom: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF7F1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UIHelper.boldText(
                            text: selectedPreference,
                            fontSize: 14,
                            color: AppColors.black,
                          ),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: UIHelper.customSvg(svg: "dowen-svg.svg"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Calendar View (Dynamic)
                  CalendarViewFactory.getCalendarView(selectedPreference),

                  if (!isYearly) const SizedBox(height: 24), // Remove extra space for yearly

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF03002F),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Show Report',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BeVietnamPro',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}
