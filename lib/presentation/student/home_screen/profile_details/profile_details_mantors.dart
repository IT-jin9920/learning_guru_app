import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/profile_screen/edit_profile_image/edit_about_info_pop_up.dart';
import 'package:learning_guru_app/presentation/profile_screen/edit_profile_image/edit_bank_details_page.dart';
import 'package:learning_guru_app/presentation/profile_screen/edit_profile_image/edit_mentorship_details_page.dart';
import 'package:learning_guru_app/presentation/profile_screen/edit_profile_image/edit_profileInfo_page.dart';
import 'package:learning_guru_app/presentation/profile_screen/setting_page/settings/settings_page.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/res/constants/constants.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

import 'ReviewRatingsPage.dart';
import 'book_session_screen.dart';

class ProfileDetailsMantors extends StatefulWidget {
  const ProfileDetailsMantors({super.key});

  @override
  State<ProfileDetailsMantors> createState() => _ProfileDetailsMantorsState();
}

class _ProfileDetailsMantorsState extends State<ProfileDetailsMantors> {
  File? _imageFile;
  int selectedTabIndex = 0;

  final List<String> certificationImages = [
    'https://picsum.photos/id/237/200/300',
    'https://picsum.photos/id/238/200/300',
    'https://picsum.photos/id/239/200/300',
    'https://picsum.photos/id/240/200/300',
    'https://picsum.photos/id/237/200/300',
    'https://picsum.photos/id/238/200/300',
    'https://picsum.photos/id/239/200/300',
    'https://picsum.photos/id/240/200/300',
    'https://picsum.photos/id/237/200/300',
    'https://picsum.photos/id/238/200/300',
    'https://picsum.photos/id/239/200/300',
    'https://picsum.photos/id/240/200/300',
  ];


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color(0xffEAF2FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Profile Picture with SVG border
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background Circular SVG
                      SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: Center(
                          child: SizedBox(
                            width: 250,
                            height: 250,
                            child: ClipOval(
                              child: UIHelper.customSvg(
                                svg: "profile-bg-home.svg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Profile Image
                      Positioned(
                        top: 100,
                        child: GestureDetector(
                          onTap: () => print("Profile image tapped"),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: _imageFile != null
                                  ? FileImage(_imageFile!)
                                  : const AssetImage("assets/images/user-3.png")
                                        as ImageProvider,
                            ),
                          ),
                        ),
                      ),

                      /// Title Section
                      Positioned(
                        top: 10,
                        left: 16,
                        right: 16,
                        child: Container(
                          height: 70,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  child: UIHelper.customSvg(
                                    svg: "back-arrow-icon-svg.svg",
                                  ),
                                ),
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    UIHelper.boldText(
                                      text: "Paediatrician Coach",
                                      fontSize: 18,
                                      color: AppColors.text,
                                    ),
                                    // SizedBox(height: 4),
                                    // UIHelper.boldText(
                                    //   text: "Sports Community",
                                    //   fontSize: 12,
                                    //   color: AppColors.textblue,
                                    // ),
                                  ],
                                ),
                              ),
                              // const SizedBox(width: 40), // spacing filler
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 24),
                  UIHelper.boldText(
                    text: "Luke Tailor",
                    fontSize: 24,
                    color: AppColors.textblue,
                  ),
                  const SizedBox(height: 24),
                ],
              ),

              // Book and rate
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Allows horizontal scroll if needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: ()=> Get.to(ReviewRatingsPage()),
                        child: Container(
                          height: 48,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Color(0xFFCDDCF4), // #CDDCF4 color
                            borderRadius: BorderRadius.circular(46),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                SizedBox(width: 16), // left padding
                                UIHelper.customSvg(svg: "start-svg-icon.svg"),
                                SizedBox(width: 8),
                                Container(
                                  width: 1,
                                  height: 6,
                                  color: AppColors.textblue,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '4.8',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () => Get.to(() => BookSessionScreen()),
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF000042),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UIHelper.boldText(
                                text: "Book Session",
                                fontSize: 12,
                                color: AppColors.white,
                              ),
                              const SizedBox(width: 20),
                              Row(
                                children: [
                                  UIHelper.boldText(
                                    text: "\$",
                                    fontSize: 14,
                                    color: AppColors.primary2,
                                  ),
                                  UIHelper.boldText(
                                    text: "\10/Hr",
                                    fontSize: 14,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 6),
                              SizedBox(
                                height: 16,
                                width: 16,
                                child: UIHelper.customSvgOnTap(
                                  svg: "edit-icon-svg.svg",
                                  onTap: () {},
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),

              // 🔸 Divider
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      UIHelper.mediumText(
                        text: 'Consulted',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textblue,
                      ),

                      SizedBox(height: AppConstantsSpacing.spacingSmall / 2),

                      UIHelper.boldText(
                        text: '130+ Students',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.text,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 14,
                    child: VerticalDivider(width: 0, color: AppColors.primary1),
                  ),
                  Column(
                    children: [
                      UIHelper.mediumText(
                        text: 'Reviews',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textblue,
                      ),

                      SizedBox(height: AppConstantsSpacing.spacingSmall / 2),

                      UIHelper.boldText(
                        text: '100+ Feedbacks',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // 🔸 Divider
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),

              const SizedBox(height: 30),

              /// Tabs
              Container(
                child: Row(
                  children: [
                    /// About Info Tab
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTabIndex = 0;
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white, // White background
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UIHelper.boldText(
                                text: "About Info",
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: selectedTabIndex == 0
                                    ? AppColors.textblue
                                    : AppColors.grey,
                              ),
                              const SizedBox(height: 8),
                              // Divider(
                              //   thickness: 1,
                              //   color: selectedTabIndex == 0
                              //       ? AppColors.text
                              //       : Colors.transparent,
                              //   indent: 32,
                              //   endIndent: 32,
                              // ),

                              LayoutBuilder(
                                builder: (context, constraints) {
                                  // You can use TextPainter if you want exact pixel width
                                  double textWidth = 74; // safe approx value or calculated dynamically

                                  return Center(
                                    child: SizedBox(
                                      width: textWidth, // restrict width to match text
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: 24, // fixed divider width
                                          height: 1,
                                          color: selectedTabIndex == 0
                                              ? AppColors.text
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                    /// Certifications Tab
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTabIndex = 1;
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white, // White background
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UIHelper.boldText(
                                text: "Certifications",
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: selectedTabIndex == 1
                                    ? AppColors.textblue
                                    : AppColors.grey,
                              ),
                              const SizedBox(height: 8),
                              // Divider(
                              //   thickness: 2,
                              //   color: selectedTabIndex == 1
                              //       ? Colors.blue
                              //       : Colors.transparent,
                              //   indent: 32,
                              //   endIndent: 32,
                              // ),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  // You can use TextPainter if you want exact pixel width
                                  double textWidth = 99; // safe approx value or calculated dynamically

                                  return Center(
                                    child: SizedBox(
                                      width: textWidth, // restrict width to match text
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: 24, // fixed divider width
                                          height: 1,
                                          color: selectedTabIndex == 1
                                              ? AppColors.text
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),

              /// Info Section Box
              selectedTabIndex == 0
                  ? Container(
                      width: double.infinity,
                      color: Colors.white,
                      // decoration: BoxDecoration(
                      //   color: Colors.white,
                      //   borderRadius: BorderRadius.circular(24),
                      // ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // Personal Info Section
                          InfoSection(
                            title: 'Personal Info',
                            text:
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                          ),
                          SizedBox(height: 24.0), // Spacer between sections

                          // Education & Qualification Section
                          InfoSection(
                            title: 'Education & Qualification',
                            text:
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                          ),
                          SizedBox(height: 16.0), // Spacer for the second text block

                          // Second Text Block for Education Section
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    )
                  :Container(
                width: double.infinity,
                color: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      color: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child:GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                        itemCount: certificationImages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            clipBehavior: Clip.hardEdge, // important for rounded corners on images
                            child: Image.network(
                              certificationImages[index],
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // Image loaded
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) => Center(
                                child: Icon(Icons.broken_image, color: Colors.grey),
                              ),
                            ),
                          );
                        },
                      ),
                    ),


                  ],
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }

}

class InfoSection extends StatelessWidget {
  final String title;
  final String text;

  const InfoSection({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rounded header container
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey[100], // A light, muted color for the tab
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: UIHelper.boldText(text: title, fontSize: 10, color: AppColors.text),
        ),
        const SizedBox(height: 16.0), // Spacer below the header

        // Text block container
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child:UIHelper.regularText(text: text,  fontSize: 14, color: AppColors.grey),
        ),
      ],
    );
  }
}