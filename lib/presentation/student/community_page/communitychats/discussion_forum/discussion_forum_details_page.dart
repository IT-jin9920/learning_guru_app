import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

class SenderMessage extends StatelessWidget {
  final String sender, message, time, avatarUrl;

  const SenderMessage({
    required this.sender,
    required this.message,
    required this.time,
    required this.avatarUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15,right: 10),
          child: UIHelper.customImage(img: "user-1.png", height: 32, width: 32),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 220,
            margin: const EdgeInsets.only(top: 4, bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    UIHelper.boldText(
                      text: sender,
                      fontSize: 14,
                      color: AppColors.textblue,
                      fontstyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                    ),
                    UIHelper.regularText(
                      text: time,
                      fontSize: 10,
                      color: AppColors.grey,
                    ),
                    // Text(sender, style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.blueAccent)),
                    // Text(time, style: const TextStyle(fontSize: 10, color: Colors.black54)),
                  ],
                ),
                const SizedBox(height: 6),
                UIHelper.mediumText(
                  text: message,
                  fontSize: 14,
                  color: AppColors.text,
                ),

                // Text(message, style: const TextStyle(fontSize: 16, color: Colors.black87)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ReceiverMessage extends StatelessWidget {
  final String message, time;

  const ReceiverMessage({required this.message, required this.time, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 270,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFDCE1EB),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UIHelper.mediumText(
                  text: "you",
                  fontSize: 10,
                  color: AppColors.textblue,
                  fontWeight: FontWeight.w600,
                ),
                UIHelper.regularText(
                  text: time,
                  fontSize: 10,
                  color: AppColors.grey,
                ),
              ],
            ),
            const SizedBox(height: 6),
            UIHelper.mediumText(
              text: message,
              fontSize: 14,
              color: AppColors.text,
            ),
            //Text(message, style: const TextStyle(fontSize: 16, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}

class DiscussionForumDialController extends GetxController {
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
}

class DiscussionForumDetailsPage extends StatefulWidget {
  const DiscussionForumDetailsPage({Key? key}) : super(key: key);

  @override
  State<DiscussionForumDetailsPage> createState() =>
      _DiscussionForumDetailsPageState();
}

class _DiscussionForumDetailsPageState extends State<DiscussionForumDetailsPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  final DiscussionForumDialController dialController = Get.put(
    DiscussionForumDialController(),
  );

  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

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

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      print('📤 Sending message: $message');
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _messageController.dispose();
    super.dispose();
  }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const CustomAppBarRow(),
                  const SizedBox(height: 10),
                  _buildHeaderCard(),
                  const SizedBox(height: 10),

                  // ✅ Proper Container with Expanded
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: const [
                          SenderMessage(
                            avatarUrl: "https://i.pravatar.cc/150?img=3",
                            sender: "Luke Tailor",
                            message: "Hello Buddy! 👋",
                            time: "08:12",
                          ),
                          ReceiverMessage(
                            message: "Lorem Ipsum is simply dummy text",
                            time: "08:13",
                          ),
                          SenderMessage(
                            avatarUrl: "https://i.pravatar.cc/150?img=3",
                            sender: "Luke Tailor",
                            message:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                            time: "08:14",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                    children:
                        [
                              // Video option
                              _buildSpeedDialOption(
                                "speed-dile-icon-video.svg",
                                "Video",
                                Colors.red.shade100,
                                () => dialController.selectOption("Video"),
                              ),
                              const SizedBox(
                                height: 16,
                              ), // Space between buttons
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
                            ].reversed
                            .toList(), // Reverse to have the first item at the bottom
                  ),
                ),
              );
            }),
          ],
        ),

        bottomNavigationBar: Container(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Expanded(
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
                      onTap: toggleDial, // Toggles the dial state when tapped
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
                    Container(width: 1, height: 10, color: AppColors.textblue),
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
          ),
        ),

        // // Bottom floating action button
        // floatingActionButton: Container(
        //   margin: const EdgeInsets.only(bottom: 20, right: 10),
        //   child: FloatingActionButton(
        //     onPressed: () {
        //      Get.to(DiscussionForumDetailsPage);
        //     },
        //     backgroundColor:AppColors.primary1,
        //     shape: const CircleBorder(), // Makes it perfectly round
        //     child: UIHelper.customSvg(svg: "add-icon.svg",color: AppColors.white),
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/75.jpg",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Json Jackson",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.textblue,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        "08:12",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            UIHelper.mediumText(
              text:
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
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
          //const SizedBox(width: 40),
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
