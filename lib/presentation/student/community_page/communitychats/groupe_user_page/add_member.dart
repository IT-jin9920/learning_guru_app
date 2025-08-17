import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/widgets/base_button.dart';

import '../../../../../res/colors/app_color.dart';
import '../../../../../utils/ui_helper.dart';
import '../../chat_details_page/chat_user_profile/grope_details/grope_details_page.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final RxList<String> allGroups = [
    "Science Wizards",
    "Math Warriors",
    "Literature Legends",
    "Code Ninjas",
    "Physics Pioneers",
    "History Buffs",
    "Bio Squad",
    "Art Attack",
    "Geo Gurus",
    "Language Lovers",
    "Math Warriors",
    "Literature Legends",
    "Code Ninjas",
    "Physics Pioneers",
    "History Buffs",
    "Bio Squad",
    "Art Attack",
    "Math Warriors",
    "Literature Legends",
    "Code Ninjas",
    "Physics Pioneers",
    "History Buffs",
    "Bio Squad",
    "Art Attack",
  ].obs;

  final RxList<String> filteredGroups = <String>[].obs;

  final RxList<String> addedGroups = <String>[].obs;

  @override
  void initState() {
    super.initState();
    filteredGroups.assignAll(allGroups);
  }

  void filterChats(String query) {
    filteredGroups.assignAll(
      allGroups.where((g) => g.toLowerCase().contains(query.toLowerCase())),
    );
  }

  void toggleGroup(String group) {
    if (addedGroups.contains(group)) {
      addedGroups.remove(group);
    } else {
      addedGroups.add(group);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: const Color(0xFFeaf2ff),

          // extendBodyBehindAppBar: true,
          //  appBar: AppBar(
          //   //backgroundColor: Colors.transparent,
          //    elevation: 0,
          //    toolbarHeight: 70,
          //    leading: Padding(
          //      padding: const EdgeInsets.only(left: 16),
          //      child: GestureDetector(
          //        onTap: () {
          //          // Get.back();
          //          Navigator.pop(context);
          //        },
          //        child: Container(
          //          height: 40,
          //          width: 40,
          //          decoration: const BoxDecoration(
          //            color: Color(0xFFCEDBF1),
          //            shape: BoxShape.circle,
          //          ),
          //          padding: const EdgeInsets.all(8),
          //          child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
          //        ),
          //      ),
          //    ),
          //
          //    // 👇 Align title to right using a Row
          //    title: Padding(
          //      padding: const EdgeInsets.only(right: 16),
          //      child: Row(
          //        mainAxisAlignment: MainAxisAlignment.end, // Aligns to the right
          //        children: const [
          //          Text(
          //            'Notifications',
          //            style: TextStyle(
          //              fontSize: 20,
          //              fontWeight: FontWeight.bold,
          //              color: Colors.black,
          //            ),
          //          ),
          //        ],
          //      ),
          //    ),
          //
          //    // centerTitle: true is removed or should be false
          //    centerTitle: false,
          //  ),
          body: Stack(
            children: [
              // _buildDecorativeBackground(),
              // Positioned(
              //   top: -100,
              //   left: -100,
              //   child: Opacity(
              //     opacity: 0.08,
              //     child: _circle(300, Colors.blue.shade100),
              //   ),
              // ),
              // Positioned(
              //   top: 80,
              //   right: -50,
              //   child: Opacity(
              //     opacity: 0.08,
              //     child: _circle(200, Colors.purple.shade100),
              //   ),
              // ),
              // SafeArea(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: const BorderRadius.only(
              //         topLeft: Radius.circular(40),
              //         topRight: Radius.circular(40),
              //       ),
              //     ),
              //     child: Column(
              //       children: [
              //         Expanded(
              //           child: ListView(
              //             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              //             children: notifications.map((notif) {
              //               return Column(
              //                 children: [
              //                   NotificationCard(
              //                     svg: notif['svg']!,
              //                     title: notif['title']!,
              //                     description: notif['description']!,
              //                     time: notif['time']!,
              //                   ),
              //                   const SizedBox(height: 12),
              //                 ],
              //               );
              //             }).toList(),
              //           ),
              //         ),
              //
              //         if (notifications.isNotEmpty)
              //           Padding(
              //             padding: const EdgeInsets.symmetric(vertical: 16),
              //             child: _buildClearAllButton(),
              //           ),
              //        // Padding(
              //        //    padding: const EdgeInsets.symmetric(vertical: 16),
              //        //    child: _buildClearAllButton(),
              //        //  ),
              //       ],
              //     ),
              //   ),
              // ),

              /// 🎨 Background Layer
              Positioned(
                right: 0,
                top: -35,
                child: _buildDecorativeBackground(),
              ),

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
                          child: UIHelper.customSvg(
                            svg: "back-arrow-icon-svg.svg",
                          ),
                        ),
                      ),

                      // Title
                      Center(
                        child: Text(
                          'Add Member',
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

              /// 📃 Content Area
              Positioned(
                top: MediaQuery.of(context).padding.top + 70,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(32),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFCDDCF4),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: TextField(
                                      onChanged: filterChats,
                                      style: const TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: AppColors.text,
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                              border: Border.all(
                                                color: const Color(0xFFCDDCF4),
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
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                        hintText: "Search for Groups & Chats",
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                          fontFamily: 'BeVietnamPro',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Color(0xff7c84a5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        UIHelper.boldText(
                                          text: "Students",
                                          fontSize: 18,
                                          color: AppColors.text,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Expanded(
                                    child: Obx(
                                      () => ListView.separated(
                                        padding: EdgeInsets.zero,
                                        // ✅ Remove top/bottom padding
                                        itemCount: filteredGroups.length,
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(height: 4),
                                        // Fixed vertical spacing
                                        itemBuilder: (context, index) {
                                          final group = filteredGroups[index];

                                          return Obx(() {
                                            final isAdded = addedGroups
                                                .contains(group);
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 4,
                                                  ),
                                              // Optional smaller spacing
                                              child: ListTile(
                                                dense: true,
                                                visualDensity:
                                                    VisualDensity.compact,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                    ),
                                                leading: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.blue[100],
                                                  radius: 22,
                                                  child: UIHelper.customImage(
                                                    img: "c-1.png",
                                                  ),
                                                ),
                                                title: Text(
                                                  group,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                trailing: GestureDetector(
                                                  onTap: () =>
                                                      toggleGroup(group),
                                                  child: UIHelper.customSvg(
                                                    svg: isAdded
                                                        ? "grp-remove.svg"
                                                        : "grp-add-icon.svg",
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 24),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 18),
              child: GradientButton(
                text: "Add Members",
                onTap: () {
                  Get.back();
                },
              ),
            ),
          ),
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
}
