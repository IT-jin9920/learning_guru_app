import 'package:flutter/material.dart';
import 'preference_option_tile.dart';

class PreferenceOptionList extends StatelessWidget {
  final List<String> options;
  final String selectedOption;
  final Function(String) onOptionTap;

  const PreferenceOptionList({
    Key? key,
    required this.options,
    required this.selectedOption,
    required this.onOptionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options
          .map((option) => PreferenceOptionTile(
        option: option,
        selectedOption: selectedOption,
        onTap: () => onOptionTap(option),
      ))
          .toList(),
    );
  }
}
