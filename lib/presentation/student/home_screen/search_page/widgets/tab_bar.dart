import 'package:flutter/material.dart';
import '../../../../../utils/ui_helper.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final List<String> icons;
  final int selectedTabIndex;
  final Function(int) onTabSelected;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.icons,
    required this.selectedTabIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(tabs.length, (index) {
            return GestureDetector(
              onTap: () => onTabSelected(index),
              child: Row(
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: UIHelper.customSvg(
                      svg: icons[index],
                      color: selectedTabIndex == index ? Colors.blue : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    tabs[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: selectedTabIndex == index ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(height: 2, width: double.infinity),
            AnimatedAlign(
              alignment: Alignment(
                -1 + (selectedTabIndex * (2 / (tabs.length - 1))),
                0,
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                height: 2,
                width: MediaQuery.of(context).size.width / tabs.length - 32,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
