

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learning_guru_app/presentation/student/community_page/student_community_page.dart';
import 'package:learning_guru_app/presentation/student/home_screen/student_home_page.dart';
import 'package:learning_guru_app/presentation/student/mentor_page/student_mentor_page.dart';

import '../../core/services/storage_service.dart';
import '../../res/colors/app_color.dart';
import '../../utils/ui_helper.dart';
import '../mentor/chat_screen/chat_page.dart';
import '../mentor/course_screen/course_page.dart';
import '../mentor/home_screen/mentro_home_page.dart';
import '../profile_screen/profile_page.dart';
import '../profile_screen/student_profile_page.dart';
import '../mentor/session_screen/session_page.dart';
import '../student/learning_page/student_learning_page.dart';
import 'no_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final controller = Get.put(BottomNavController());

  // Add at the top of your _BottomNavigationPageState class
  final List<GlobalKey<NavigatorState>> navigatorKeys = List.generate(
    5, // number of tabs (change to match your navItems length)
        (_) => GlobalKey<NavigatorState>(),
  );


  @override
  void initState() {
    super.initState();
    controller.fetchUserRole(); // Fetch the user role from Storage
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      builder: (_) {
        // Wait until the userRole is fetched
        if (controller.userRole.isEmpty) {
          return const Error404Screen();
         // return const Center(child: CircularProgressIndicator());
        }

        // Select correct nav items
        final List<_NavItem> navItems = controller.userRole == 'student'
            ? BottomNavController.studentNavItems
            : BottomNavController.mentorNavItems;

        return WillPopScope(
          // onWillPop: () async => await _showExitConfirmationDialog(context),
          onWillPop: () async {
            final currentNavigator = navigatorKeys[controller.selectedIndex].currentState!;

            // Step 1: If current tab has pages in stack → pop within the tab
            if (currentNavigator.canPop()) {
              currentNavigator.pop();
              return false;
            }

            // Step 2: If user came from another tab → go back to that tab
            if (controller.tabHistory.length > 1) {
              controller.tabHistory.removeLast(); // remove current
              final previousTab = controller.tabHistory.removeLast(); // get previous
              controller.changeTab(previousTab, addToHistory: false);
              return false;
            }

            if (controller.selectedIndex != 0) {
              controller.changeTab(0, addToHistory: false);
              return false;
            }

            // Step 3: If on Home and no history → exit confirmation
            return await _showExitConfirmationDialog(context);
          },

          child: Scaffold(
            backgroundColor: Colors.white,
            // body: controller.pages[controller.selectedIndex],
            body: IndexedStack(
              index: controller.selectedIndex,
              children: List.generate(controller.pages.length, (index) {
                return Navigator(
                  key: navigatorKeys[index],
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (_) => controller.pages[index],
                    );
                  },
                );
              }),
            ),

            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(navItems.length, (index) {
                      final isSelected = index == controller.selectedIndex;
                      final item = navItems[index];

                      return GestureDetector(
                        onTap: () => controller.changeTab(index),
                        child: isSelected
                            ? AnimatedContainer(
                          duration: Duration.zero,
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D0E3C),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                item.selectedIcon,
                                height: 40,
                                width: 40,
                              ),
                              UIHelper.boldTextCenter(
                                text: item.label,
                                fontSize: 14,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                        )
                            : SvgPicture.asset(
                          item.icon,
                          height: 20,
                          width: 20,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Exit App"),
        content: const Text("Are you sure you want to exit the app?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text("Exit"),
          ),
        ],
      ),
    ) ??
        false;
  }
}

class _NavItem {
  final String label;
  final String icon;
  final String selectedIcon;

  const _NavItem(this.label, this.icon, this.selectedIcon);
}

class BottomNavController extends GetxController {
  int selectedIndex = 0;
  String userRole = '';
  List<int> tabHistory = [0]; // start with Home tab in history


  static final List<_NavItem> studentNavItems = [
    _NavItem("Home", "assets/svg/home-svg-icon.svg", "assets/svg/selected-home-svg-icon.svg.svg"),
    _NavItem("Community", "assets/svg/Community.svg", "assets/svg/selected-community-svg.svg"),
    _NavItem("Learning", "assets/svg/learning.svg", "assets/svg/selected-learning-svg.svg"),
    _NavItem("Mentors", "assets/svg/mentors.svg", "assets/svg/selected-mentors-svg.svg"),
    _NavItem("Profile", "assets/svg/profile-svg.svg", "assets/svg/selected-profile-svg-icon.svg"),
  ];

  static final List<_NavItem> mentorNavItems = [
    _NavItem("Home", "assets/svg/home-svg-icon.svg", "assets/svg/selected-home-svg-icon.svg.svg"),
    _NavItem("My Chat", "assets/svg/chat-svg-icon.svg", "assets/svg/selected-chat-svg-icon.svg"),
    _NavItem("My Session", "assets/svg/session-svg-icon.svg", "assets/svg/selected-session-svg-icon.svg"),
    _NavItem("Courses", "assets/svg/course-svg-icon.svg", "assets/svg/selected-coures-svg-icon.svg"),
    _NavItem("Profile", "assets/svg/profile-svg-icon.svg", "assets/svg/selected-profile-svg-icon.svg"),
  ];

  final studentPages = [
    const StudentHomePage(),
    const StudentCommunityPage(), // Community
    const StudentLearningPage(), // Learning
    const StudentMentorPage(), // Mentors
    const StudentProfilePage(),
  ];

  final mentorPages = const [
    HomeScreen(),
    ChatPage(),
    SessionPage(),
    CoursePage(),
    ProfilePage(),
  ];

  List<Widget> get pages =>
      userRole == 'student' ? studentPages : mentorPages;

  Future<void> fetchUserRole() async {
    final role = await StorageService.getUserRole();
    if (role != null && role.isNotEmpty) {
      userRole = role.toLowerCase();
      update();
    } else {
      Get.to(() => Error404Screen());
    }
  }

  // void changeTab(int index) {
  //   selectedIndex = index;
  //   update();
  // }

  void changeTab(int index, {bool addToHistory = true}) {
    selectedIndex = index;
    if (addToHistory && (tabHistory.isEmpty || tabHistory.last != index)) {
      tabHistory.add(index);
    }
    update();
  }

}
