import 'package:flutter/material.dart';

import '../res/colors/app_color.dart';
import '../res/constants/constants.dart';
import '../utils/ui_helper.dart';

class EarningReportSwitcher extends StatefulWidget {
  final void Function(String monthYear)? onMonthChanged;

  const EarningReportSwitcher({super.key, this.onMonthChanged});

  @override
  State<EarningReportSwitcher> createState() => _EarningReportSwitcherState();
}

class _EarningReportSwitcherState extends State<EarningReportSwitcher> {
  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  int _currentMonthIndex = DateTime.now().month - 1;
  int _currentYear = DateTime.now().year;

  void _nextMonth() {
    setState(() {
      _currentMonthIndex++;
      if (_currentMonthIndex >= _months.length) {
        _currentMonthIndex = 0;
        _currentYear++;
      }
    });
    widget.onMonthChanged?.call('${_months[_currentMonthIndex]} $_currentYear');
  }

  void _previousMonth() {
    setState(() {
      _currentMonthIndex--;
      if (_currentMonthIndex < 0) {
        _currentMonthIndex = _months.length - 1;
        _currentYear--;
      }
    });
    widget.onMonthChanged?.call('${_months[_currentMonthIndex]} $_currentYear');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// 🟦 Month-Year Label (Left Side)
        Expanded(
          child: Container(
            height: 36,
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstantsSpacing.paddingMedium,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffCEDBF1),
              borderRadius: BorderRadius.circular(21),
            ),
            alignment: Alignment.center,
            child: UIHelper.boldText(
              text: '${_months[_currentMonthIndex]} $_currentYear',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textblue,
            ),
          ),
        ),

        const SizedBox(width: AppConstantsSpacing.spacingSmall),

        /// ⬅️➡️ Arrows Container
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(
            horizontal:3
          ),
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
                onTap: _previousMonth,
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
                        child: UIHelper.customSvg(svg: "left-svg.svg")),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              /// ➡️ Next Month
              GestureDetector(
                onTap: _nextMonth,
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
                        child: UIHelper.customSvg(svg: "right-svg.svg")),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
