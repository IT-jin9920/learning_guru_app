import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/student/home_screen/my_session/my_sessions_page.dart';
import 'package:learning_guru_app/presentation/student/mentor_page/mentors_search_page.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

import '../../../core/services/user_data.dart';
import '../../../res/colors/app_color.dart';
import '../../app_navigation/bottom_navigation_page.dart';
import '../home_screen/profile_details/profile_details_mantors.dart';
import 'explore_mentor_screen.dart';
import 'mentor_list_page.dart';

class StudentMentorPage extends StatefulWidget {
  const StudentMentorPage({super.key});

  @override
  State<StudentMentorPage> createState() => _StudentMentorPageState();
}

class _StudentMentorPageState extends State<StudentMentorPage> {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            /// Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      /// Image
                      UIHelper.customImage(
                        img: "mentor-student-icon.png",
                        height: 45,
                      ),

                      /// Overlapping Text
                      Transform.translate(
                        offset: const Offset(-18, 0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: UIHelper.boldText(
                            text: 'Mentors that',
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
                            text: 'Crafts!',
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
                        text: "Your Carrier Coaching.",
                        fontSize: 16,
                        color: Color(0xff96b4e5),
                        fontWeight: FontWeight.w900,
                      ),
                      // UIHelper.customSvg(svg: "arrow-rounded.svg"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            /// Upload Course Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRect(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Handle tap
                         // Get.to(() => UploadCourseScreen(),);
Get.to(MySessionsPage());
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
                                text: 'My Sessions',
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

                    InkWell(
                      onTap: ()=> Get.to(MentorsSearchPage()),
                      child: Padding(
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
                                //onTap: ()=> Get.to(SearchScreen()),
                                onTap: () =>   Get.to( MentorsSearchPage(),
                                  arguments: {"title": "Search Mentors"},
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // ProfessionSelector(),
            ProfessionSelector(),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                 children: [
                   /// Category Title
                   InkWell(
                     onTap: () => Get.to(ExploreMentorScreen(),),

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
                   const SizedBox(height: 10),
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
                   const SizedBox(height: 30),


                   // Tutors
                   InkWell(
                     // onTap: () => Get.to(StudentSearchScreen()),
                     onTap: () {
                       Get.to(
                             () => const MentorListPage(),
                         arguments: {"title": "Top Rated Coaches"},
                       );
                     },
                     child: Row(
                       mainAxisAlignment:
                       MainAxisAlignment.spaceBetween,
                       children: [
                         UIHelper.boldText(
                           text: "Top Rated Mentors",
                           fontSize: 18,
                           color: AppColors.text,
                         ),

                         SizedBox(width: 6),
                         Padding(
                           padding: const EdgeInsets.only(right: 5),
                           child: UIHelper.customSvg(
                             svg: "right-arrow-svg-icon.svg",
                           ),
                         ),
                       ],
                     ),
                   ),
                   const SizedBox(height: 10),
                   SingleChildScrollView(
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
                   const SizedBox(height: 30),

                   // Tutors
                   InkWell(
                     // onTap: () => Get.to(StudentSearchScreen()),
                     onTap: () {
                       Get.to(
                             () => const MentorListPage(),
                         arguments: {"title": "Paediatrician Coach"},
                       );
                     },
                     child: Row(
                       mainAxisAlignment:
                       MainAxisAlignment.spaceBetween,
                       children: [
                         UIHelper.boldText(
                           text: "Paediatrician ",
                           fontSize: 18,
                           color: AppColors.text,
                         ),

                         SizedBox(width: 6),
                         Padding(
                           padding: const EdgeInsets.only(right: 5),
                           child: UIHelper.customSvg(
                             svg: "right-arrow-svg-icon.svg",
                           ),
                         ),
                       ],
                     ),
                   ),
                   const SizedBox(height: 10),
                   SingleChildScrollView(
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
                   const SizedBox(height: 30),

                   // Tutors
                   InkWell(
                     // onTap: () => Get.to(StudentSearchScreen()),
                     onTap: () {
                       Get.to(
                             () => const MentorListPage(),
                         arguments: {"title": "Cardiologist Coach"},
                       );
                     },
                     child: Row(
                       mainAxisAlignment:
                       MainAxisAlignment.spaceBetween,
                       children: [
                         UIHelper.boldText(
                           text: "Cardiologist ",
                           fontSize: 18,
                           color: AppColors.text,
                         ),

                         SizedBox(width: 6),
                         Padding(
                           padding: const EdgeInsets.only(right: 5),
                           child: UIHelper.customSvg(
                             svg: "right-arrow-svg-icon.svg",
                           ),
                         ),
                       ],
                     ),
                   ),
                   const SizedBox(height: 10),
                   SingleChildScrollView(
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


class ProfessionSelector extends StatefulWidget {
  const ProfessionSelector({super.key});

  @override
  State<ProfessionSelector> createState() => _ProfessionSelectorState();
}

class _ProfessionSelectorState extends State<ProfessionSelector> {
  int selectedIndex = 0;

  final List<String> options = ["By Profession", "Life Coach"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFD5E2F9), // Light background
        borderRadius: BorderRadius.circular(1),
      ),
      child: Row(
        children: List.generate(options.length, (index) {
          final isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF98B6E4) // Selected blue background
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  options[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected
                        ? const Color(0xFF0A043C) // Dark text
                        : const Color(0xFF5B5E78), // Light text
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}



class TabbedContainer extends StatefulWidget {
  @override
  _TabbedContainerState createState() => _TabbedContainerState();
}

class _TabbedContainerState extends State<TabbedContainer> {
  int _selectedIndex = 0;

  final List<Map<String, String>> courses = [
    {'image': 'https://picsum.photos/id/1015/600/400'},
    {'image': 'https://picsum.photos/id/1025/600/400'},
    {'image': 'https://picsum.photos/id/1035/600/400'},
    {'image': 'https://picsum.photos/id/1045/600/400'},
    {'image': 'https://picsum.photos/id/1055/600/400'},
    {'image': 'https://picsum.photos/id/1065/600/400'},
    {'image': 'https://picsum.photos/id/1075/600/400'},
    {'image': 'https://picsum.photos/id/1085/600/400'},
  ];

  PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab bar
        Container(
          color: Colors.blueGrey,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              _buildTab(0, 'By Profession'),
              SizedBox(width: 16.0),
              _buildTab(1, 'Life Coach'),
            ],
          ),
        ),
        SizedBox(height: 12),

        // Content area
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 180,
                child: PageView.builder(
                  itemCount: courses.length,
                  controller: _controller,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    final isActive = index == _currentPage;

                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: isActive ? 0 : 12),
                      child: Container(
                        height: 160,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                courses[index]['image']!,
                                fit: BoxFit.cover,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 20,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      courses.length,
                                          (dotIndex) => AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        margin: EdgeInsets.symmetric(horizontal: 3),
                                        width: index == dotIndex ? 16 : 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: index == dotIndex ? Colors.blue : Colors.grey.shade400,
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
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 16),
              _getContentWidget(_selectedIndex),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTab(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: _selectedIndex == index ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _getContentWidget(int index) {
    switch (index) {
      case 0:
        return Text('Content for By Profession Tab');
      case 1:
        return Text('Content for Life Coach Tab');
      default:
        return Text('Something went wrong!');
    }
  }
}

