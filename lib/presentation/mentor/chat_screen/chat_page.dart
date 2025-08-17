import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/colors/app_color.dart';
import '../../../utils/ui_helper.dart';
import '../../student/community_page/chat_details_page/chat_details.dart';
import '../../student/community_page/communitychats/groupe_user_page/community_chat_detailsPage.dart';
import '../../student/community_page/communitychats/create_gropes/create_grop.dart';

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

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),

      // body: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         const SizedBox(height: 12),
      //         const Text.rich(
      //           TextSpan(
      //             children: [
      //               TextSpan(
      //                 text: 'C',
      //                 style: TextStyle(
      //                     fontWeight: FontWeight.bold,
      //                     color: Colors.black,
      //                     fontSize: 24),
      //               ),
      //               WidgetSpan(
      //                 child: Icon(Icons.chat_bubble_outline,
      //                     color: Colors.blueAccent, size: 22),
      //               ),
      //               TextSpan(
      //                 text: 'ommunity ',
      //                 style: TextStyle(
      //                     fontWeight: FontWeight.bold,
      //                     color: Colors.black,
      //                     fontSize: 24),
      //               ),
      //               TextSpan(
      //                 text: 'Chat!',
      //                 style: TextStyle(
      //                     fontWeight: FontWeight.bold,
      //                     color: Colors.blueAccent,
      //                     fontSize: 24),
      //               ),
      //             ],
      //           ),
      //         ),
      //         const SizedBox(height: 6),
      //         const Text(
      //           "Stay Connected",
      //           style: TextStyle(
      //             color: Colors.grey,
      //             fontSize: 14,
      //           ),
      //         ),
      //         const SizedBox(height: 16),
      //
      //         // 🔍 Search Bar with GetX Filter
      //         Container(
      //           padding: const EdgeInsets.symmetric(horizontal: 12),
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(30),
      //           ),
      //           child: TextField(
      //             onChanged: chatController.filterChats,
      //             decoration: const InputDecoration(
      //               icon: Icon(Icons.search),
      //               hintText: "Search for Groups & Chats",
      //               border: InputBorder.none,
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 20),
      //
      //         const Text("Your Groups",
      //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      //         const SizedBox(height: 12),
      //         Row(
      //           children: [
      //             Container(
      //               width: 60,
      //               height: 60,
      //               decoration: BoxDecoration(
      //                 shape: BoxShape.circle,
      //                 border: Border.all(color: Colors.blueAccent),
      //               ),
      //               child: const Center(
      //                 child: Icon(Icons.add, color: Colors.blueAccent),
      //               ),
      //             ),
      //             const SizedBox(width: 12),
      //             ...List.generate(
      //               4,
      //                   (index) => Padding(
      //                 padding: const EdgeInsets.only(right: 10),
      //                 child: CircleAvatar(
      //                   radius: 30,
      //                   backgroundImage: AssetImage('assets/group$index.jpg'),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //         const SizedBox(height: 20),
      //
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             const Text("All Chats",
      //                 style:
      //                 TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      //             Obx(() => CircleAvatar(
      //               radius: 12,
      //               backgroundColor: Colors.blueAccent,
      //               child: Text(
      //                 chatController.filteredChats.length.toString(),
      //                 style: const TextStyle(
      //                     color: Colors.white, fontSize: 12),
      //               ),
      //             )),
      //           ],
      //         ),
      //         const SizedBox(height: 10),
      //
      //         // 🧠 Reactive Chat List
      //         Expanded(
      //           child: Obx(() {
      //             return ListView.builder(
      //               itemCount: chatController.filteredChats.length,
      //               itemBuilder: (context, index) {
      //                 final chat = chatController.filteredChats[index];
      //                 return ChatTile(
      //                   name: chat.name,
      //                   message: chat.message,
      //                   time: chat.time,
      //                   avatar: chat.avatar,
      //                   unread: chat.unread,
      //                 );
      //               },
      //             );
      //           }),
      //         ),
      //
      //       ],
      //     ),
      //   ),
      // ),
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
                        text: "Stay Connected",
                        fontSize: 16,
                        color: const Color(0xff96b4e5),
                        fontWeight: FontWeight.w900,
                      ),

                      const SizedBox(height: 24),

                      /// Search Field
                      Row(
                        children: [
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

                          const SizedBox(width: 8),

                          /// Use `Expanded` to prevent overflow
                          Expanded(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFFCDDCF4),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextField(
                                onChanged: chatController.filterChats,
                                style: const TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  hintText: "Search for Groups & Chats",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Color(0xff7c84a5),
                                  ),
                                ),
                              ),
                            ),
                          ),

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
                              onTap : (){
                                Get.to(CreateGrop());
                              },
                              child: Container(
                                width: 105,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFCDDCF4),
                                  // Fill color
                                  borderRadius: BorderRadius.circular(46),
                                  // Rounded corners
                                  border: Border.all(
                                    color: const Color(0xFF05013E),
                                    // Border color
                                    width: 1, // Border width
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      UIHelper.customSvg(
                                        svg: "add-icon.svg",
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        "Create",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF05013E),
                                        ),
                                      ),
                                    ],
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
                            padding: const EdgeInsets.only(left: 24, top: 24, ),
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
                              //  physics: PageScrollPhysics(),
                                itemCount: chatController.filteredChats.length,
                                itemBuilder: (context, index) {
                                  final chat = chatController.filteredChats[index];
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
