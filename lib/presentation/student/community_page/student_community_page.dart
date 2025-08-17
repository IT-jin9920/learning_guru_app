import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/student/home_screen/my_session/my_sessions_page.dart';

import '../../../res/colors/app_color.dart';
import '../../../utils/ui_helper.dart';
import 'chat_details_page/chat_details.dart';
import 'communitychats/explore_community_screen.dart';
import 'communitychats/groupe_user_page/community_chat_detailsPage.dart';
import 'communitychats/create_gropes/create_grop.dart';

class ChatModel {
  final String name;
  final String message;
  final String time;
  final String avatar;
  final bool unread;

  ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    this.unread = false,
  });
}

class ChatController extends GetxController {
  var allChats = <ChatModel>[
    ChatModel(
      name: 'Luke Tailor',
      message: 'Hello Sir, Are you coming to..',
      time: '10:23 AM',
      avatar: 'assets/images/user-1.png',
      unread: true,
    ),
    ChatModel(
      name: 'Emily Wills',
      message: 'You: Sure I\'ll Share it Soon.',
      time: '09:05 AM',
      avatar: 'assets/images/user-2.png',
    ),
    ChatModel(
      name: 'Json Jackson',
      message: 'See you tomorrow Sir!!',
      time: 'Yesterday',
      avatar: 'assets/images/user-3.png',
    ),
    ChatModel(
      name: 'Luke Tailor',
      message: 'Hello Sir, Are you coming to..',
      time: '10:23 AM',
      avatar: 'assets/images/user-1.png',
      unread: true,
    ),
    ChatModel(
      name: 'Emily Wills',
      message: 'You: Sure I\'ll Share it Soon.',
      time: '09:05 AM',
      avatar: 'assets/images/user-2.png',
    ),
    ChatModel(
      name: 'Luke Tailor',
      message: 'Hello Sir, Are you coming to..',
      time: '10:23 AM',
      avatar: 'assets/images/user-1.png',
      unread: true,
    ),
    ChatModel(
      name: 'Emily Wills',
      message: 'You: Sure I\'ll Share it Soon.',
      time: '09:05 AM',
      avatar: 'assets/images/user-2.png',
    ),
    ChatModel(
      name: 'Json Jackson',
      message: 'See you tomorrow Sir!!',
      time: 'Yesterday',
      avatar: 'assets/images/user-3.png',
    ),
    ChatModel(
      name: 'Luke Tailor',
      message: 'Hello Sir, Are you coming to..',
      time: '10:23 AM',
      avatar: 'assets/images/user-1.png',
      unread: true,
    ),
    ChatModel(
      name: 'Emily Wills',
      message: 'You: Sure I\'ll Share it Soon.',
      time: '09:05 AM',
      avatar: 'assets/images/user-2.png',
    ),
  ].obs;

  var filteredChats = <ChatModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredChats.value = allChats;
  }

  void filterChats(String query) {
    if (query.isEmpty) {
      filteredChats.value = allChats;
    } else {
      filteredChats.value = allChats
          .where(
            (chat) =>
                chat.name.toLowerCase().contains(query.toLowerCase()) ||
                chat.message.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  }
}

class StudentCommunityPage extends StatelessWidget {
  const StudentCommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),

      body: Stack(
        children: [
          /// 🎨 Background Layer
          Positioned(right: 0, top: -35, child: _buildDecorativeBackground()),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔲 Padded Section (Top content)
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Transform.translate(
                                offset: const Offset(-4, 0),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: UIHelper.boldText(
                                    text: 'C',
                                    fontSize: 28,
                                    color: AppColors.text,
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(-8, 0),
                                child: UIHelper.customImage(
                                  img: "community-icon.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),

                              Transform.translate(
                                offset: const Offset(-18, 0),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: UIHelper.boldText(
                                    text: 'mmunity',
                                    fontSize: 24,
                                    color: AppColors.text,
                                  ),
                                ),
                              ),

                              Transform.translate(
                                offset: const Offset(-18, 0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                    bottom: 15,
                                  ),
                                  child: UIHelper.boldText(
                                    text: 'Chat',
                                    fontSize: 24,
                                    color: AppColors.primary1,
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(-18, 0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 1,
                                    bottom: 15,
                                  ),
                                  child: UIHelper.boldText(
                                    text: '!',
                                    fontSize: 24,
                                    color: AppColors.primary1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      //const SizedBox(height: 4),

                      /// Subtitle
                      UIHelper.boldText(
                        text: "Stay Updated",
                        fontSize: 16,
                        color: const Color(0xff96b4e5),
                        fontWeight: FontWeight.w900,
                      ),

                      const SizedBox(height: 24),

                      /// Search Field
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // Handle tap
                                Get.to(() => MySessionsPage());
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: AppColors.text,
                              // or any background color you prefer
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(45),
                              border: Border.all(
                                color: Color(0xFFCDDCF4),
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                height: 16,
                                width: 16,
                                child: UIHelper.customSvg(
                                  svg: "serch-icon-svg.svg",
                                  //color: AppColors.textblue,
                                ),
                              ),
                            ),
                          ),

                          // /// Use `Expanded` to prevent overflow
                          // Expanded(
                          //   child: Container(
                          //     height: 48,
                          //     decoration: BoxDecoration(
                          //       color: const Color(0xFFCDDCF4),
                          //       borderRadius: BorderRadius.circular(30),
                          //     ),
                          //     child: TextField(
                          //       onChanged: chatController.filterChats,
                          //       style: const TextStyle(
                          //         fontFamily: 'BeVietnamPro',
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: 12,
                          //       ),
                          //       decoration: const InputDecoration(
                          //         contentPadding: EdgeInsets.symmetric(
                          //           horizontal: 16,
                          //           vertical: 12,
                          //         ),
                          //         hintText: "Search for Groups & Chats",
                          //         border: InputBorder.none,
                          //         hintStyle: TextStyle(
                          //           fontFamily: 'BeVietnamPro',
                          //           fontWeight: FontWeight.w500,
                          //           fontSize: 12,
                          //           color: Color(0xff7c84a5),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 20),
                        ],
                      ),

                      const SizedBox(height: 30),
                      UIHelper.boldText(
                        text: "Your Groups",
                        fontSize: 16,
                        color: AppColors.text,
                      ),
                      const SizedBox(height: 30),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // Create Button
                            InkWell(
                              onTap: () {
                                Get.to(ExploreCommunityScreen());
                              },
                              child: Container(
                                // width: 105,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFCDDCF4),
                                  // Fill color
                                  borderRadius: BorderRadius.circular(46),
                                  // Rounded corners
                                  border: Border.all(
                                    color: AppColors.textblue,
                                    // Border color
                                    width: 1, // Border width
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        UIHelper.customSvg(
                                          svg: "add-icon.svg",
                                          width: 20,
                                          height: 20,
                                        ),
                                        const SizedBox(width: 4),
                                        const Text(
                                          "Explore",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textblue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Scrollable Avatar List
                            Row(
                              children: List.generate(
                                5,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigate to detail page with index
                                      Get.to(CommunityChatDetailspage());
                                    },
                                    child: ClipOval(
                                      child: SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: UIHelper.customImage(
                                          img: 'c-$index.png',
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

                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// 🔳 Non-Padded Area
                Expanded(
                  // 👈 This makes it fill remaining screen height
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24, top: 24),
                            child: Row(
                              children: [
                                UIHelper.boldText(
                                  text: "All Chats",
                                  fontSize: 18,
                                  color: AppColors.text,
                                ),

                                SizedBox(width: 6),
                                Obx(
                                  () => Container(
                                    width: 30,
                                    // height: 53,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary1,
                                      // 👈 change color as needed
                                      borderRadius: BorderRadius.circular(
                                        53,
                                      ), // 👈 radius = width/height for perfect circle
                                    ),
                                    child: Text(
                                      chatController.filteredChats.length
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          // 🧠 Reactive Chat List
                          Obx(() {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: ListView.builder(
                                itemCount: chatController.filteredChats.length,
                                itemBuilder: (context, index) {
                                  final chat =
                                      chatController.filteredChats[index];
                                  return GestureDetector(
                                    onTap: () {
                                      // ✅ Navigate to new page and pass data (or index)
                                      Get.to(() => ChatDetails());
                                      // OR
                                      // Get.to(() => ChatDetailPage(index: index));
                                    },
                                    child: ChatTile(
                                      name: chat.name,
                                      message: chat.message,
                                      time: chat.time,
                                      avatar: chat.avatar,
                                      unread: chat.unread,
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 📃 Content Area
          // Positioned(
          //   top: MediaQuery.of(context).padding.top + 70,
          //   left: 0,
          //   right: 0,
          //   bottom: 0,
          //   child: Container(
          //     decoration: const BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(40),
          //         topRight: Radius.circular(40),
          //       ),
          //     ),
          //     child: Column(
          //       children: [
          //
          //       ],
          //     ),
          //   ),
          // ),
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
}

// ChatTile remains same
class ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String avatar;
  final bool unread;

  const ChatTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    this.unread = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        alignment: Alignment.bottomRight,
        children: [
         // CircleAvatar(radius: 26, backgroundImage: AssetImage(avatar)),
          UIHelper.customNetworkImage(
            imageUrl: "https://randomuser.me/api/portraits/men/47.jpg",
            height: 56,
            width: 56,
            isCircular: true,
          ),
          if (unread)
            const Positioned(
              bottom: 0, // bottom right instead of top
              right: 0,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: AppColors.primary1,
                child: Text(
                  '1',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UIHelper.boldText(
            text: name,
            fontSize: 14,
            color: AppColors.text,
          ),
          UIHelper.regularText(
            text: time,
            fontSize: 10,
            color: AppColors.grey,
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: unread ? AppColors.textblue : Colors.black54,
              fontWeight: unread ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 6),
          const Divider(
            thickness: 0.8,
            color: Colors.black26,
            height: 10,
          ),
        ],
      ),
    );
  }

}
