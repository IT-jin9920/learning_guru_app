import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../res/constants/constants.dart';
import '../../../../utils/ui_helper.dart';
import '../../../app_navigation/bottom_navigation_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int selectedTabIndex = 0;

  final List<String> tabs = ["Community", "Sessions", "Courses"];
  final List<String> icons = ["Community.svg", "Sessions.svg", "Courses.svg"];

  final TextEditingController _searchController = TextEditingController();
  String searchText = "";

  final List<String> sampleCommunity = [
    "Mathematic Heads",
    "Maths todo",
    "Coding Ninjas",
    "Flutter Devs",
    "Code Warriors",
    "Dev Dudes",
    "Tech Titans",
    "UI Wizards",
    "Algo Ninjas",
    "Python Pirates",
    "React Squad",
    "Bug Bashers",
    "JS Junkies",
    "Dart Masters",
    "API Hunters",
    "Stack Hackers",
    "Design Geeks",
    "Data Crunchers",
    "Binary Bros",
    "AI Explorers",
    "Hackathon Heroes",
    "Logic Lords",
    "Debugging Demons",
    "Android Addicts",
  ];

  final List<String> sampleSessions = [
    "Algebra Basics",
    "Geometry Class",
    "Live Q&A on Flutter",
    "Mock Interview Session",
  ];

  final List<String> sampleCourses = [
    "Complete Flutter Course",
    "Data Structures in Dart",
    "UI/UX for Developers",
    "Advanced Mathematics",
  ];

  List<String> get filteredCommunity => _filterList(sampleCommunity);

  List<String> get filteredSessions => _filterList(sampleSessions);

  List<String> get filteredCourses => _filterList(sampleCourses);

  List<String> _filterList(List<String> list) {
    if (searchText.isEmpty) return list;
    return list
        .where((item) => item.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  // List<String> get filteredCommunity {
  //   if (searchText.isEmpty) return sampleCommunity;
  //   return sampleCommunity
  //       .where((item) => item.toLowerCase().contains(searchText.toLowerCase()))
  //       .toList();
  // }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeaf2ff),
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   toolbarHeight: 70,
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 16),
      //     child: GestureDetector(
      //       onTap: () => Navigator.pop(context),
      //       child: Container(
      //         height: 40,
      //         width: 40,
      //         decoration: const BoxDecoration(
      //           color: Color(0xFFCEDBF1),
      //           shape: BoxShape.circle,
      //         ),
      //         padding: const EdgeInsets.all(8),
      //         child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
      //       ),
      //     ),
      //   ),
      //   title: const Padding(
      //     padding: EdgeInsets.only(right: 16),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: [
      //         Text(
      //           'Search Bar',
      //           style: TextStyle(
      //             fontSize: 20,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.black,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      //   centerTitle: false,
      // ),
      body: Stack(
        children: [
          //_buildDecorativeBackground(),
          /// 🎨 Background Layer
          Positioned(right: 0, top: -35, child: _buildDecorativeBackground()),

          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                  Center(
                    child: Text(
                      'Search Bar',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Right space filler to align center properly
                  // const SizedBox(width: 40),
                ],
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 70,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _buildSearchBar(),
                  const SizedBox(height: 24),
                  _buildTabs(),
                  const SizedBox(height: 8),
                  _buildUnderline(),
                  //const SizedBox(height: 16),
                  Expanded(child: _buildTabContent()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeBackground() => Stack(
    children: [
      // UIHelper.customSvg(svg: "bg.svg"),
      UIHelper.customSvg(svg: "bg.svg", fit: BoxFit.cover),
    ],
  );

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFCDDCF4),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
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
                  child: UIHelper.customSvg(svg: "serch-icon-svg.svg"),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  searchText = val;
                });
                print("User typed: $val");
              },
              style: const TextStyle(
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                hintText: "Search for Community, Chats, Courses..",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xffa5a4b5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(tabs.length, (index) {
        return GestureDetector(
          onTap: () => setState(() => selectedTabIndex = index),
          child: _buildTab(
            tabs[index], // label
            selectedTabIndex == index, // selected
            icons[index], // icon
            selectedTabIndex, // pass current selectedTabIndex
          ),
        );
      }),
    );
  }

  Widget _buildTab(
    String label,
    bool selected,
    String icon,
    int selectedTabIndex,
  ) {
    double extraSpacing = 0;

    // Dynamically set spacing based on selected tab index
    if (selectedTabIndex == 0) {
      extraSpacing = 10;
    } else if (selectedTabIndex == 1) {
      extraSpacing = 20;
    } else if (selectedTabIndex == 2) {
      extraSpacing = 30;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // SizedBox(width: extraSpacing), // Dynamic spacing
        SizedBox(
          height: 18,
          width: 18,
          child: UIHelper.customSvg(
            svg: icon,
            color: selected ? AppColors.primary1 : Colors.grey,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selected ? Colors.black : Colors.grey,
          ),
        ),
        SizedBox(width: extraSpacing),
      ],
    );
  }

  Widget _buildUnderline() {
    return Stack(
      children: [
        Container(height: 2, width: double.infinity),
        AnimatedAlign(
          alignment: Alignment(
            -1 + (selectedTabIndex * (2 / (tabs.length - 1))),
            0,
          ),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            height: 2,
            width: MediaQuery.of(context).size.width / tabs.length - 32,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent() {
    if (selectedTabIndex == 0) {
      return _buildListCommunity(filteredCommunity, "assets/images/user-1.png");
    } else if (selectedTabIndex == 1) {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: _buildListSessions(filteredSessions, "assets/images/user-1.png"),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: _buildListCourses(filteredCourses),
      );
    }
  }

  Widget _buildListCommunity(List<String> items, String imagePath) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        return _chatItem(
          imagePath: imagePath,
          name: items[index],
          message: "Last message here...",
          time: "10:${index + 10} AM",
          showNotification: index == 0,
        );
      },
    );
  }

  Widget _buildListSessions(List<String> items, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        itemCount: (items.length / 2).ceil(),
        itemBuilder: (context, index) {
          final firstIndex = index * 2;
          final secondIndex = firstIndex + 1;

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: _buildUserCard(
                    name: items[firstIndex],
                    date: '11th Nov, 10:00 AM',
                    imagePath: 'user-1.png',
                  ),
                ),
                const SizedBox(width: 11),
                if (secondIndex < items.length)
                  Expanded(
                    child: _buildUserCard(
                      name: items[secondIndex],
                      date: '12th Nov, 12:00 PM',
                      imagePath: 'user-2.png',
                    ),
                  )
                else
                  const Spacer(), // keep alignment if odd count
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserCard({
    required String name,
    required String date,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: () {
        final bottomNavController = Get.find<BottomNavController>();
        bottomNavController.changeTab(4);
        Get.back();
        print("Tap on user card");
      },
      child: Container(
        height: 135,
        decoration: BoxDecoration(
          color: const Color(0xFFe6e8ed),
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Avatar and Chat
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: UIHelper.customImage(img: imagePath),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final bottomNavController = Get.find<BottomNavController>();
                    bottomNavController.changeTab(1);
                    Get.back();
                    print("Tap chat icon");
                  },
                  child: Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppColors.text,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: UIHelper.customSvg(
                      svg: "chat-svg-icon.svg",
                      color: AppColors.white,
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
                  UIHelper.boldText(
                    text: name,
                    fontSize: 14,
                    color: AppColors.text,
                  ),
                  const SizedBox(height: 2),
                  Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UIHelper.mediumText(
                        text: "11th Nov,",
                        fontSize: 11,
                        color: AppColors.textblue,
                      ),
                      SizedBox(width: 4,),
                      UIHelper.mediumText(
                        text: "10:00 AM",
                        fontSize: 11,
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

  Widget _buildListCourses(List<String> items) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        // Sample mapping logic (you can customize this as needed)
        final title = items[index];
        final author = 'Author ${index + 1}';
        final category = [
          'Business',
          'Design',
          'Programming',
          'Photography',
          'Teaching',
        ][index % 5];
        final rating = 4.0 + (index % 5) * 0.2;

        return buildCourseCard(
          image: 'assets/images/cours_imag_thum.png',
          category: category,
          title: title,
          author: author,
          rating: rating,
        );
      },
    );
  }

  Widget _chatItem({
    required String imagePath,
    required String name,
    required String message,
    required String time,
    bool showNotification = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align children to start
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Stack(
            children: [
              CircleAvatar(radius: 28, backgroundImage: AssetImage(imagePath)),
              if (showNotification)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: const Center(
                      child: Text(
                        "1",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: showNotification ? AppColors.primary1 : Colors.grey,
            ),
          ),
          trailing: Text(
            time,
            style: const TextStyle(fontSize: 12, color: Color(0xffacabba)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 90.0, right: 16.0),
          child: Container(height: 1, color: Color(0xffCDDCF4)),
        ),
      ],
    );
  }

  Widget buildCourseCard({
    required String image,
    required String category,
    required String title,
    required String author,
    required double rating,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16), // spacing between cards
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4FA),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: Image.asset(
              image,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Info section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Category + Rating Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.blue, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 6),

                /// Author
                Text(
                  'by: $author',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
