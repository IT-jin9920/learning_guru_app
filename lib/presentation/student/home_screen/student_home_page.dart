import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/app_navigation/bottom_navigation_page.dart';
import 'package:learning_guru_app/presentation/mentor/home_screen/notification_page/Notifications_screen.dart';
import 'package:learning_guru_app/presentation/mentor/home_screen/search_page/search_screen.dart';
import 'package:learning_guru_app/presentation/student/home_screen/search_page/search_screen.dart';
import 'package:learning_guru_app/res/constants/constants.dart';

import '../../../core/services/user_data.dart';
import '../../../res/colors/app_color.dart';
import '../../../utils/ui_helper.dart';
import 'my_session/my_sessions_page.dart';
import 'profile_details/profile_details_mantors.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    final bottomNavController = Get.find<BottomNavController>();

    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Color(0xffEAF2FF),
        body: Stack(
          children: [
            /// 🎨 Background Layer
            Positioned(right: 0, top: -35, child: _buildDecorativeBackground()),

            /// 📦 Foreground Content
            SafeArea(
              child: SingleChildScrollView( // 🔹 Whole page scrollable
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔲 Padded Section (Top content)
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          GestureDetector(
                            onTap: () => bottomNavController.changeTab(4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    UIHelper.boldText(
                                      text: 'Hey,',
                                      fontSize: 24,
                                      color: AppColors.textblue,
                                    ),
                                    Row(
                                      children: [
                                        UIHelper.boldText(
                                          text: 'Alexandra!!',
                                          fontSize: 24,
                                          color: AppColors.text,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(width: AppConstantsSpacing.spacingSmall),
                                        SizedBox(
                                          height: screenHeight * 0.05,
                                          width: screenWidth * 0.10,
                                          child: UIHelper.customImage(
                                            img: "hand-png.png",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // 🔔 Notification
                                Material(
                                  color: AppColors.text,
                                  shape: const CircleBorder(),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    onTap: () => Get.to(NotificationsScreen()),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      padding: const EdgeInsets.all(18),
                                      child: UIHelper.customSvg(
                                        svg: "noti-icon-svg.svg",
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: AppConstantsSpacing.spacingSmall),

                          /// Search Field
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.text,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(45),
                                  border: Border.all(
                                    color: Color(0xFFCDDCF4),
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: UIHelper.customSvg(
                                      svg: "serch-icon-svg.svg",
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFCDDCF4),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: TextField(
                                    style: const TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      hintText: "Search for Groups & Chats",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Color(0xff7c84a5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20),

                          /// Upcoming Session
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => Get.to(MySessionsPage()),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 8.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  UIHelper.boldText(
                                    text: 'Upcoming Session',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.text,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: UIHelper.customSvg(
                                      svg: "right-arrow-svg-icon.svg",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: AppConstantsSpacing.spacingMedium),

                          /// Horizontal upcoming sessions
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(upcomingSessions.length, (index) {
                                final session = upcomingSessions[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: index < upcomingSessions.length - 1 ? 10.0 : 0,
                                  ),
                                  child: _buildUserCard(
                                    name: session['name']!,
                                    subject: session['subject']!,
                                    date: session['date']!,
                                    imagePath: session['imagePath']!,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// 🔳 White background section
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Mentors
                          InkWell(
                            onTap: () => Get.to(StudentSearchScreen()),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  UIHelper.boldText(
                                    text: "Explore Mentors",
                                    fontSize: 18,
                                    color: AppColors.text,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: UIHelper.customSvg(
                                      svg: "right-arrow-svg-icon.svg",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(mentorList.length, (index) {
                                  final mentor = mentorList[index];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: index < mentorList.length - 1 ? 11.0 : 0,
                                    ),
                                    child: _buildMentorsUserCard(
                                      name: mentor.name,
                                      subject: mentor.subject,
                                      rate: mentor.rate,
                                      imagePath: mentor.imagePath,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),

                          SizedBox(height: 32),

                          // Tutors
                          InkWell(
                            onTap: () => Get.to(StudentSearchScreen()),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  UIHelper.boldText(
                                    text: "Explore Tutors",
                                    fontSize: 18,
                                    color: AppColors.text,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: UIHelper.customSvg(
                                      svg: "right-arrow-svg-icon.svg",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(tutorList.length, (index) {
                                  final tutor = tutorList[index];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: index < tutorList.length - 1 ? 11.0 : 0,
                                    ),
                                    child: _buildTutorUserCard(
                                      name: tutor.name,
                                      subject: tutor.subject,
                                      rate: tutor.rate,
                                      imagePath: tutor.imagePath,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),

                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget _buildDecorativeBackground() => Stack(
    children: [
      // UIHelper.customSvg(svg: "bg.svg"),
      UIHelper.customSvg(svg: "bg.svg", fit: BoxFit.cover),
    ],
  );

  Widget _buildUserCard({
    required String name,
    required String subject,
    required String date,
    required String imagePath,
  }) {
    final BottomNavController bottomNavController =
    Get.find<BottomNavController>();

    return GestureDetector(
      onTap: () {

      },
      child: Container(
        height: 155,
        width: 165,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Avatar and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Avatar
                SizedBox(
                  width: 56,
                  height: 56,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: UIHelper.customImage(img: "$imagePath"),
                  ),
                ),
                SizedBox(width: 8),

                // Chat Tag
                GestureDetector(
                  onTap: () {
                    bottomNavController.changeTab(1); // Redirect to tab index 2
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Container(
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
                  /// Subject
                  Row(
                    children: [
                      UIHelper.customSvg(
                        svg: "subject-svg.svg",
                        width: 16,
                        height: 16,
                      ),
                      SizedBox(width: 4),
                      UIHelper.boldText(
                        text: subject,
                        fontSize: 10,
                        color: AppColors.textblue,
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  /// Name
                  UIHelper.boldText(
                    text: name,
                    fontSize: 14,
                    color: AppColors.text,
                  ),
                  const SizedBox(height: 2),

                  /// Rating
                  Row(
                    children: [
                      UIHelper.mediumText(
                        text: "11th Nov,",
                        fontSize: 10,
                        color: AppColors.textblue,
                      ),
                      const SizedBox(width: 4),
                      UIHelper.mediumText(
                        text: "10:00 AM",
                        fontSize: 10,
                        color: AppColors.textblue,
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMentorsUserCard({
    required String name,
    required String subject,
    required String rate,
    required String imagePath,
  }) {
    final BottomNavController bottomNavController =
    Get.find<BottomNavController>();

    return GestureDetector(
      onTap: () {
        Get.to(() => ProfileDetailsMantors());
      },
      child: Container(
        height: 155,
        width: 165,
        decoration: BoxDecoration(
          color: Color(0xffe6e8ed),
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Avatar and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Avatar
                SizedBox(
                  width: 56,
                  height: 56,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: UIHelper.customImage(img: "$imagePath"),
                  ),
                ),
                SizedBox(width: 8),
                // Chat Tag
                GestureDetector(
                  onTap: () {
                    // bottomNavController.changeTab(4); // Redirect to tab index 2
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Container(
                      height: 40,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppColors.text,
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UIHelper.boldText(
                                text: "\$",
                                fontSize: 12,
                                color: AppColors.primary2,
                              ),
                              UIHelper.boldText(
                                text: "10/Hr",
                                fontSize: 9,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
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
                  /// Subject
                  Row(
                    children: [
                      UIHelper.customSvg(
                        svg: "subject-svg.svg",
                        width: 16,
                        height: 16,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: UIHelper.boldText(
                          text: subject,
                          fontSize: 10,
                          color: AppColors.textblue,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  /// Name
                  UIHelper.boldText(
                    text: name,
                    fontSize: 14,
                    color: AppColors.text,
                  ),
                  const SizedBox(height: 2),

                  /// Rating
                  Row(
                    children: [
                      UIHelper.customSvg(
                        svg: "star-svg-icon.svg",
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(width: 4),
                      UIHelper.mediumText(
                        text: rate,
                        fontSize: 10,
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

  Widget _buildTutorUserCard({
    required String name,
    required String subject,
    required String rate,
    required String imagePath,
  }) {
    final BottomNavController bottomNavController =
    Get.find<BottomNavController>();

    return GestureDetector(
      onTap: () {
        Get.to(() => ProfileDetailsMantors());
      },
      child: Container(
        height: 155,
        width: 165,
        decoration: BoxDecoration(
          color: Color(0xffe6e8ed),
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Avatar and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Avatar
                SizedBox(
                  width: 56,
                  height: 56,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: UIHelper.customImage(img: "$imagePath"),
                  ),
                ),
                SizedBox(width: 8),
                // Chat Tag
                GestureDetector(
                  onTap: () {
                    // bottomNavController.changeTab(4); // Redirect to tab index 2
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Container(
                      height: 40,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppColors.text,
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UIHelper.boldText(
                                text: "\$",
                                fontSize: 12,
                                color: AppColors.primary2,
                              ),
                              UIHelper.boldText(
                                text: "10/Hr",
                                fontSize: 9,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
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
                  /// Subject
                  Row(
                    children: [
                      UIHelper.customSvg(
                        svg: "subject-svg.svg",
                        width: 16,
                        height: 16,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: UIHelper.boldText(
                          text: subject,
                          fontSize: 10,
                          color: AppColors.textblue,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  /// Name
                  UIHelper.boldText(
                    text: name,
                    fontSize: 14,
                    color: AppColors.text,
                  ),
                  const SizedBox(height: 2),

                  /// Rating
                  Row(
                    children: [
                      UIHelper.customSvg(
                        svg: "star-svg-icon.svg",
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(width: 4),
                      UIHelper.mediumText(
                        text: rate,
                        fontSize: 10,
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