// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../../utils/ui_helper.dart';
// import 'preference_option_list.dart';
//
// class PreferenceSelectorBottomSheet extends StatefulWidget {
//   final String selectedOption;
//   final Function(String) onSelect;
//
//   const PreferenceSelectorBottomSheet({
//     Key? key,
//     required this.selectedOption,
//     required this.onSelect,
//   }) : super(key: key);
//
//   @override
//   State<PreferenceSelectorBottomSheet> createState() =>
//       _PreferenceSelectorBottomSheetState();
// }
//
// class _PreferenceSelectorBottomSheetState
//     extends State<PreferenceSelectorBottomSheet> {
//   late String _tempSelectedOption;
//
//   final List<String> options = const [
//     'Weekly',
//     'Monthly',
//     'Yearly',
//     'Custom Date',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _tempSelectedOption = widget.selectedOption;
//   }
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
//         children: [
//           /// Header
//           Row(
//             children: const [
//               CircleAvatar(
//                 radius: 16,
//                 backgroundColor: Color(0xFF03002F),
//                 child: Icon(
//                   Icons.calendar_month,
//                   color: Colors.white,
//                   size: 16,
//                 ),
//               ),
//               SizedBox(width: 10),
//               Text(
//                 'Select Preference',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF03002F),
//                   fontFamily: 'BeVietnamPro',
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 24),
//
//           /// List of Options (from separated widget)
//           PreferenceOptionList(
//             options: options,
//             selectedOption: _tempSelectedOption,
//             onOptionTap: (value) {
//               setState(() {
//                 _tempSelectedOption = value;
//               });
//             },
//           ),
//
//           const Spacer(),
//
//           /// Action Row
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: 22,
//                 backgroundColor: const Color(0xFFEAF0FE),
//                 child: GestureDetector(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Container(
//                     height: 40,
//                     width: 40,
//                     decoration: const BoxDecoration(
//                       color: Color(0xFFCEDBF1),
//                       shape: BoxShape.circle,
//                     ),
//                     padding: const EdgeInsets.all(8),
//                     child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF03002F),
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(32),
//                     ),
//                   ),
//                   onPressed: () {
//                     widget.onSelect(_tempSelectedOption);
//                     Navigator.pop(context);
//                   },
//                   child: const Text(
//                     'Select',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                       fontFamily: 'BeVietnamPro',
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';

import '../../../../../../../utils/ui_helper.dart';
import 'preference_option_list.dart';

class PreferenceSelectorBottomSheet extends StatefulWidget {
  final String selectedOption;
  final Function(String) onSelect;

  const PreferenceSelectorBottomSheet({
    Key? key,
    required this.selectedOption,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<PreferenceSelectorBottomSheet> createState() =>
      _PreferenceSelectorBottomSheetState();
}

class _PreferenceSelectorBottomSheetState
    extends State<PreferenceSelectorBottomSheet> {
  late String _tempSelectedOption;

  final List<String> options = const [
    'Weekly',
    'Monthly',
    'Yearly',
    'Custom Date',
  ];

  @override
  void initState() {
    super.initState();
    _tempSelectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {

    return DraggableScrollableSheet(
      initialChildSize: 0.70,
      maxChildSize: 0.70,
      minChildSize: 0.5,
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
              mainAxisSize: MainAxisSize.min, // ✅ prevents force-stretch
              children: [
                /// Header
                Row(
                  children:  [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Color(0xFF03002F),
                      child: Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: 10),
                    // Text(
                    //   'Select Preference',
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //     color: Color(0xFF03002F),
                    //     fontFamily: 'BeVietnamPro',
                    //   ),
                    // ),
                    UIHelper.boldText(text: 'Select Preference', fontSize: 14, color: AppColors.text),
                  ],
                ),

                const SizedBox(height: 24),

                /// Option List Component
                PreferenceOptionList(
                  options: options,
                  selectedOption: _tempSelectedOption,
                  onOptionTap: (value) {
                    setState(() => _tempSelectedOption = value);
                  },
                ),

               const SizedBox(height: 20), // ✅ replaced Spacer with fixed gap

                /// Action Buttons
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: const Color(0xFFEAF0FE),
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFFCEDBF1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: UIHelper.customSvg(
                            svg: "back-arrow-icon-svg.svg",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF03002F),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        onPressed: () {
                          widget.onSelect(_tempSelectedOption);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Select',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'BeVietnamPro',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

  }
}
