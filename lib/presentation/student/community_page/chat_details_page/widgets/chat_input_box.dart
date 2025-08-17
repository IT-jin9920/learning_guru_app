//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../res/colors/app_color.dart';
// import '../../../utils/ui_helper.dart';
//
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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/mentor/chat_screen/chat_page.dart';

import '../../../../../res/colors/app_color.dart';
import '../../../../../utils/ui_helper.dart';


class ChatInputBox extends StatefulWidget {
  const ChatInputBox({Key? key}) : super(key: key);

  @override
  State<ChatInputBox> createState() => _ChatInputBoxState();
}

class _ChatInputBoxState extends State<ChatInputBox> {
  bool _isDialOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
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
                      onTap: () {
                        setState(() {
                          _isDialOpen = !_isDialOpen;
                        });
                      },
                      child: UIHelper.customImage(
                        img: "link-img.png",
                        width: 20,
                        height: 20,
                      ),
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
          ],
        ),

        // Blur Background when Dial is Open
        if (_isDialOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: () => setState(() => _isDialOpen = false),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.black.withOpacity(0.2)),
              ),
            ),
          ),

        // SpeedDial (bottom to top) from Link Icon
        if (_isDialOpen)
          Positioned(
            bottom: 60, // Height above input box
            left: 60, // Adjust so it aligns with link icon position
            child: SpeedDial(
              direction: SpeedDialDirection.up,
              animatedIcon: AnimatedIcons.menu_close,
              backgroundColor: Colors.teal.shade100,
              foregroundColor: Colors.black,
              overlayColor: Colors.transparent,
              spaceBetweenChildren: 12.0,
              spacing: 8.0,
              children: [
                SpeedDialChild(
                  child: const Icon(Icons.videocam),
                  label: 'Video',
                  onTap: () => print('Video Selected'),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.image),
                  label: 'Image',
                  onTap: () => print('Image Selected'),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.insert_drive_file),
                  label: 'Document',
                  onTap: () => print('Document Selected'),
                ),
              ],
            ),
          ),
      ],
    );
  }
}


// A simplified chat input widget
class ChatInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // The container for the entire input area
      padding: EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        children: [
          // Back button or other icons
          IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
          SizedBox(width: 8.0),

          // The text input field
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Write your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
          ),
          SizedBox(width: 8.0),

          // The Send button
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              // This is where we could trigger the pop-up
              // or send the message.
              // For the pop-up, we'd need to manage state.
            },
          ),
        ],
      ),
    );
  }
}
