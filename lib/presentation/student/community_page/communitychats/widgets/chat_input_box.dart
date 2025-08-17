import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import '../../../../../res/colors/app_color.dart';
import '../../../../../utils/ui_helper.dart';

class ChatInputBox extends StatefulWidget {
  final Function(String)? onMessageSent;
  final Function(String)? onAttachmentSelected;

  const ChatInputBox({Key? key, this.onMessageSent, this.onAttachmentSelected})
    : super(key: key);

  @override
  State<ChatInputBox> createState() => _ChatInputBoxState();
}

class _ChatInputBoxState extends State<ChatInputBox>
    with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  bool _isDialOpen = false;

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

  void _toggleDial() {
    setState(() {
      _isDialOpen = !_isDialOpen;
    });

    if (_isDialOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      widget.onMessageSent?.call(message);
      _messageController.clear();
      print('📤 Sending message: $message');
    }
  }

  void _handleAttachmentSelection(String type) {
    _toggleDial();
    widget.onAttachmentSelected?.call(type);
    print('📎 $type attachment selected');

    // TODO: Implement actual file picker logic
    switch (type.toLowerCase()) {
      case 'video':
        print('🎥 Opening video picker...');
        break;
      case 'image':
        print('📷 Opening image picker...');
        break;
      case 'document':
        print('📄 Opening document picker...');
        break;
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
    return Stack(
      children: [
        // Main chat input row
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Back button
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCEDBF1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8),
                  child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
                ),
              ),
              const SizedBox(width: 8),

              // Enhanced input container
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Enhanced link button
                      InkWell(
                        onTap: _toggleDial,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _isDialOpen
                                ? AppColors.textblue.withOpacity(0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: UIHelper.customImage(
                            img: "link-img.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Divider
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(width: 8),

                      // Text input field
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: "Write your message...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),

                      // Send button
                      InkWell(
                        onTap: _sendMessage,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.textblue,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.textblue.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: UIHelper.customImage(
                            img: "send-img.png",
                            width: 20,
                            height: 20,
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

        // Blur overlay when dial is open
        if (_isDialOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleDial,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(color: Colors.black.withOpacity(0.1)),
              ),
            ),
          ),

        // Enhanced SpeedDial
        if (_isDialOpen)
          Positioned(
            bottom: 60,
            left: 60,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SpeedDial(
                direction: SpeedDialDirection.up,
                animatedIcon: AnimatedIcons.menu_close,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                overlayColor: Colors.transparent,
                spaceBetweenChildren: 12.0,
                spacing: 8.0,
                elevation: 8.0,
                children: [
                  SpeedDialChild(
                    child: const Icon(Icons.videocam, color: Colors.red),
                    label: 'Video',
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    labelBackgroundColor: Colors.white,
                    backgroundColor: Colors.red.shade50,
                    onTap: () => _handleAttachmentSelection('Video'),
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.image, color: Colors.green),
                    label: 'Image',
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    labelBackgroundColor: Colors.white,
                    backgroundColor: Colors.green.shade50,
                    onTap: () => _handleAttachmentSelection('Image'),
                  ),
                  SpeedDialChild(
                    child: const Icon(
                      Icons.insert_drive_file,
                      color: Colors.blue,
                    ),
                    label: 'Document',
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    labelBackgroundColor: Colors.white,
                    backgroundColor: Colors.blue.shade50,
                    onTap: () => _handleAttachmentSelection('Document'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

// Legacy simplified chat input widget (kept for backward compatibility)
class ChatInput extends StatelessWidget {
  final Function(String)? onMessageSent;

  const ChatInput({Key? key, this.onMessageSent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Write your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onSubmitted: onMessageSent,
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // TODO: Implement send functionality
            },
          ),
        ],
      ),
    );
  }
}
