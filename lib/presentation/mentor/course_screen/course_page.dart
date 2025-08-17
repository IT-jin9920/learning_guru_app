import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/mentor/course_screen/upload_course/upload_course_screen.dart';

import '../../../res/colors/app_color.dart';

import '../../../utils/ui_helper.dart';

import '../home_screen/search_page/search_screen.dart';
import 'fun_video/fun_learning.dart';
import 'video_detail_page.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  int selectedIndex = 0;

  final categories = [
    'Business',
    'Design',
    'Development',
    'Marketing',
    'Science',
    'AI',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              /// Header Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      /// Image
                      UIHelper.customImage(
                        img: "course-book-icon.png",
                        height: 45,
                      ),

                      /// Overlapping Text
                      Transform.translate(
                        offset: const Offset(-18, 0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: UIHelper.boldText(
                            text: 'Learning that',
                            fontSize: 23,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      //SizedBox(width: 5),
                      Transform.translate(
                        offset: const Offset(-13, 0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: UIHelper.boldText(
                            text: 'Grows!',
                            fontSize: 23,
                            color: AppColors.textblue,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),
                  UIHelper.boldText(
                    text: "Make People Learn!",
                    fontSize: 16,
                    color: Color(0xff96b4e5),
                    fontWeight: FontWeight.w900,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// Upload Course Button
              ClipRect(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Handle tap
                          Get.to(
                            () => UploadCourseScreen(),
                            arguments: {"mode": "upload"},
                          );
                        },
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.textblue,
                            borderRadius: BorderRadius.circular(46),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UIHelper.boldText(
                                text: 'Upload Course',
                                fontSize: 14,
                                color: AppColors.white,
                              ),
                              UIHelper.customSvg(
                                svg: 'doubal-right-arrow-svg-icon.svg',
                                height: 20,
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFFCDDCF4),
                        borderRadius: BorderRadius.circular(46),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            UIHelper.customImageOnTap(
                              png: "smile-png.png",
                              height: 40,
                              width: 40,
                              onTap: () {
                                Get.to(() => LearnWithFunPage());
                              },
                            ),
                            const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF03002F),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: UIHelper.customSvgOnTap(
                                      svg: "serch-icon-svg.svg",
                                      onTap: ()=> Get.to(SearchScreen()),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              /// Course Categories
              /// Recent Uploads Title
              UIHelper.boldText(
                text: "Recent Uploads",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),

              const SizedBox(height: 16),

              /// Recent Uploads Horizontal List
              SizedBox(
                height: 220,
                //width: 230,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  //padding: const EdgeInsets.symmetric(horizontal: 16),
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print("Tapped index Recent Uploads: $index");

                        Get.to(() => VideoDetailPage());
                      },
                      child: Container(
                        width: 220,
                        decoration: BoxDecoration(
                          color: const Color(0xffE0E2E9),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        clipBehavior: Clip.antiAlias,
                        // Important for child clipping
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.asset(
                                "assets/images/img-3.png",
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.text,
                                            borderRadius: BorderRadius.circular(
                                              53,
                                            ),
                                          ),
                                          child: UIHelper.boldText(
                                            text: "Design",
                                            fontSize: 10,
                                            color: AppColors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        UIHelper.mediumText(
                                          text: "8 Lessons",
                                          fontSize: 10,
                                          color: AppColors.primary1,
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 14),
                                    Flexible(
                                      child: UIHelper.boldText(
                                        text: "Digital Poster Design: Combining Images & Type..",
                                        fontSize: 14,
                                        color: AppColors.text,
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
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
                  },
                ),
              ),

              const SizedBox(height: 40),

              /// Category Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UIHelper.boldText(
                    text: "Categories",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: UIHelper.customSvg(svg: "right-arrow-svg-icon.svg"),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Category Chips
              SizedBox(
                height: 42,
                child: ListView.separated(
                 // padding: const EdgeInsets.symmetric(horizontal: 12), // Prevent edge clipping
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 2),
                  itemBuilder: (context, index) {
                    final bool isSelected = index == selectedIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        print('Tapped index: $index - ${categories[index]}');
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.textblue : Colors.transparent,
                          border: Border.all(color: AppColors.textblue),
                          borderRadius: BorderRadius.circular(46),
                        ),
                        child: Center(
                          child: UIHelper.mediumText(
                            text: categories[index],
                            fontSize: 13,
                            color: isSelected ? AppColors.white : AppColors.primary1,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              /// Recent Course Cards
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("Tapped index: $index");

                      Get.to(() => VideoDetailPage());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xfff0f4fd),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            child: Image.asset(
                              "assets/images/cours_imag_thum.png",
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.text,
                                        borderRadius: BorderRadius.circular(53),
                                      ),
                                      child: UIHelper.boldText(
                                        text: "Business",
                                        fontSize: 12,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    Row(
                                      children:  [
                                        // Icon(
                                        //   Icons.star,
                                        //   size: 16,
                                        //   color: AppColors.primary1,
                                        // ),
                                        UIHelper.customSvg(svg: "star-svg-icon.svg",color: AppColors.primary1, width: 16,height: 16),
                                        SizedBox(width: 4),
                                        Text(
                                          "4.2",
                                          style: TextStyle(
                                            color: AppColors.primary1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                UIHelper.boldText(
                                  text:
                                      "The Core Structure of the 3D Design & Motion",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AppColors.text,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                               // const SizedBox(height: 8),
                                UIHelper.mediumText(
                                  text: "Published on: 18th Mar 2024",
                                  fontSize: 12,
                                  color: AppColors.grey,
                                ),
                                const SizedBox(height: 8),

                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 4), // Smaller space below
                                      child: UIHelper.boldText( // Use mediumText instead of boldText
                                        text: "\$80",
                                        fontSize: 12,
                                        color: AppColors.textblue,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 4), // Smaller space below
                                      child: UIHelper.regularText( // Use mediumText instead of boldText
                                        text: ".00",
                                        fontSize: 12,
                                        color: AppColors.textblue,
                                      ),
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
