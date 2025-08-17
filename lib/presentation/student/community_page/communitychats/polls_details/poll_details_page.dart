import 'package:flutter/material.dart';
import 'package:learning_guru_app/presentation/student/community_page/communitychats/widgets/sender_poll_message.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';

import '../../../../../utils/ui_helper.dart';

class ChatModel {
  final String name;
  final String chapter;
  final String avatar;
  final bool unread;

  ChatModel({
    required this.name,
    required this.chapter,
    required this.avatar,
    this.unread = false,
  });
}

class ChatTile extends StatelessWidget {
  final ChatModel chat;

  const ChatTile({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(radius: 26, backgroundImage: AssetImage(chat.avatar)),
        title: Text(
          chat.name,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        trailing: Text(chat.chapter, style: const TextStyle(color: Colors.black45)),
      ),
    );
  }
}

class PollDetailsPage extends StatefulWidget {
  const PollDetailsPage({Key? key}) : super(key: key);

  @override
  State<PollDetailsPage> createState() => _PollDetailsPageState();
}

class _PollDetailsPageState extends State<PollDetailsPage> {
  final List<ChatModel> chats = [
    ChatModel(
      name: 'Luke Tailor',
      chapter: 'Chapter 1',
      avatar: 'assets/images/user-1.png',
      unread: true,
    ),
    ChatModel(
      name: 'Emily Wills',
      chapter: 'Chapter 5',
      avatar: 'assets/images/user-2.png',
    ),
    ChatModel(
      name: 'Json Jackson',
      chapter: 'Chapter 1',
      avatar: 'assets/images/user-3.png',
    ),
    ChatModel(
      name: 'Emily Wills',
      chapter: 'Chapter 5',
      avatar: 'assets/images/user-2.png',
    ),
    ChatModel(
      name: 'Json Jackson',
      chapter: 'Chapter 1',
      avatar: 'assets/images/user-3.png',
    ),
    ChatModel(
      name: 'Luke Tailor',
      chapter: 'Chapter 1',
      avatar: 'assets/images/user-1.png',
      unread: true,
    ),
    ChatModel(
      name: 'Emily Wills',
      chapter: 'Chapter 5',
      avatar: 'assets/images/user-2.png',
    ),
    ChatModel(
      name: 'Json Jackson',
      chapter: 'Chapter 1',
      avatar: 'assets/images/user-3.png',
    ),
    ChatModel(
      name: 'Emily Wills',
      chapter: 'Chapter 5',
      avatar: 'assets/images/user-2.png',
    ),
    ChatModel(
      name: 'Json Jackson',
      chapter: 'Chapter 1',
      avatar: 'assets/images/user-3.png',
    ),
    ChatModel(
      name: 'Luke Tailor',
      chapter: 'Chapter 1',
      avatar: 'assets/images/user-1.png',
      unread: true,
    ),
    ChatModel(
      name: 'Emily Wills',
      chapter: 'Chapter 5',
      avatar: 'assets/images/user-2.png',
    ),
    ChatModel(
      name: 'Json Jackson',
      chapter: 'Chapter 1',
      avatar: 'assets/images/user-3.png',
    ),
    ChatModel(
      name: 'Emily Wills',
      chapter: 'Chapter 5',
      avatar: 'assets/images/user-2.png',
    ),
    ChatModel(
      name: 'Json Jackson',
      chapter: 'Chapter 1',
      avatar: 'assets/images/user-3.png',
    ),
  ];

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
                  const CustomAppBarRow(),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SenderPollMessageDetails(
                                    sender: "Json Jackson",
                                    time: "10:45 AM",
                                    title: "Let’s Prepare it \nTogether!!",
                                    pollOptions: ["Chapter 1 ", "Chapter 5"],
                                    totalVotes: 102,
                                    votePercentages: [0.4, 0.6],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 24, top: 24),
                                    child: Row(
                                      children: [
                                        UIHelper.boldText(
                                          text: "All Votes",
                                          fontSize: 18,
                                          color: AppColors.text,
                                        ),
                                        const SizedBox(width: 6),
                                        Container(
                                          width: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColors.primary1,
                                            borderRadius: BorderRadius.circular(53),
                                          ),
                                          child: Text(
                                            chats.length.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: chats.length,
                                    itemBuilder: (context, index) {
                                      final chat = chats[index];
                                      return GestureDetector(
                                        onTap: () {
                                          // Navigate to chat details here if needed
                                        },
                                        child: ChatTile(chat: chat),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
              'Poll Detail',
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
    );
  }
}