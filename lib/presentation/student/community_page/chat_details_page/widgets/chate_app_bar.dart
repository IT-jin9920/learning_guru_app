import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';

import '../../../../../utils/ui_helper.dart';
import '../chat_user_profile/chat_user_profile.dart';

class CustomAppBarRow extends StatelessWidget {
  const CustomAppBarRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          UIHelper.customNetworkImage(
            imageUrl: "https://randomuser.me/api/portraits/men/47.jpg",
            height: 56,
            width: 56,
            isCircular: true,
          ),

          // UIHelper.customImage(img: "chat-user-1.png", width: 55, height: 55),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              // Text(
              //   "Luke Tailor",
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 18,
              //     color: Colors.black,
              //   ),
              // ),
              UIHelper.boldText(text:  "Luke Tailor", fontSize: 16, color: AppColors.text),
              SizedBox(height: 4),
              // Text(
              //   "Class 5B  |  Roll No. 34",
              //   style: TextStyle(color: Colors.grey, fontSize: 13),
              // ),
              UIHelper.mediumText(text:   "Class 5B  |  Roll No. 34", fontSize: 12, color: Colors.blueGrey),

            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.to(
                ChatUserProfilePage(
                  username: "Luke Tailor",
                  className: "5B",
                  rollNumber: "23",
                  imageUrl: "https://randomuser.me/api/portraits/men/47.jpg",
                ),
              );
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFCDD6E9),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: UIHelper.customImage(
                  img: "user-profiel-seting.png",
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
