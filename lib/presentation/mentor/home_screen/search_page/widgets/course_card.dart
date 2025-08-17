import 'package:flutter/material.dart';
import '../../../../../utils/ui_helper.dart';
import '../../../../../res/colors/app_color.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String subject;
  final String imagePath;
  final String price;
  final double rating;

  const UserCard({
    super.key,
    required this.name,
    required this.subject,
    required this.imagePath,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement navigation logic if needed
      },
      child: Container(
        height: 131,
        width: 158,
        decoration: BoxDecoration(
          color: const Color(0xFFe6e8ed),
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Avatar and Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: UIHelper.customImage(img: imagePath),
                  ),
                ),
                Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColors.text,
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UIHelper.customSvg(
                      svg: "chat-svg-icon.svg",
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.boldText(
                    text: name,
                    fontSize: 14,
                    color: AppColors.text,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      UIHelper.mediumText(
                        text: "11th Nov,",
                        fontSize: 12,
                        color: AppColors.textblue,
                      ),
                      const SizedBox(width: 4),
                      UIHelper.mediumText(
                        text: "10:00 AM",
                        fontSize: 12,
                        color: AppColors.textblue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
