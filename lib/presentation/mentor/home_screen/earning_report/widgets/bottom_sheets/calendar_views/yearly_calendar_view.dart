import 'package:flutter/material.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';

import '../../../../../../../res/constants/constants.dart';
import '../../../../../../../utils/ui_helper.dart';

class YearlyCalendarView extends StatefulWidget {
  const YearlyCalendarView({super.key});

  @override
  State<YearlyCalendarView> createState() => _YearlyCalendarViewState();
}

class _YearlyCalendarViewState extends State<YearlyCalendarView> {
  int _currentYear = DateTime.now().year;

  void _nextYear() {
    setState(() {
      _currentYear++;
    });
  }

  void _previousYear() {
    setState(() {
      _currentYear--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFECFBF3),
            borderRadius: BorderRadius.circular(36),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// Year Display + Navigation
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// 🟦 Year Label (Left Side)
                  Expanded(
                    child: Container(
                      height: 36,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingMedium,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffCEDBF1),
                        borderRadius: BorderRadius.circular(21),
                      ),
                      // child: Text(
                      //   '$_currentYear',
                      //   style: const TextStyle(
                      //     fontWeight: FontWeight.w700,
                      //     fontSize: 12,
                      //     fontFamily: 'BeVietnamPro',
                      //     color: AppColors.textblue,
                      //   ),
                      // ),
                      child: UIHelper.boldText(text: '$_currentYear', fontSize: 14, color: AppColors.text),
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
                        /// ⬅️ Previous Year
                        GestureDetector(
                          onTap: _previousYear,
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child: UIHelper.customSvg(svg: "left-svg.svg"),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        /// ➡️ Next Year
                        GestureDetector(
                          onTap: _nextYear,
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 18,
                                height: 18,
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

            ],
          ),
        ),

        SizedBox(height: 30,),
      ],
    );
  }
}
