import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_guru_app/presentation/student/community_page/chat_details_page/widgets/chate_app_bar.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import '../../../../utils/ui_helper.dart';
import '../communitychats/widgets/senderloder.dart';
import 'widgets/receiver_message.dart';
import 'widgets/sender_image_message.dart';
import 'widgets/sender_message.dart';

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

class ChatDetails extends StatefulWidget {
  const ChatDetails({Key? key}) : super(key: key);

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  final DialController dialController = Get.put(DialController());

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
            Positioned(right: 0, top: -35, child: _buildDecorativeBackground()),
            SafeArea(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [CustomAppBarRow(), SizedBox(height: 10)],
                    ),
                  ),
                  SliverToBoxAdapter(
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
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        children: const [
                          SenderMessage(
                            sender: "Luke Tailor",
                            message: "Hello Buddy! 👋",
                            time: "08:12",
                          ),
                          ReceiverMessage(
                            message: "Hi Luke! How's it going?",
                            time: "08:13",
                          ),
                          SenderMessage(
                            sender: "Luke Tailor",
                            message:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                            time: "08:14",
                          ),
                          SenderImageMessage(
                            sender: "Luke Tailor",
                            imagePaths: ["img-1.png", "img-2.png"],
                            time: "08:15",
                          ),
                          Senderloder(loder: "lod-img.png"),
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
                    _animationController.reverse();  // Reverse animation
                    dialController.closeDial();  // Close the dial
                  },
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),  // Apply the blur
                    child: Container(
                      color: Colors.black.withOpacity(0.3),  // Apply slight opacity
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
                bottom: 20,  // Adjust position to avoid covering the whole page
                left: 70,    // Adjust the horizontal positioning of speed dial options
                child: FadeTransition(
                  opacity: _fadeAnimation,  // Apply fade animation for smooth transition
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
                      const SizedBox(height: 16),  // Space between buttons

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
                    ].reversed.toList(),  // Reverse to have the first item at the bottom
                  ),
                ),
              );
            }),

          ],
        ),

        // bottomNavigationBar: Container(
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black.withOpacity(0.1),
        //         blurRadius: 10,
        //         offset: const Offset(0, -2),
        //       ),
        //     ],
        //   ),
        //   padding: EdgeInsets.only(
        //     bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        //     left: 16,
        //     right: 16,
        //     top: 8,
        //   ),
        //   child: Stack(
        //     clipBehavior: Clip.none,
        //     children: [
        //       Row(
        //         children: [
        //           GestureDetector(
        //             onTap: () => Navigator.pop(context),
        //             child: Container(
        //               height: 52,
        //               //width: 40,
        //               decoration: BoxDecoration(
        //                 color: const Color(0xFFCEDBF1),
        //                 shape: BoxShape.circle,
        //                 boxShadow: [
        //                   BoxShadow(
        //                     color: Colors.black.withOpacity(0.1),
        //                     blurRadius: 4,
        //                     offset: const Offset(0, 2),
        //                   ),
        //                 ],
        //               ),
        //               padding: const EdgeInsets.all(8),
        //               child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
        //             ),
        //           ),
        //           const SizedBox(width: 8),
        //           Expanded(
        //             child: Container(
        //               padding: const EdgeInsets.symmetric(
        //                 horizontal: 16,
        //                 vertical: 8,
        //               ),
        //               decoration: BoxDecoration(
        //                 color: Colors.white,
        //                 borderRadius: BorderRadius.circular(25),
        //                 border: Border.all(
        //                   color: Colors.grey.shade300,
        //                   width: 1,
        //                 ),
        //                 boxShadow: [
        //                   BoxShadow(
        //                     color: Colors.black.withOpacity(0.05),
        //                     blurRadius: 8,
        //                     offset: const Offset(0, 2),
        //                   ),
        //                 ],
        //               ),
        //               child: Row(
        //                 children: [
        //                   InkWell(
        //                     onTap: toggleDial,
        //                     borderRadius: BorderRadius.circular(15),
        //                     child: Container(
        //                       padding: const EdgeInsets.all(8),
        //                       decoration: BoxDecoration(
        //                         color: dialController.isDialOpen.value
        //                             ? AppColors.textblue.withOpacity(0.1)
        //                             : Colors.transparent,
        //                         borderRadius: BorderRadius.circular(15),
        //                       ),
        //                       child: UIHelper.customImage(
        //                         img: "link-img.png",
        //                         width: 20,
        //                         height: 20,
        //                       ),
        //                     ),
        //                   ),
        //                   const SizedBox(width: 8),
        //                   Container(
        //                     width: 1,
        //                     height: 20,
        //                     color: Colors.grey.shade300,
        //                   ),
        //                   const SizedBox(width: 8),
        //                   Expanded(
        //                     child: TextField(
        //                       controller: _messageController,
        //                       decoration: const InputDecoration(
        //                         hintText: "Write your message...",
        //                         border: InputBorder.none,
        //                         hintStyle: TextStyle(color: Colors.grey),
        //                       ),
        //                       maxLines: null,
        //                       textCapitalization: TextCapitalization.sentences,
        //                     ),
        //                   ),
        //                   InkWell(
        //                     onTap: _sendMessage,
        //                     borderRadius: BorderRadius.circular(20),
        //                     child: Container(
        //                       padding: const EdgeInsets.all(8),
        //                       decoration: BoxDecoration(
        //                         color: AppColors.textblue,
        //                         shape: BoxShape.circle,
        //                         boxShadow: [
        //                           BoxShadow(
        //                             color: AppColors.textblue.withOpacity(0.3),
        //                             blurRadius: 8,
        //                             offset: const Offset(0, 2),
        //                           ),
        //                         ],
        //                       ),
        //                       child: UIHelper.customImage(
        //                         img: "send-img.png",
        //                         width: 20,
        //                         height: 20,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //       // Obx(() {
        //       //   if (!dialController.isDialOpen.value) return const SizedBox.shrink();
        //       //   return Positioned(
        //       //     bottom: 60,
        //       //     left: 20,
        //       //     child: FadeTransition(
        //       //       opacity: _fadeAnimation,
        //       //       child: Column(
        //       //         mainAxisSize: MainAxisSize.min,
        //       //         children: [
        //       //           _buildSpeedDialOption(
        //       //             Icons.videocam,
        //       //             "Video",
        //       //             Colors.red.shade100,
        //       //                 () => dialController.selectOption("Video"),
        //       //           ),
        //       //           const SizedBox(height: 16),
        //       //           _buildSpeedDialOption(
        //       //             Icons.image,
        //       //             "Image",
        //       //             Colors.green.shade100,
        //       //                 () => dialController.selectOption("Image"),
        //       //           ),
        //       //           const SizedBox(height: 16),
        //       //           _buildSpeedDialOption(
        //       //             Icons.insert_drive_file,
        //       //             "Document",
        //       //             Colors.blue.shade100,
        //       //                 () => dialController.selectOption("Document"),
        //       //           ),
        //       //         ].reversed.toList(),
        //       //       ),
        //       //     ),
        //       //   );
        //       // }),
        //     ],
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
                              onTap: toggleDial,  // Toggles the dial state when tapped
                              child:Obx(() {
                                print('Dial Open: ${dialController.isDialOpen.value}'); // Debugging log
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
    return UIHelper.customSvg(svg: "bg.svg", fit: BoxFit.cover);
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
          borderRadius: BorderRadius.circular(25),  // Clip to make the SVG inside round
          child: Container(
            color: AppColors.text,
            width: 40,  // Size of the container
            height: 40,
            child: Center(
              child: UIHelper.customSvg(
                svg: svg,  // Pass the SVG path here
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
