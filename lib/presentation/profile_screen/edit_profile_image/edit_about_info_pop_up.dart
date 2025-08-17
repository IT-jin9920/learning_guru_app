import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';

class EditAboutInfoPopUp extends StatefulWidget {
  const EditAboutInfoPopUp({super.key});

  @override
  State<EditAboutInfoPopUp> createState() => _EditAboutInfoPopUpState();
}

class _EditAboutInfoPopUpState extends State<EditAboutInfoPopUp> {
  final TextEditingController aboutController = TextEditingController(
    text:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
        "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
        "when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: FractionallySizedBox(
          heightFactor: 0.50,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFF03002F),
                      radius: 16,
                      child: UIHelper.customSvg(svg: "in-text-icon-svg.svg"),
                    ),
                    const SizedBox(width: 10),
                    UIHelper.boldText(
                      text: 'About Information',
                      fontSize: 14,
                      color: AppColors.text,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                /// Scrollable Text Input Section
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F0F0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            controller: aboutController,
                            style: const TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.5,
                            ),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              hintText: "Enter your about info...",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                /// Bottom Buttons
                Row(
                  children: [
                    IconButton(
                      icon: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFCEDBF1),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: UIHelper.customSvg(svg: "cancalled-icon-svg.svg"),
                      ),
                      onPressed: () => Get.back(),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF03002F),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        onPressed: () {
                          Get.back(); // Or your save logic
                        },
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'BeVietnamPro',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
