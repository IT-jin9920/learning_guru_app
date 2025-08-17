import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/student/community_page/sports_tutors/sports_tutors.dart';
import 'package:learning_guru_app/widgets/base_button.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../utils/ui_helper.dart';

class ExploreMentorScreen extends StatefulWidget {
  const ExploreMentorScreen({super.key});

  @override
  State<ExploreMentorScreen> createState() => _ExploreMentorScreenState();
}

class _ExploreMentorScreenState extends State<ExploreMentorScreen> {
  int selectedIndexone = 0; // Inside your StatefulWidget
  int selectedIndextwo = 2; // Inside your StatefulWidget
  int selectedIndexthree = 1; // Inside your StatefulWidget
  int selectedIndexfour = 3; // Inside your StatefulWidget

  final List<String> subjectsRowOne = [
    "Doctor",
    "Engineer",
    "Pilot",
    "Chef",
  ];

  final List<String> subjectsRowTwo = [
    "Dancer",
    "Actor",
    "Lawyer",
    "Singer",
  ];

  final List<String> subjectsRowThree = [
    "Nurse",
    "Art & Design",
    "Sports",
    "Journalist",
  ];

  final List<String> subjectsRowFour = [
    "Psychologist",
    "Filmmaker",
    "Civil Servant",
    "Physics",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 70,

                child: Row(
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

                    // Center(
                    //   child: Text(
                    //     'My Sessions',
                    //     style: TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //       color: AppColors.text,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(width: 40), // spacing filler
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Ensures all text is left-aligned
                children: [
                  // Title Text
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      UIHelper.boldText(
                        text: "A ",
                        fontSize: 24,
                        color: AppColors.text,
                      ),
                      UIHelper.boldText(
                        text: "Mentorship ",
                        fontSize: 24,
                        color: AppColors.textblue,
                      ),
                      UIHelper.boldText(
                        text: "for your",
                        fontSize: 24,
                        color: AppColors.text,
                      ),
                    ],
                  ),
                  UIHelper.boldText(
                    text: "Career Crafting!",
                    fontSize: 24,
                    color: AppColors.text,
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  UIHelper.mediumText(
                    text:
                    'A nicely curated group of mentors socially for you to uplift your career.',
                    fontSize: 14,
                    color: Colors.grey,
                    textAlign: TextAlign.start, // Ensure left alignment
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),


            // 1st  Fields Grid
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(subjectsRowOne.length, (index) {
                    Color bgColor;

                    if (index == selectedIndexone) {
                      bgColor = AppColors.textblue;
                    } else if (index == 1) {
                      bgColor = const Color(0xFFE0E2E9);
                    } else if (index == 2) {
                      bgColor = const Color(0xFFCDDCF4);
                    } else {
                      bgColor = const Color(0xFFE9ECF3);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndexone = index;
                          });
                        },
                        child: Container(
                          width: 112,
                          height: 56,
                          padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: bgColor,
                          ),
                          child: UIHelper.mediumText(
                            text: subjectsRowOne[index],
                            fontSize: 16,
                            color: index == selectedIndexone
                                ? AppColors.white
                                : const Color(0xFF0A0C2C),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(subjectsRowTwo.length, (index) {
                    Color bgColor;

                    if (index == selectedIndextwo) {
                      bgColor = AppColors.textblue;
                    } else if (index == 1) {
                      bgColor = const Color(0xFFCDDCF4);
                    } else if (index == 2) {
                      bgColor = const Color(0xFFE0E2E9);
                    } else {
                      bgColor = const Color(0xFFE9ECF3);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndextwo = index;
                          });
                        },
                        child: Container(
                          width: 112,
                          height: 56,
                          padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: bgColor,
                          ),
                          child: UIHelper.mediumText(
                            text: subjectsRowTwo[index],
                            fontSize: 16,
                            color: index == selectedIndextwo
                                ? AppColors.white
                                : const Color(0xFF0A0C2C),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(subjectsRowThree.length, (index) {
                    Color bgColor;

                    if (index == selectedIndexthree) {
                      bgColor = AppColors.textblue;
                    } else if (index == 1) {
                      bgColor = const Color(0xFFE9ECF3);
                    } else if (index == 2) {
                      bgColor = const Color(0xFFCDDCF4);
                    } else {
                      bgColor = const Color(0xFFE0E2E9);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndexthree = index;
                          });
                        },
                        child: Container(
                          width: 112,
                          height: 56,
                          padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: bgColor,
                          ),
                          child: UIHelper.mediumText(
                            text: subjectsRowThree[index],
                            fontSize: 16,
                            color: index == selectedIndexthree
                                ? AppColors.white
                                : const Color(0xFF0A0C2C),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(subjectsRowFour.length, (index) {
                    Color bgColor;

                    if (index == selectedIndexfour) {
                      bgColor = AppColors.textblue;
                    } else if (index == 1) {
                      bgColor = const Color(0xFFCDDCF4);
                    } else if (index == 2) {
                      bgColor = const Color(0xFFE0E2E9);
                    } else {
                      bgColor = const Color(0xFFE9ECF3);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndexfour = index;
                          });
                        },
                        child: Container(
                          width: 112,
                          height: 56,
                          padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: bgColor,
                          ),
                          child: UIHelper.mediumText(
                            text: subjectsRowFour[index],
                            fontSize: 16,
                            color: index == selectedIndexfour
                                ? AppColors.white
                                : const Color(0xFF0A0C2C),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
        child: GradientButton(
          text: "Explore Community",
          onTap: () {
            Get.back();
            //Get.to(SportsTutors());
          },
        ),
      ),
    );
  }
}
