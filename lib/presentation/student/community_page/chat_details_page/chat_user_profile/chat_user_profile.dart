import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learning_guru_app/presentation/student/community_page/chat_details_page/chat_user_profile/grope_details/grope_details_page.dart' hide CustomAppBarRow;

import '../../../../../res/colors/app_color.dart';
import '../../../../../utils/ui_helper.dart';
import '../../communitychats/create_gropes/create_grop.dart' show CreateGrop;
import '../../communitychats/groupe_user_page/shared_media.dart';
import 'chat_user_profile_appba.dart';

class ChatUserProfilePage extends StatelessWidget {
  final String username;
  final String className;
  final String rollNumber;
  final String imageUrl;

  const ChatUserProfilePage({
    super.key,
    required this.username,
    required this.className,
    required this.rollNumber,
    required this.imageUrl,
  });

  Future<List<String>> fetchPicsumImages() async {
    final response = await http.get(Uri.parse('https://picsum.photos/v2/list?page=2&limit=10'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map<String>((item) => item['download_url'] as String).toList();
    } else {
      throw Exception('Failed to load images');
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
                  CustomAppBarRow(
                    username: username,
                    className: className,
                    rollNumber: rollNumber,
                    imageUrl: imageUrl,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: (){
                                Get.to(SharedMedia());
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Shared Media",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
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
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                      itemCount: images.length,
                                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                                      itemBuilder: (context, index) {
                                        final imageUrl = images[index];
                                        return Container(
                                          height: 100,
                                          width: 85,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              double? progress;
                                              if (loadingProgress.expectedTotalBytes != null) {
                                                progress = loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes!;
                                              }
                                              return Container(
                                                color: progress == null
                                                    ? Colors.grey[300]
                                                    : Color.lerp(Colors.grey[300], Colors.blue, progress),
                                                child: Center(
                                                  child: CircularProgressIndicator(
                                                    value: progress,
                                                    color: Colors.blueAccent,
                                                    strokeWidth: 2,
                                                  ),
                                                ),
                                              );
                                            },
                                            errorBuilder: (context, error, stackTrace) => Container(
                                              color: Colors.grey[300],
                                              child: const Icon(Icons.broken_image),
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
                              children: [
                                UIHelper.boldText(
                                  text: "Added In Groups",
                                  fontSize: 18,
                                  color: AppColors.text,
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: ListView.separated(
                                itemCount: 12,
                                separatorBuilder: (context, index) => const SizedBox(width: 10),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blue[100],
                                      radius: 22,
                                      child: UIHelper.customImage(img: "c-1.png"),
                                    ),
                                    title: const Text(
                                      "Mathematic Heads",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        UIHelper.customSvg(svg: "member-add-icon.svg"),
                                        const SizedBox(width: 8),
                                        Container(
                                          height: 8,
                                          width: 1,
                                          color: AppColors.textblue,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text("80 Members"),
                                      ],
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        // 🚫 This only handles remove icon tap — doesn't trigger page navigation
                                        debugPrint("Remove icon tapped at index $index");
                                      },
                                      child: UIHelper.customSvg(svg: "remove-gp-icon.svg"),
                                    ),
                                    onTap: () {
                                      // ✅ This triggers when user taps the entire list item
                                      Get.to(() => CreateGrop());
                                      //Get.to(() => GroupDetailsPage(groupIndex: index + 1));
                                    },
                                  );
                                },
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
      ),
    );
  }

  Widget _buildDecorativeBackground() {
    return Stack(
      children: [UIHelper.customSvg(svg: "bg.svg", fit: BoxFit.cover)],
    );
  }
}
