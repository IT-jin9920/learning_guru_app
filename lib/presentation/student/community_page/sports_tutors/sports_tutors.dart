
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/core/services/user_data.dart';
import 'package:learning_guru_app/models/tutor_sesstion_model.dart';
import 'package:learning_guru_app/presentation/app_navigation/bottom_navigation_page.dart';
import 'package:learning_guru_app/presentation/student/home_screen/profile_details/profile_details_mantors.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

class SportsTutors extends StatefulWidget {
  const SportsTutors({super.key});

  @override
  State<SportsTutors> createState() => _SportsTutorsState();
}

class _SportsTutorsState extends State<SportsTutors> {

  final TextEditingController _searchController = TextEditingController();

  List<TutorSession> filteredTutors = [];

  @override
  void initState() {
    super.initState();
    filteredTutors = List.from(allTutors);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredTutors = allTutors.where((session) {
        return session.name.toLowerCase().contains(query) ||
            session.subject.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            children: [
              // Header
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    Center(
                      child: Text(
                        'Sports Tutors',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    // const SizedBox(width: 40), // spacing filler
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Search & Sorting
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Search Field
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFCDDCF4),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            SizedBox(
                              height: 16,
                              width: 16,
                              child: UIHelper.customSvg(
                                svg: "serch-icon-svg.svg",
                                color: AppColors.textblue,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                style: const TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                                decoration: const InputDecoration(
                                  hintText: "Search for Tutor or Subject",
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
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Sorting Button
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCDDCF4),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 16,
                            width: 16,
                            child: UIHelper.customSvg(
                              svg: "sorting-icon.svg",
                              color: AppColors.textblue,
                            ),
                          ),
                          const SizedBox(width: 6),
                          UIHelper.mediumText(
                            text: "Sorting",
                            fontSize: 12,
                            color: AppColors.text,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
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
            ],
          ),
        ),
      ),
    );
  }

  // Widget _SessionCard({
  //   required String tutorName,
  //   required String subject,
  //   required String dateTime,
  // }) {
  //   final BottomNavController bottomNavController = Get.find<BottomNavController>();
  //
  //   return GestureDetector(
  //     onTap: () {
  //       Get.to(() => ProfileDetailsMantors());
  //     },
  //     child: Container(
  //       margin: const EdgeInsets.only(bottom: 16),
  //       padding: const EdgeInsets.all(16),
  //       decoration: BoxDecoration(
  //         color: const Color(0xFFe6e8ed),
  //         borderRadius: BorderRadius.circular(32),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // Top Row
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Row(
  //                 children: [
  //                   SizedBox(
  //                     height: 70,
  //                     width: 70,
  //                     child: UIHelper.customImage(img: "user-1.png"),
  //                   ),
  //                   const SizedBox(width: 16),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       UIHelper.boldText(
  //                         text: tutorName,
  //                         fontSize: 14,
  //                         color: AppColors.text,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                       const SizedBox(height: 4),
  //                       Row(
  //                         children: [
  //                           UIHelper.customSvg(svg: "subject-svg.svg"),
  //                           const SizedBox(width: 4),
  //                           UIHelper.boldText(
  //                             text: subject,
  //                             fontSize: 10,
  //                             color: AppColors.textblue,
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   // bottomNavController.changeTab(1); // Redirect to tab index 2
  //                   Get.back();
  //                 },
  //                 child: Container(
  //                   height: 40,
  //                   width: 60,
  //                   decoration: BoxDecoration(
  //                     color: AppColors.text,
  //                     borderRadius: BorderRadius.circular(21),
  //                   ),
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: UIHelper.customSvg(
  //                     svg: "chat-svg-icon.svg",
  //                     color: AppColors.white,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //
  //           const SizedBox(height: 18),
  //
  //           // Date & Time Container
  //           Container(
  //             width: double.infinity,
  //             height: 40,
  //             decoration: BoxDecoration(
  //               color: AppColors.primary1,
  //               borderRadius: BorderRadius.circular(48),
  //             ),
  //             alignment: Alignment.center,
  //             child: UIHelper.boldText(
  //               text: dateTime,
  //               fontSize: 12,
  //               color: AppColors.white,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
        // height: 131,
        width: 158,
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
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: UIHelper.customImage(img: "$imagePath"),
                  ),
                ),

                // Chat Tag
                GestureDetector(
                  onTap: () {
                    // bottomNavController.changeTab(4); // Redirect to tab index 2
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Container(
                      height: 40,
                      // width: 60,
                      decoration: BoxDecoration(
                        color: AppColors.text,
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        child: Row(
                          children: [
                            UIHelper.boldText(
                              text: "\$",
                              fontSize: 14,
                              color: AppColors.primary2,
                            ),
                            UIHelper.boldText(
                              text: "10 / Hr",
                              fontSize: 12,
                              color: AppColors.white,
                            ),
                          ],
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
                        fontSize: 14,
                        color: AppColors.text,
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
