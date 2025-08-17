import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';
import 'package:learning_guru_app/widgets/base_button.dart';

class DiscussionForumCreate extends StatefulWidget {
  const DiscussionForumCreate({Key? key}) : super(key: key);

  @override
  State<DiscussionForumCreate> createState() => _DiscussionForumCreateState();
}

class _DiscussionForumCreateState extends State<DiscussionForumCreate> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();


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

                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // User Profile Section
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
                                  ),
                                ),
                                const SizedBox(width: 12),
                                UIHelper.boldText(text: "You (User Name)", fontSize: 14, color: AppColors.textblue,fontstyle: FontStyle.italic),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Question Title Input
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                 // topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: TextField(
                                controller: _titleController,
                                decoration: InputDecoration(
                                  hintText: 'Write your Question',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Question Description Input
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextField(
                                controller: _descriptionController,
                                maxLines: 6,
                                decoration: InputDecoration(
                                  hintText: 'Describe your question in detail..',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(height: 100), // Extra space for bottom button
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
          child: GradientButton(
            text: "Post Question",
            onTap: () {
              Get.back();
            },
          ),
        ),
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
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
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
            'Post Question',
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