import 'package:flutter/material.dart';

class PreferenceOptionTile extends StatelessWidget {
  final String option;
  final String selectedOption;
  final VoidCallback onTap;

  const PreferenceOptionTile({
    Key? key,
    required this.option,
    required this.selectedOption,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedOption == option;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFDDEBF5) : const Color(0xFFEAF9F2),
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
                isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: const Color(0xFF0150EC),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
