
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/student/learning_page/video_detail_page.dart';

import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

import '../../mentor/course_screen/fun_video/fun_learning.dart';
import '../../mentor/course_screen/upload_course/upload_course_screen.dart';
import '../../mentor/home_screen/search_page/search_screen.dart';
import 'explore_learnig_screen.dart';
import 'my_learning_page.dart';

class StudentLearningPage extends StatefulWidget {
  const StudentLearningPage({super.key});

  @override
  State<StudentLearningPage> createState() => _StudentLearningPageState();
}

class _StudentLearningPageState extends State<StudentLearningPage> {
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
                            fontSize: 24,
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
                            fontSize: 24,
                            color: AppColors.textblue,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UIHelper.boldText(
                        text: "Stay on Learning Path.",
                        fontSize: 16,
                        color: Color(0xff96b4e5),
                        fontWeight: FontWeight.w900,
                      ),
                      UIHelper.customSvg(svg: "arrow-rounded.svg",),
                    ],
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
                          // Get.to(
                          //       () => UploadCourseScreen(),
                          //   arguments: {"mode": "upload"},
                          // );
                         // Get.to(MyLearningPage());
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
                                text: 'My Learnings',
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
                                      onTap: (){},
                                     // onTap: ()=> Get.to(SearchScreen()),
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
              UIHelper.boldText(
                text: "Popular among Students",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
              // corsele slider
              StylishCourseSlider(),


              /// Category Title
              InkWell(
                onTap: () => Get.to(ExploreLearnigScreen(),),
                child: Row(
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

              const SizedBox(height: 32),


              /// Course Categories
              UIHelper.boldText(
                text: "Continue where you left",
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

                        Get.to(() => StudentVideoDetailPage());
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


              UIHelper.boldText(
                text: "Free to Watch",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
              const SizedBox(height: 16),
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

                        Get.to(() => StudentVideoDetailPage());
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

              UIHelper.boldText(
                text: "Newly Added",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
              const SizedBox(height: 16),
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

                        Get.to(() => StudentVideoDetailPage());
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

              UIHelper.boldText(
                text: "Featured Course for Design",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
              const SizedBox(height: 16),
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

                        Get.to(() => StudentVideoDetailPage());
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
            ],
          ),
        ),
      ),
    );
  }
}



class StylishCourseSlider extends StatefulWidget {
  @override
  _StylishCourseSliderState createState() => _StylishCourseSliderState();
}

class _StylishCourseSliderState extends State<StylishCourseSlider> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;

  final List<Map<String, String>> courses = [
    {
      'image': 'https://picsum.photos/id/1015/600/400',
    },
    {
      'image': 'https://picsum.photos/id/1025/600/400',
    },
    {
      'image': 'https://picsum.photos/id/1035/600/400',
    },
  ];


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final width = MediaQuery.of(context).size.width * 0.85 + 16;
    final page = (_scrollController.offset / width).round();
    if (page != _currentPage && page < courses.length) {
      setState(() {
        _currentPage = page;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // No changes to build method
    // Your full existing widget build code goes here (already perfect)
    // Just make sure to replace the PageController with _scrollController
    // in your SingleChildScrollView:
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(courses.length, (index) {
                final isActive = index == _currentPage;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.only(right: 16),
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: isActive ? 160 : 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                    bottomLeft:Radius.circular(32),
                     topRight: Radius.circular(32),
                     bottomRight: Radius.circular(32),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          courses[index]['image']!,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.2),
                                Colors.transparent,
                                Colors.black.withOpacity(0.1),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 22,
                            width: 88,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                courses.length,
                                    (dotIndex) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(horizontal: 3),
                                  width: _currentPage == dotIndex ? 16 : 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: _currentPage == dotIndex
                                        ? Colors.blue
                                        : Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

