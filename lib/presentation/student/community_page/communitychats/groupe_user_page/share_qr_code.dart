import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../res/colors/app_color.dart';
import '../../../../../utils/ui_helper.dart';
import '../../../../../widgets/base_button.dart';

class ShareQrCode extends StatefulWidget {
  const ShareQrCode({super.key});

  @override
  State<ShareQrCode> createState() => _ShareQrCodeState();
}

class _ShareQrCodeState extends State<ShareQrCode> {
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: const Color(0xFFeaf2ff),
          body: Stack(
            children: [
              Positioned(right: 0, top: -35, child: _buildDecorativeBackground()),

              /// Top AppBar
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
                      const Text(
                        'Share QR Code',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                     // const SizedBox(width: 40), // To balance alignment
                    ],
                  ),
                ),
              ),

              /// Content Area
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
                        const SizedBox(height: 20),

                        /// Search Bar
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
                                    borderRadius: BorderRadius.circular(45),
                                    border: Border.all(
                                      color: const Color(0xFFCDDCF4),
                                      width: 1.5,
                                    ),
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
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

                        const SizedBox(height: 24),

                        /// Students Header
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: UIHelper.boldText(
                                text: "Students",
                                fontSize: 18,
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        /// Group List with Checkbox
                        Expanded(
                          child: Obx(
                                () => ListView.separated(
                              padding: EdgeInsets.zero,
                              itemCount: filteredGroups.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 4),
                              itemBuilder: (context, index) {
                                final group = filteredGroups[index];
                                return Obx(() {
                                  final isAdded = addedGroups.contains(group);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: ListTile(
                                      dense: true,
                                      visualDensity: VisualDensity.compact,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.blue[100],
                                        radius: 22,
                                        child: UIHelper.customImage(img: "c-1.png"),
                                      ),
                                      title: Text(
                                        group,
                                        style: const TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                      trailing: Checkbox(
                                        value: isAdded,
                                        onChanged: (_) => toggleGroup(group),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                        activeColor: AppColors.text,
                                      ),
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
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
                text: "Share",
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
      UIHelper.customSvg(svg: "bg.svg", fit: BoxFit.cover),
    ],
  );
}
