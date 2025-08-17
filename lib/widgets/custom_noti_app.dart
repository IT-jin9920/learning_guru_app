import 'package:flutter/material.dart';

class CustomAppBarRow extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final bool showBack;
  final Widget? rightWidget;

  const CustomAppBarRow({
    super.key,
    this.title = '',
    this.onBack,
    this.showBack = true,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [


        // Title aligned center
        Expanded(
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black, // or theme based
              ),
            ),
          ),
        ),

        // Right widget (optional action)
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: rightWidget ?? const SizedBox(width: 40), // size match back button
        ),
      ],
    );
  }
}
