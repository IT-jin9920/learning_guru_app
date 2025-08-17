import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/ui_helper.dart';

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
    return Container(
      height: 480,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Header
          Row(
            children: const [
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
              Text(
                'Select Preference',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF03002F),
                  fontFamily: 'BeVietnamPro',
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          /// Option List
          ...options.map(
            (option) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _tempSelectedOption = option;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: _tempSelectedOption == option
                        ? const Color(0xFFDDEBF5)
                        : const Color(0xFFEAF9F2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        option,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF0150EC),
                          fontFamily: 'BeVietnamPro',
                        ),
                      ),
                      Icon(
                        _tempSelectedOption == option
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: const Color(0xFF0150EC),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // const SizedBox(height: 20),
          Spacer(),

          /// Action Row
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFEAF0FE),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFCEDBF1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
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
    );
  }
}
