import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/student/community_page/communitychats/discussion_forum/discussion_forum_details_page.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

import 'discussion_forum_create.dart';

class DiscussionForumPage extends StatelessWidget {
  const DiscussionForumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xffEAF2FF),
        body: Stack(
          children: [
            // Background decoration
            Positioned(right: 0, top: -35, child: _buildDecorativeBackground()),

            // Main content
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const CustomAppBarRow(),
                    const SizedBox(height: 10),
                    _buildHeaderCard(),
                    const SizedBox(height: 10),
                    _buildPostsContainer(),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Bottom floating action button
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 20, right: 10),
          child: FloatingActionButton(
            onPressed: () {
              Get.to(DiscussionForumCreate());
            },
            backgroundColor: AppColors.primary1,
            shape: const CircleBorder(), // Makes it perfectly round
            child: UIHelper.customSvg(
              svg: "add-icon.svg",
              color: AppColors.white,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildDecorativeBackground() {
    return UIHelper.customSvg(svg: "bg.svg", fit: BoxFit.cover);
  }

  Widget _buildHeaderCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.customSvg(
                  svg: "speed-dile-icon-chat.svg",
                  color: AppColors.text,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: UIHelper.boldText(
                    text: "Doubt Solving for Maths Ch.1",
                    fontSize: 16,
                    color: AppColors.primary1,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            UIHelper.mediumText(
              text:
                  "We are using this forum to discuss and solve all the doubts and modules related to all the Chapters and Lessons",
              fontSize: 12,
              color: AppColors.grey,
              maxLines: 3,
              textAlign: TextAlign.start,
              overflow: TextOverflow.visible,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsContainer() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Regular posts
            ..._buildRegularPosts(),

            const SizedBox(height: 16),

            // User's post
            _buildUserPost(
              avatarUrl: "https://randomuser.me/api/portraits/men/75.jpg",
              time: "08:12",
              title: "I am Facing this Difficulty, Please Help!",
              content:
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              repliesCount: "5 Replies",
            ),

            const SizedBox(height: 100), // Extra space for floating button
          ],
        ),
      ),
    );
  }

  List<Widget> _buildRegularPosts() {
    const postData = [
      {
        "avatarUrl": "https://randomuser.me/api/portraits/men/32.jpg",
        "name": "Json Jackson",
        "time": "08:12",
        "title": "I am Facing this Difficulty, Please Help!",
        "content":
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
        "repliesCount": "23 Replies",
      },
      {
        "avatarUrl": "https://randomuser.me/api/portraits/men/32.jpg",
        "name": "Json Jackson",
        "time": "08:12",
        "title": "I am Facing this Difficulty, Please Help!",
        "content":
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
        "repliesCount": "23 Replies",
      },
    ];

    return postData.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, String> post = entry.value;

      return Column(
        children: [
          _buildForumPost(
            avatarUrl: post["avatarUrl"]!,
            name: post["name"]!,
            time: post["time"]!,
            title: post["title"]!,
            content: post["content"]!,
            repliesCount: post["repliesCount"]!,
          ),
          if (index < postData.length - 1) const SizedBox(height: 16),
        ],
      );
    }).toList();
  }

  Widget _buildForumPost({
    required String avatarUrl,
    required String name,
    required String time,
    required String title,
    required String content,
    required String repliesCount,
  }) {
    return Column(
      children: [
        // Header above container
        _buildPostHeader(
          avatarUrl: avatarUrl,
          name: name,
          time: time,
          isUserPost: false,
        ),

        // Main post container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFFF0F5FF),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: _buildPostContent(
            title: title,
            content: content,
            repliesCount: repliesCount,
          ),
        ),
      ],
    );
  }

  Widget _buildUserPost({
    required String avatarUrl,
    required String time,
    required String title,
    required String content,
    required String repliesCount,
  }) {
    return Column(
      children: [
        // Header above container
        _buildPostHeader(
          avatarUrl: avatarUrl,
          name: "You",
          time: time,
          isUserPost: true,
        ),

        // Main post container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFFE8E8E8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              _buildPostContent(
                title: title,
                content: content,
                repliesCount: repliesCount,
                isUser: true,
              ),
              const SizedBox(height: 8), // Extra space for visual balance
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPostHeader({
    required String avatarUrl,
    required String name,
    required String time,
    required bool isUserPost,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: isUserPost
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: isUserPost
            ? [
                Text(
                  time,
                  style: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.textblue,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(avatarUrl),
                    ),
                  ],
                ),
              ]
            : [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.textblue,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
              ],
      ),
    );
  }

  Widget _buildPostContent({
    required String title,
    required String content,
    required String repliesCount,
    bool isUser = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 8),

        // Content
        Text(
          content,
          style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.4),
        ),

        const SizedBox(height: 16),

        // Footer with avatars and replies
        _buildPostFooter(repliesCount, isUser: isUser),
      ],
    );
  }

  Widget _buildPostFooter(String repliesCount, {bool isUser = false}) {
    return InkWell(
      onTap: () {
        if (isUser) {
          print("✅ User tapped post | Replies: $repliesCount");
          Get.to(() => DiscussionForumDetailsPage());
        } else {
          print("❌ Guest tapped post | Replies: $repliesCount");
        }
      },
      child: Row(
        children: [
          // Overlapping avatars
          _buildOverlappingAvatars(),

          Text(
            repliesCount,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          const Spacer(),

          UIHelper.customSvg(
            svg: "right-arrow-svg-icon.svg",
            width: 25,
            height: 25,
          ),
        ],
      ),
    );
  }

  Widget _buildOverlappingAvatars() {
    const avatarUrls = [
      "https://randomuser.me/api/portraits/women/55.jpg",
      "https://randomuser.me/api/portraits/men/44.jpg",
      "https://randomuser.me/api/portraits/men/33.jpg",
    ];

    return SizedBox(
      width: 80,
      height: 24,
      child: Stack(
        children: avatarUrls.asMap().entries.map((entry) {
          int index = entry.key;
          String url = entry.value;

          return Positioned(
            left: index * 16.0,
            child: CircleAvatar(radius: 12, backgroundImage: NetworkImage(url)),
          );
        }).toList(),
      ),
    );
  }
}

class CustomAppBarRow extends StatelessWidget {
  const CustomAppBarRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          _buildBackButton(context),

          // Title
          const Text(
            'Discussion Forum',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          // Right spacer for center alignment
          // const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
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
    );
  }
}
