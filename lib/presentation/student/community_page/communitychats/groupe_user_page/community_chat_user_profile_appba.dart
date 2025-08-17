
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';
import 'package:learning_guru_app/widgets/base_button.dart';

import 'share_qr_code.dart';

class CommunityChatUserProfileAppba extends StatelessWidget {
  final String username;
  final String member;
  final String imageUrl;

  const CommunityChatUserProfileAppba({
    Key? key,
    required this.username,
    required this.member,
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
                'Group Details',
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
                  Row(
                    children: [
                      UIHelper.customSvg(svg: "member-add-icon.svg", height: 16, width:16),

                     SizedBox(width: 8,),
                      Container(width: 1,height: 8,color: AppColors.textblue,),
                      SizedBox(width: 8,),
                      Text(
                        "$member",
                        style: const TextStyle(color: Color(0xff9093ae), fontSize: 13),
                      ),
                    ],
                  ),
                  SizedBox(height: 18,),
                  InkWell(
                    onTap: (){
                      Get.bottomSheet(
                        ShowQRCodeBottomSheet(
                          qrImagePath: 'assets/images/qr.png',
                          userName:  "Mathematic Heads",
                          userImagePath: "https://randomuser.me/api/portraits/men/47.jpg",
                        ),
                        isScrollControlled: true,
                      );


                    },
                    child: Container(
                      height: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFcedbf1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UIHelper.customSvg(svg: "qr-code.svg", height: 16, width: 16),
                            SizedBox(width: 4,),
                            UIHelper.mediumText(
                              text: "QR to Join",
                              fontSize: 10,
                              color: Color(0xff54587d),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              const Spacer(),
              // UIHelper.customNetworkImage(
              //   imageUrl: imageUrl,
              //   height: 100,
              //   width: 100,
              //   isCircular: true,
              // ),
              Stack(
                children: [
                  // Main image
                  UIHelper.customImage(
                    img: "comunity-user-img.png",
                    height: 100,
                    width: 100,
                  ),

                  // Positioned circular edit icon (bottom-right)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9DB8E7),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: UIHelper.customSvg(
                          svg: "edit-icon-svg.svg",
                          height: 14,
                          width: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}



class ShowQRCodeBottomSheet extends StatelessWidget {
  final String qrImagePath;
  final String userName;
  final String userImagePath; // e.g., 'assets/images/user_profile.png'

  const ShowQRCodeBottomSheet({
    super.key,
    required this.qrImagePath,
    required this.userName,
    required this.userImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: FractionallySizedBox(
          heightFactor: 0.55,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Header with QR icon
                /// Profile Image & Name
                Row(
                  children: [
                    // CircleAvatar(
                    //   radius: 20,
                    //   backgroundImage: AssetImage(userImagePath),
                    // ),
                    UIHelper.customImage(
                      img: "comunity-user-img.png",
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(width: 10),
                    UIHelper.boldText(
                      text: userName,
                      fontSize: 16,
                      color: AppColors.text,
                    ),
                  ],
                ),

                const SizedBox(height: 30),
Spacer(),
                /// QR Code
                Center(
                  child: Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    //  color: const Color(0xFFE6E8ED),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/qr-code.png"), // Correct usage
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// Share Button

                InkWell(
                  onTap: (){
                    Get.to(ShareQrCode());
                  },
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 24),
                        Text(
                          "Share QR Code",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // const Spacer(),
                        // Container(
                        //   height: 60,
                        //   width: 80,
                        //   decoration: const BoxDecoration(
                        //     gradient: LinearGradient(
                        //       colors: [
                        //         Color(0x00000000), // Transparent
                        //         Color(0xFF6C6A86), // Gradient color
                        //       ],
                        //       begin: Alignment.centerLeft,
                        //       end: Alignment.centerRight,
                        //     ),
                        //     borderRadius: BorderRadius.only(
                        //       topRight: Radius.circular(26),
                        //       bottomRight: Radius.circular(26),
                        //     ),
                        //   ),
                        //   alignment: Alignment.centerRight,
                        //   // child: Icon(
                        //   //   icon,
                        //   //   color: Colors.white,
                        //   //   size: 20,
                        //   // ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(right: 16),
                        //     child: UIHelper.customSvgOnTap(svg: "bak-btn-botam.svg",
                        //       width: 20,
                        //       height:20,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
