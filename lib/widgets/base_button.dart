import 'package:flutter/material.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final IconData icon;
  final List<Color>? colors;



  const GradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon = Icons.arrow_forward,  this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF04002C),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: const Color(0xFF03002F), // #03002F
            width: 2,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 24),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Container(
              height: 60,
              width: 80,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0x00000000), // Transparent
                    Color(0xFF6C6A86), // Gradient color
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(26),
                  bottomRight: Radius.circular(26),
                ),
              ),
              alignment: Alignment.centerRight,
              // child: Icon(
              //   icon,
              //   color: Colors.white,
              //   size: 20,
              // ),
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: UIHelper.customSvgOnTap(svg: "bak-btn-botam.svg",
                width: 20,
                  height:20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
