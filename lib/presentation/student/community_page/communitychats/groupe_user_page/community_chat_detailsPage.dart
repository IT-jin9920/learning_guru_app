import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_guru_app/presentation/student/community_page/chat_details_page/widgets/sender_image_message.dart';
import 'package:learning_guru_app/presentation/student/community_page/chat_details_page/widgets/senderloder.dart';
import 'package:learning_guru_app/presentation/student/community_page/communitychats/discussion_forum/discussion_forum_page.dart';
import 'package:learning_guru_app/presentation/student/community_page/communitychats/groupe_user_page/community_user_profile_page.dart';
import 'package:learning_guru_app/presentation/student/community_page/communitychats/polls_details/poll_create.dart';
import 'package:learning_guru_app/presentation/student/community_page/communitychats/widgets/receiver_message.dart';
import 'package:learning_guru_app/presentation/student/community_page/communitychats/widgets/sender_message.dart';
import 'package:learning_guru_app/presentation/student/community_page/communitychats/widgets/sender_poll_message.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import '../../../../../utils/ui_helper.dart';

class DialController extends GetxController {
  var isDialOpen = false.obs;

  void toggleDial() => isDialOpen.value = !isDialOpen.value;

  void closeDial() => isDialOpen.value = false;

  void selectOption(String option) {
    print('✅ $option Selected'); // This should print in the console.
    closeDial();
    _handleFileSelection(option);
  }

  void _handleFileSelection(String option) {
    switch (option.toLowerCase()) {
      case 'chat':
        print('💬 Opening Chat picker...');
        _openChatPicker();
        break;

      case 'pool':
        print('📊 Opening Pool picker...');
        _openPollDialog();
        break;

      case 'video':
        print('🎥 Opening video picker...');
        _pickVideo();
        break;

      case 'image':
        print('📷 Opening image picker...');
        _pickImage();
        break;

      case 'document':
        print('📄 Opening document picker...');
        _pickDocument();
        break;

      default:
        print('❌ Unsupported option: $option');
    }
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      print('📷 Image picked: ${image.path}');
      // TODO: Upload/send image
    } else {
      print('⚠️ No image selected.');
    }
  }

  void _pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      print('🎬 Video picked: ${video.path}');
      // TODO: Upload/send video
    } else {
      print('⚠️ No video selected.');
    }
  }

  void _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'ppt', 'pptx'],
    );

    if (result != null && result.files.single.path != null) {
      String filePath = result.files.single.path!;
      print('📄 Document picked: $filePath');
      // TODO: Upload/send document
    } else {
      print('⚠️ No document selected.');
    }
  }

  void _openChatPicker() async {
    // Get.to(PollCreate());
  }

  void _openPollDialog() async {
    Get.to(PollCreate());
  }
}

class CommunityChatDetailspage extends StatefulWidget {
  const CommunityChatDetailspage({Key? key}) : super(key: key);

  @override
  State<CommunityChatDetailspage> createState() =>
      _CommunityChatDetailspageState();
}

class _CommunityChatDetailspageState extends State<CommunityChatDetailspage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _messageController = TextEditingController();
  final List<Widget> _messages = [
    const SenderMessage(
      sender: "Luke Tailor",
      message: "Hello Buddy.!!",
      time: "08:12",
    ),
    const ReceiverMessage(
      message: "Lorem Ipsum is simply dummy text",
      time: "08:12",
    ),
    const SenderMessage(
      sender: "Emily Wills",
      message:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      time: "08:12",
    ),
    const SenderImageMessage(
      sender: "Json Jackson",
      imagePaths: ["img-1.png", "img-2.png"],
      time: "08:12",
    ),
    const Senderloder(loder: "lod-img.png"),
  ];

  final DialController dialController = Get.put(DialController());

  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  void _addNewMessage(String text) {
    final now = TimeOfDay.now();
    final formattedTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    setState(() {
      _messages.add(
        SenderMessage(sender: "You", message: text, time: formattedTime),
      );
    });
    _messageController.clear();
    _scrollToBottom();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void toggleDial() {
    if (dialController.isDialOpen.value) {
      _animationController.reverse();
      dialController.closeDial();
    } else {
      dialController.toggleDial();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _messageController.dispose();

    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
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
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const CustomAppBarRow(),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        children: [
                          ListView(
                            physics: NeverScrollableScrollPhysics(),
                            // disable inner scroll
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            children: [
                              Container(
                                height: 36,
                                decoration: BoxDecoration(
                                  color: AppColors.primary1,
                                  borderRadius: BorderRadius.circular(80),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    // Leading icon
                                    UIHelper.customSvg(
                                      svg: "speed-dile-icon-chat.svg",
                                    ),
                                    const SizedBox(width: 8),

                                    // Divider
                                    Container(
                                      width: 1,
                                      height: 16,
                                      color: AppColors.white,
                                    ),
                                    const SizedBox(width: 8),

                                    // Text content (expanded so it doesn't overlap)
                                    Expanded(
                                      child: UIHelper.boldText(
                                        text: "Discussion Forum One",
                                        fontSize: 14,
                                        color: AppColors.white,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),

                                    // Trailing arrow
                                    InkWell(
                                      onTap: () {
                                      Get.to(DiscussionForumPage());
                                      },
                                      child: UIHelper.customSvg(
                                        svg: "right-arrow-svg-icon.svg",
                                        width: 25,
                                        height: 25,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 16),

                              SenderMessage(
                                sender: "Luke Tailor",
                                message: "Hello Buddy.!!",
                                time: "08:12",
                              ),
                              ReceiverMessage(
                                message: "Lorem Ipsum is simply dummy text",
                                time: "08:12",
                              ),
                              SenderMessage(
                                sender: "Emily Wills",
                                message:
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                time: "08:12",
                              ),
                              SenderPollMessage(
                                sender: "Json Jackson",
                                time: "10:45",
                                title: "Do you like Flutter?",
                                pollOptions: ["Chapter 1 ", "Chapter 5"],
                                totalVotes: 102,
                                votePercentages: [0.4, 0.6],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Obx(() {
              if (!dialController.isDialOpen.value) {
                return const SizedBox.shrink(); // Return nothing if the dial is closed
              }

              return Positioned.fill(
                left: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () {
                    _animationController.reverse(); // Reverse animation
                    dialController.closeDial(); // Close the dial
                  },
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    // Apply the blur
                    child: Container(
                      color: Colors.black.withOpacity(
                        0.3,
                      ), // Apply slight opacity
                    ),
                  ),
                ),
              );
            }),

            Obx(() {
              if (!dialController.isDialOpen.value) {
                return const SizedBox.shrink(); // Return empty when the dial is closed
              }

              return Positioned(
                bottom: 20,
                // Adjust position to avoid covering the whole page
                left: 70,
                // Adjust the horizontal positioning of speed dial options
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  // Apply fade animation for smooth transition
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Video option
                      _buildSpeedDialOption(
                        "speed-dile-icon-video.svg",
                        "Video",
                        Colors.red.shade100,
                        () => dialController.selectOption("Video"),
                      ),
                      const SizedBox(height: 16), // Space between buttons
                      // Image option
                      _buildSpeedDialOption(
                        "speed-dile-icon-img.svg",
                        "Image",
                        Colors.green.shade100,
                        () => dialController.selectOption("Image"),
                      ),
                      const SizedBox(height: 16),

                      // Document option
                      _buildSpeedDialOption(
                        "speed-dile-icon-doc.svg",
                        "Document",
                        Colors.blue.shade100,
                        () => dialController.selectOption("Document"),
                      ),
                      const SizedBox(height: 16),

                      _buildSpeedDialOption(
                        "speed-dile-icon-pool.svg",
                        "Video",
                        Colors.red.shade100,
                        () => dialController.selectOption("pool"),
                      ),
                      const SizedBox(height: 16),

                      _buildSpeedDialOption(
                        "speed-dile-icon-chat.svg",
                        "Video",
                        Colors.red.shade100,
                        () => dialController.selectOption("chat"),
                      ),

                      // const SizedBox(height: 16),  // Space between buttons
                    ].reversed.toList(), // Reverse to have the first item at the bottom
                  ),
                ),
              );
            }),
          ],
        ),

        // bottomNavigationBar: Container(
        //   color: Colors.white,
        //   child: Padding(
        //     padding: EdgeInsets.only(
        //       bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        //       left: 16,
        //       right: 16,
        //       top: 8,
        //     ),
        //     child: const ChatInputBox(),
        //   ),
        // ),
        bottomNavigationBar: Container(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              children: [
                // Main Chat Input Row
                Row(
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
                        child: UIHelper.customSvg(
                          svg: "back-arrow-icon-svg.svg",
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(80),
                          border: Border.all(color: Colors.black87, width: 1.2),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: toggleDial,
                              // Toggles the dial state when tapped
                              child: Obx(() {
                                print(
                                  'Dial Open: ${dialController.isDialOpen.value}',
                                ); // Debugging log
                                return UIHelper.customSvg(
                                  svg: dialController.isDialOpen.value
                                      ? "speed-cancalled-icon.svg.svg"
                                      : "link-icon-svg.svg",
                                  width: 20,
                                  height: 20,
                                );
                              }),
                            ),

                            const SizedBox(width: 8),
                            Container(
                              width: 1,
                              height: 10,
                              color: AppColors.textblue,
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Write your message...",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: UIHelper.customImage(
                                  img: "send-img.png",
                                  width: 44,
                                  height: 44,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Blur Background when Dial is Open
                // if (_isDialOpen)
                //   Positioned.fill(
                //     child: GestureDetector(
                //       onTap: () => setState(() => _isDialOpen = false),
                //       child: BackdropFilter(
                //         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                //         child: Container(color: Colors.black.withOpacity(0.2)),
                //       ),
                //     ),
                //   ),
                //
                // // SpeedDial (bottom to top) from Link Icon
                // if (_isDialOpen)
                //   Positioned(
                //     bottom: 60, // Height above input box
                //     left: 60, // Adjust so it aligns with link icon position
                //     child: SpeedDial(
                //       direction: SpeedDialDirection.up,
                //       animatedIcon: AnimatedIcons.menu_close,
                //       backgroundColor: Colors.teal.shade100,
                //       foregroundColor: Colors.black,
                //       overlayColor: Colors.transparent,
                //       spaceBetweenChildren: 12.0,
                //       spacing: 8.0,
                //       children: [
                //         SpeedDialChild(
                //           child: const Icon(Icons.videocam),
                //           label: 'Video',
                //           onTap: () => print('Video Selected'),
                //         ),
                //         SpeedDialChild(
                //           child: const Icon(Icons.image),
                //           label: 'Image',
                //           onTap: () => print('Image Selected'),
                //         ),
                //         SpeedDialChild(
                //           child: const Icon(Icons.insert_drive_file),
                //           label: 'Document',
                //           onTap: () => print('Document Selected'),
                //         ),
                //       ],
                //     ),
                //   ),
              ],
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

  Widget _buildSpeedDialOption(
    String svg,
    String label,
    Color backgroundColor,
    VoidCallback onTap,
  ) {
    return ScaleTransition(
      scale: _scaleAnimation,
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          print('🎯 Tapped: $label');
          onTap();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          // Clip to make the SVG inside round
          child: Container(
            color: AppColors.text,
            width: 40, // Size of the container
            height: 40,
            child: Center(
              child: UIHelper.customSvg(
                svg: svg, // Pass the SVG path here
                width: 20, // SVG size 20x20
                height: 20, // SVG size 20x20
              ),
            ),
          ),
        ),
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
        children: [
          UIHelper.customImage(
            img: "comunity-user-img.png",
            width: 55,
            height: 55,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              // Text(
              //   "Mathematic Heads",
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
              // ),
              UIHelper.boldText(
                text: "Mathematic Heads",
                fontSize: 16,
                color: AppColors.text,
              ),
              SizedBox(height: 4),
              UIHelper.boldText(
                text: "80 Members",
                fontSize: 12,
                color: AppColors.grey,
              ),

              //Text("80 Members", style: TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.to(
                CommunityUserProfilePage(
                  username: "Mathematic Heads",
                  member: "80 Members",
                  imageUrl: "comunity-user-img.png",
                ),
              );
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFCDD6E9),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: UIHelper.customImage(
                  img: "user-profiel-seting.png",
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class SenderMessage extends StatelessWidget {
//   final String sender, message, time;
//   const SenderMessage({required this.sender, required this.message, required this.time, Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         width: 220,
//         margin: const EdgeInsets.only(top: 4, bottom: 12),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: const Color(0xFFEAF2FF),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//             bottomRight: Radius.circular(20),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(sender, style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.blueAccent)),
//                 Text(time, style: const TextStyle(fontSize: 10, color: Colors.black54)),
//               ],
//             ),
//             const SizedBox(height: 6),
//             Text(message, style: const TextStyle(fontSize: 16, color: Colors.black87)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ReceiverMessage extends StatelessWidget {
//   final String message, time;
//   const ReceiverMessage({required this.message, required this.time, Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         width: 270,
//         margin: const EdgeInsets.only(bottom: 12),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: const Color(0xFFDCE1EB),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//             bottomLeft: Radius.circular(20),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 UIHelper.mediumText(text: "you", fontSize: 12, color: AppColors.textblue),
//                 UIHelper.mediumText(text: time, fontSize: 12, color: AppColors.textblue),
//               ],
//             ),
//             const SizedBox(height: 6),
//             Text(message, style: const TextStyle(fontSize: 16, color: Colors.black87)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SenderImageMessage extends StatelessWidget {
//   final String sender, time;
//   final List<String> imagePaths;
//   const SenderImageMessage({required this.sender, required this.imagePaths, required this.time, Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         width: 250,
//         margin: const EdgeInsets.only(top: 4, bottom: 12),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: const Color(0xFFEAF2FF),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(sender, style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.blueAccent)),
//                 Text(time, style: const TextStyle(fontSize: 10, color: Colors.black54)),
//               ],
//             ),
//             const SizedBox(height: 6),
//             Row(
//               children: imagePaths
//                   .map((path) => Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: UIHelper.customImage(
//                     img: path,
//                     width: 100,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ))
//                   .toList(),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Senderloder extends StatelessWidget {
//   final String loder;
//   const Senderloder({Key? key, required this.loder}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: UIHelper.customImage(img: loder, height: 30, width: 70),
//     );
//   }
// }

// class ChatInputBox extends StatelessWidget {
//   const ChatInputBox({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Container(
//             height: 40,
//             width: 40,
//             decoration: const BoxDecoration(
//               color: Color(0xFFCEDBF1),
//               shape: BoxShape.circle,
//             ),
//             padding: const EdgeInsets.all(8),
//             child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Container(
//             padding: const EdgeInsets.only(left: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(80),
//               border: Border.all(color: Colors.black87, width: 1.2),
//             ),
//             child: Row(
//               children: [
//                 InkWell(
//                     onTap: (){},
//                     child: UIHelper.customImage(img: "link-img.png", width: 20, height: 20)),
//                 const SizedBox(width: 8),
//                 Container(width: 1, height: 10, color: AppColors.textblue),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: TextField(
//                     decoration: const InputDecoration(
//                       hintText: "Write your message...",
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: UIHelper.customImage(img: "send-img.png", width: 44, height: 44),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
