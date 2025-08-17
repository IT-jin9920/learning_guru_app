
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

class CustomAppBarRow extends StatelessWidget {
  final String username;
  final String className;
  final String rollNumber;
  final String imageUrl;

  const CustomAppBarRow({
    Key? key,
    required this.username,
    required this.className,
    required this.rollNumber,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFCEDBF1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
                ),
              ),

              // Title
              const Text(
                'Chat Detail',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF1A73E8), // Or use AppColors.textblue
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Class $className  |  Roll No. $rollNumber",
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              const Spacer(),
              UIHelper.customNetworkImage(
                imageUrl: imageUrl,
                height: 100,
                width: 100,
                isCircular: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
