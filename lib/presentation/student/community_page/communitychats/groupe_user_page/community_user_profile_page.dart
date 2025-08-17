import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learning_guru_app/presentation/student/community_page/chat_details_page/chat_user_profile/grope_details/grope_details_page.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

import '../../../../../core/services/storage_service.dart';
import '../create_gropes/create_grop.dart';
import 'add_member.dart';
import 'community_chat_user_profile_appba.dart';
import 'shared_media.dart';

class CommunityUserProfilePage extends StatefulWidget {
  final String username;
  final String member;
  final String imageUrl;

  const CommunityUserProfilePage({
    super.key,
    required this.username,
    required this.member,
    required this.imageUrl,
  });

  @override
  State<CommunityUserProfilePage> createState() =>
      _CommunityUserProfilePageState();
}

class _CommunityUserProfilePageState extends State<CommunityUserProfilePage> {
  Future<List<String>> fetchPicsumImages() async {
    final response = await http.get(
      Uri.parse('https://picsum.photos/v2/list?page=2&limit=10'),
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data
          .map<String>((item) => item['download_url'] as String)
          .toList();
    } else {
      throw Exception('Failed to load images');
    }
  }

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
    "Chem Champs",
    "Tech Titans",
  ].obs;

  final List<int> memberCounts = List.generate(12, (index) => 50 + index * 5);

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  void _fetchUserRole() async {
    final role = await StorageService.getUserRole();
    print("User role from StorageService: $role");

    if (role != null && role.isNotEmpty) {
      setState(() {
        userRole = role; // This triggers UI rebuild
      });
    }
  }

  String userRole = ''; // Example: "Mentor", "Teacher", etc.

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
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  CommunityChatUserProfileAppba(
                    username: widget.username,
                    member: widget.member,
                    imageUrl: widget.imageUrl,
                  ),
                  const SizedBox(height: 10),
                  Container(
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
                          GestureDetector(
                            onTap: () {
                              Get.to(SharedMedia());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Shared Media",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(width: 6),
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
                          Container(
                            height: 128,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6E8ED),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: FutureBuilder<List<String>>(
                                future: fetchPicsumImages(),
                                builder: (context, snapshot) {
                                  final images = snapshot.data ?? [];
                                  return ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    itemCount: images.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 10),
                                    itemBuilder: (context, index) {
                                      final imageUrl = images[index];
                                      return Container(
                                        height: 100,
                                        width: 85,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                          loadingBuilder:
                                              (
                                                context,
                                                child,
                                                loadingProgress,
                                              ) {
                                                if (loadingProgress == null)
                                                  return child;
                                                double? progress;
                                                if (loadingProgress
                                                        .expectedTotalBytes !=
                                                    null) {
                                                  progress =
                                                      loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!;
                                                }
                                                return Container(
                                                  color: progress == null
                                                      ? Colors.grey[300]
                                                      : Color.lerp(
                                                          Colors.grey[300],
                                                          Colors.blue,
                                                          progress,
                                                        ),
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          value: progress,
                                                          color:
                                                              Colors.blueAccent,
                                                          strokeWidth: 2,
                                                        ),
                                                  ),
                                                );
                                              },
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                                    color: Colors.grey[300],
                                                    child: const Icon(
                                                      Icons.broken_image,
                                                    ),
                                                  ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UIHelper.boldText(
                                text: "Group Members",
                                fontSize: 18,
                                color: AppColors.text,
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  Get.to(AddMember());
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary1,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: UIHelper.customSvg(
                                      svg: "grp-add-icon.svg",
                                      height: 18,
                                      width: 18,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // ListView.separated(
                          //   itemCount: 12,
                          //   shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          //   separatorBuilder: (context, index) =>
                          //       const SizedBox(height: 10),
                          //   itemBuilder: (context, index) {
                          //     return ListTile(
                          //       contentPadding: const EdgeInsets.symmetric(
                          //         horizontal: 4,
                          //       ),
                          //       leading: CircleAvatar(
                          //         backgroundColor: Colors.blue[100],
                          //         radius: 22,
                          //         child: UIHelper.customImage(img: "c-1.png"),
                          //       ),
                          //       title: const Text(
                          //         "Mathematic Heads",
                          //         style: TextStyle(fontWeight: FontWeight.w600),
                          //       ),
                          //       subtitle: Row(
                          //         children: [
                          //           UIHelper.customSvg(
                          //             svg: "member-add-icon.svg",
                          //           ),
                          //           const SizedBox(width: 8),
                          //           Container(
                          //             height: 8,
                          //             width: 1,
                          //             color: AppColors.textblue,
                          //           ),
                          //           const SizedBox(width: 8),
                          //           const Text("80 Members"),
                          //         ],
                          //       ),
                          //       trailing: GestureDetector(
                          //         onTap: () {
                          //           debugPrint(
                          //             "Remove icon tapped at index $index",
                          //           );
                          //         },
                          //         child: UIHelper.customSvg(
                          //           svg: "remove-gp-icon.svg",
                          //         ),
                          //       ),
                          //       onTap: () {
                          //         Get.to(
                          //           () =>
                          //               GroupDetailsPage(groupIndex: index + 1),
                          //         );
                          //       },
                          //     );
                          //   },
                          // ),
                          ListView.separated(
                            itemCount: allGroups.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue[100],
                                  radius: 22,
                                  child: UIHelper.customImage(
                                    img: "c-${(index % 5) + 1}.png",
                                  ), // rotating images
                                ),
                                title: Text(
                                  allGroups[index],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    UIHelper.customSvg(
                                      svg: "member-add-icon.svg",
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      height: 8,
                                      width: 1,
                                      color: AppColors.textblue,
                                    ),
                                    const SizedBox(width: 8),
                                    Text("${memberCounts[index]} Members"),
                                  ],
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    // Remove from filtered list if it's being displayed
                                    allGroups.removeAt(index);

                                    debugPrint("Group removed at index $index");
                                  },
                                  child: UIHelper.customSvg(
                                    svg: "remove-gp-icon.svg",
                                  ),
                                ),

                                onTap: () {
                                  Get.to(
                                    () =>
                                        GroupDetailsPage(groupIndex: index + 1),
                                  );
                                },
                              );
                            },
                          ),
                          const Divider(thickness: 1.2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "See all Members",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: UIHelper.customSvg(
                                  svg: "right-arrow-svg-icon.svg",
                                ),
                              ),
                            ],
                          ),
                          const Divider(thickness: 1.2),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: userRole == 'student'
            ? Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 21,
                ),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E2E9),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: const Color(0xFFE0E2E9),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 24),
                      Text(
                        "Delete Group",
                        style: TextStyle(
                          color: AppColors.textblue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 60,
                        width: 80,
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: UIHelper.customSvgOnTap(
                            svg: "dlt-svg-icon.svg",
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildDecorativeBackground() {
    return Stack(
      children: [UIHelper.customSvg(svg: "bg.svg", fit: BoxFit.cover)],
    );
  }
}
