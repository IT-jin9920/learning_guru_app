import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/student/home_screen/profile_details/profile_details_mantors.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

import '../../../../core/services/user_data.dart';
import '../../../../models/tutor_sesstion_model.dart';
import '../../../app_navigation/bottom_navigation_page.dart';

class MySessionsPage extends StatefulWidget {
  const MySessionsPage({super.key});

  @override
  State<MySessionsPage> createState() => _MySessionsPageState();
}

class _MySessionsPageState extends State<MySessionsPage> {
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
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              SizedBox(height: 24,),
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
                        'My Sessions',
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

              // Scrollable Session List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredTutors.length,
                  itemBuilder: (_, index) {
                    final session = filteredTutors[index];
                    return _SessionCard(
                      tutorName: session.name,
                      subject: session.subject,
                      dateTime: session.dateTime,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _SessionCard({
    required String tutorName,
    required String subject,
    required String dateTime,
  }) {
    final BottomNavController bottomNavController = Get.find<BottomNavController>();

    return GestureDetector(
      onTap: () {
        Get.to(() => ProfileDetailsMantors());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFe6e8ed),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: UIHelper.customImage(img: "user-1.png"),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UIHelper.boldText(
                          text: tutorName,
                          fontSize: 14,
                          color: AppColors.text,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            UIHelper.customSvg(svg: "subject-svg.svg",width: 20, height: 20),
                            const SizedBox(width: 4),
                            UIHelper.boldText(
                              text: subject,
                              fontSize: 10,
                              color: AppColors.textblue,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                   // bottomNavController.changeTab(1); // Redirect to tab index 2
                  Get.back();
                  },
                  child: Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppColors.text,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: UIHelper.customSvg(
                      svg: "chat-svg-icon.svg",
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Date & Time Container
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary1,
                borderRadius: BorderRadius.circular(48),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UIHelper.customSvg(svg: "calander-svg-icon.svg", height: 20, width: 20, color: AppColors.white),
                 SizedBox(width: 8,),
                  UIHelper.boldText(
                    text: dateTime,
                    fontSize: 12,
                    color: AppColors.white,
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
