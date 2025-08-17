import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/student/community_page/chat_details_page/chat_user_profile/grope_details/grope_details_page.dart';
import '../../../../../res/colors/app_color.dart';
import '../../../../../utils/ui_helper.dart';
import '../../../../../widgets/base_button.dart';

class CreateGrop extends StatefulWidget {
  const CreateGrop({super.key});

  @override
  State<CreateGrop> createState() => _CreateGropState();
}

class _CreateGropState extends State<CreateGrop> {
  final RxString groupName = "Group Name".obs;
  final RxBool isEditingGroupName = false.obs;
  final TextEditingController groupNameController = TextEditingController();

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
  ].obs;

  final RxList<String> filteredGroups = <String>[].obs;
  final RxList<String> addedGroups = <String>[].obs;

  @override
  void initState() {
    super.initState();
    filteredGroups.assignAll(allGroups);
    groupNameController.text = groupName.value;
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
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xffEAF2FF),
        body: Stack(
          children: [
            Positioned(right: 0, top: -35, child: _buildDecorativeBackground()),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => CustomAppBarRow(
                      isEditing: isEditingGroupName.value,
                      controller: groupNameController,
                      onEditTap: () {
                        isEditingGroupName.value = true;
                      },
                      onEditComplete: () {
                        groupName.value = groupNameController.text.trim();
                        isEditingGroupName.value = false;
                      },
                      groupName: groupName.value,
                      imageUrl: "https://picsum.photos/200",
                    ),
                  ),
                  const SizedBox(height: 10),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                          child: UIHelper.customSvg(
                                            svg: "serch-icon-svg.svg",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
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
                            Row(
                              children: [
                                UIHelper.boldText(
                                  text: "Students",
                                  fontSize: 18,
                                  color: AppColors.text,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Obx(
                              () => Expanded(
                                child: ListView.separated(
                                  itemCount: filteredGroups.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 10),
                                  itemBuilder: (context, index) {
                                    final group = filteredGroups[index];
                                    return Obx(() {
                                      final isAdded = addedGroups.contains(
                                        group,
                                      );
                                      return ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 4,
                                            ),
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.blue[100],
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
                                          onTap: () => toggleGroup(group),
                                          child: UIHelper.customSvg(
                                            svg: isAdded
                                                ? "grp-remove.svg"
                                                : "grp-add-icon.svg",
                                          ),
                                        ),
                                        onTap: () => Get.to(
                                          () => GroupDetailsPage(
                                            groupIndex: index + 1,
                                          ),
                                        ),
                                      );
                                    });
                                  },
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
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
            child: GradientButton(
              text: "Create Group",
              onTap: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDecorativeBackground() {
    return Stack(
      children: [UIHelper.customSvg(svg: "bg.svg", fit: BoxFit.cover)],
    );
  }
}

class CustomAppBarRow extends StatelessWidget {
  final bool isEditing;
  final TextEditingController controller;
  final VoidCallback? onEditTap;
  final VoidCallback? onEditComplete;
  final String groupName;
  final String imageUrl;

  const CustomAppBarRow({
    super.key,
    required this.isEditing,
    required this.controller,
    this.onEditTap,
    this.onEditComplete,
    required this.groupName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                  child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
                ),
              ),
              const Text(
                'Create Group',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: isEditing
                    ? TextField(
                        controller: controller,
                        autofocus: true,
                        onSubmitted: (_) => onEditComplete?.call(),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter group name',
                          isDense: true,
                        ),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF1A73E8),
                        ),
                      )
                    : GestureDetector(
                        onTap: onEditTap,
                        child: Text(
                          groupName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF1A73E8),
                          ),
                        ),
                      ),
              ),
              UIHelper.customNetworkImage(
                imageUrl: imageUrl,
                height: 100,
                width: 100,
                isCircular: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
