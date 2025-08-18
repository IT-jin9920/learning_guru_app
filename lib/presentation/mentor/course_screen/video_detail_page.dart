import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../res/colors/app_color.dart';
import '../../../res/constants/constants.dart';
import '../../../utils/ui_helper.dart';
import 'VideoPreviewWidget.dart';
import 'upload_course/upload_course_screen.dart';

class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  bool isExpanded = false;

  final String aboutText =
      "Create a comprehensive interior scene with 3D objects, multiple light sources, textures and colors using intermediate modeling techniques. "
      "Create a comprehensive interior scene with 3D objects, multiple light sources, textures and colors using intermediate modeling techniques. "
      "Create a comprehensive interior scene with 3D objects, multiple light sources, textures and colors using intermediate modeling techniques. "
      "Create a comprehensive interior scene with 3D objects, multiple light sources, textures and colors using intermediate modeling techniques.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        //backgroundColor: Colors.transparent,
        // elevation: 0,
        // toolbarHeight: 70,
        // leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFCEDBF1),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
              ),
            ),
          ),
        ),
        actions: [
          _buildActionIcon(
            "dlt-svg-icon.svg",
                () {
              _showDeletAccountBottomSheet(context);
            },
          ),
          const SizedBox(width: 12),
          _buildActionIcon(
            "edit-icon-svg.svg",
                () {
              // Navigate to edit screen or show edit dialog
              //Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfilePage()));
                  Get.to(() => UploadCourseScreen(), arguments: {"mode": "edit", "courseId": 123});

                },
          ),
          const SizedBox(width: 16),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🎥 Thumbnail
            VideoPreviewWidget(),

            const SizedBox(height: 16),

            /// 🔤 Title
            UIHelper.boldText(
              text:
                  "Digital Poster Design: Combining Images & Type for Powerful Visuals",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.text,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),

            /// 🟦 Design Chip
            Container(
              height: 30,
              width: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.textblue,
                borderRadius: BorderRadius.circular(53),
              ),
              child: Center(
                child: UIHelper.boldText(
                  text: "Design",
                  fontSize: 12,
                  color: AppColors.white,
                ),
              ),
            ),

            const SizedBox(height: 19),

            /// Rating + Creator Info
            Row(
              children: [
                // Icon(Icons.star, color: AppColors.textblue, size: 18),
                UIHelper.customSvg(svg: "star-svg-icon.svg",color: AppColors.primary1, width: 16,height: 16),

                SizedBox(width: 4),
                UIHelper.boldText(
                  text: "4.2 (234 Ratings)",
                  fontSize: 12,
                  color: AppColors.primary1,
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                UIHelper.customImage(img: "user-1.png", width: 30, height: 30),
                SizedBox(width: 6),
                UIHelper.boldText(
                  text: "Davis Travis",
                  fontSize: 12,
                  color: AppColors.grey,
                ),
                SizedBox(width: 6),
                Container(width: 2, height: 10, color: AppColors.textblue),
                SizedBox(width: 6),
                UIHelper.regularText(
                  text: "Creator",
                  fontSize: 10,
                  color: AppColors.textblue,
                ),
              ],
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Date info
                  Container(
                    width:
                        MediaQuery.of(context).size.width / 2 -
                        25, // Responsive half-width with margin
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E2E9),
                      borderRadius: BorderRadius.circular(46),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        UIHelper.customSvg(svg: "time-svg-icon.svg"),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UIHelper.mediumText(
                                text: "Published on",
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: AppColors.grey,
                              ),

                              const SizedBox(height: 2),

                              Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '18',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: Transform.translate(
                                            offset: const Offset(0, -2), // move 'th' up
                                            child: Text(
                                              'th',
                                              style: TextStyle(
                                                fontSize: 8.5,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 4,),
                                  UIHelper.mediumText(
                                    text: "Mar 2024",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: AppColors.black,
                                  ),
                                ],
                              ),



                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Enrollment info
                  Container(
                    width:
                    MediaQuery.of(context).size.width / 2 -
                        25, // Responsive half-width with margin
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E2E9),
                      borderRadius: BorderRadius.circular(46),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        UIHelper.customSvg(svg: "enrolled-svg-iocn.svg"),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UIHelper.mediumText(
                                text: "Enrolled by",
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: AppColors.grey,
                              ),

                              const SizedBox(height: 2),
                              UIHelper.mediumText(
                                text: "1240 Students",
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// 📚 About Course
            UIHelper.boldText(
              text: "About Course",
              fontSize: 16,
              color: AppColors.text,
            ),
            const SizedBox(height: 4),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.regularText(
                  color: AppColors.grey,
                  text: aboutText,
                  fontSize: 14,
                  maxLines: isExpanded ? null : 3,
                  overflow: isExpanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    // Removes button padding
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: UIHelper.mediumText(
                      text: isExpanded ? "Read Less" : "Read More",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textblue,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// 🎯 What you'll learn
            UIHelper.boldText(
              text: "What you’ll learn:",
              fontSize: 16,
              color: AppColors.text,
            ),
            const SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                color: Color(0xffcddcf4),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  4,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // 👈 Align top of icon and text
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          // Fine-tune alignment
                          child: UIHelper.customSvg(
                            svg: "right-svg-icon.svg",
                            height: 20,
                            width: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: UIHelper.regularText(
                            text:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
                            fontSize: 14,
                            color: Color(0xff696f99),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// 🧩 Course Contents
            UIHelper.boldText(
              text: "Course Contents",
              fontSize: 16,
              color: AppColors.black,
            ),
            const SizedBox(height: 8),

            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                initiallyExpanded: isExpanded,
                onExpansionChanged: (value) {
                  setState(() {
                    isExpanded = value;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                leading: UIHelper.customSvg(
                  svg: isExpanded ?  "expand-icon-on.svg" : "expand-icon-off.svg",
                  height: 24,
                  width: 24,
                ),
                title: UIHelper.mediumText(
                  text: "Introduction & Software setup - New Blender 3.2",
                  fontSize: 14,
                  color: AppColors.text,
                ),
                subtitle: UIHelper.mediumText(
                  text: "5 Lessons | 1hr 40min",
                  fontSize: 12,
                  color: const Color(0xff9a99ac),
                ),
                children: [
                  lessonTile("An intro to the course and section 1", "15:25"),
                  lessonTile("Blender 4.2 Updates - Ao & Screen Space Reflections", "20:00"),
                  lessonTile("Moving Around the Scene", "25:15"),
                  lessonTile("Adding Objects", "15:00"),
                  lessonTile("Viewport & Rendering", "30:25"),
                  lessonTile("Detailed Steps for the Software workspace setup", "5 min Read"),
                ],
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                initiallyExpanded: isExpanded,
                onExpansionChanged: (value) {
                  setState(() {
                    isExpanded = value;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                leading: UIHelper.customSvg(
                  svg: isExpanded ?  "expand-icon-on.svg" : "expand-icon-off.svg",
                  height: 24,
                  width: 24,
                ),
                title: UIHelper.mediumText(
                  text: "Modular Dungeon - New Blender 3.2",
                  fontSize: 14,
                  color: AppColors.text,
                ),
                subtitle: UIHelper.mediumText(
                  text: "5 Lessons | 1hr 40min",
                  fontSize: 12,
                  color: const Color(0xff9a99ac),
                ),
                children: [
                  lessonTile("An intro to the course and section 1", "15:25"),
                  lessonTile("Blender 4.2 Updates - Ao & Screen Space Reflections", "20:00"),
                  lessonTile("Moving Around the Scene", "25:15"),
                  lessonTile("Adding Objects", "15:00"),
                  lessonTile("Viewport & Rendering", "30:25"),
                  lessonTile("Detailed Steps for the Software workspace setup", "5 min Read"),
                ],
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                initiallyExpanded: isExpanded,
                onExpansionChanged: (value) {
                  setState(() {
                    isExpanded = value;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                leading: UIHelper.customSvg(
                  svg: isExpanded ?  "expand-icon-on.svg" : "expand-icon-off.svg",
                  height: 24,
                  width: 24,
                ),
                title: UIHelper.mediumText(
                  text: "Low - Poly Structure Design",
                  fontSize: 14,
                  color: AppColors.text,
                ),
                subtitle: UIHelper.mediumText(
                  text: "5 Lessons | 1hr 40min",
                  fontSize: 12,
                  color: const Color(0xff9a99ac),
                ),
                children: [
                  lessonTile("An intro to the course and section 1", "15:25"),
                  lessonTile("Blender 4.2 Updates - Ao & Screen Space Reflections", "20:00"),
                  lessonTile("Moving Around the Scene", "25:15"),
                  lessonTile("Adding Objects", "15:00"),
                  lessonTile("Viewport & Rendering", "30:25"),
                  lessonTile("Detailed Steps for the Software workspace setup", "5 min Read"),
                ],
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                initiallyExpanded: isExpanded,
                onExpansionChanged: (value) {
                  setState(() {
                    isExpanded = value;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                leading: UIHelper.customSvg(
                  svg: isExpanded ?  "expand-icon-on.svg" : "expand-icon-off.svg",
                  height: 24,
                  width: 24,
                ),
                title: UIHelper.mediumText(
                  text: "UV Mapping & Mesh Modeling",
                  fontSize: 14,
                  color: AppColors.text,
                ),
                subtitle: UIHelper.mediumText(
                  text: "5 Lessons | 1hr 40min",
                  fontSize: 12,
                  color: const Color(0xff9a99ac),
                ),
                children: [
                  lessonTile("An intro to the course and section 1", "15:25"),
                  lessonTile("Blender 4.2 Updates - Ao & Screen Space Reflections", "20:00"),
                  lessonTile("Moving Around the Scene", "25:15"),
                  lessonTile("Adding Objects", "15:00"),
                  lessonTile("Viewport & Rendering", "30:25"),
                  lessonTile("Detailed Steps for the Software workspace setup", "5 min Read"),
                ],
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                initiallyExpanded: isExpanded,
                onExpansionChanged: (value) {
                  setState(() {
                    isExpanded = value;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                leading: UIHelper.customSvg(
                  svg: isExpanded ?  "expand-icon-on.svg" : "expand-icon-off.svg",
                  height: 24,
                  width: 24,
                ),
                title: UIHelper.mediumText(
                  text: "Rigging & Animation of Character",
                  fontSize: 14,
                  color: AppColors.text,
                ),
                subtitle: UIHelper.mediumText(
                  text: "5 Lessons | 1hr 40min",
                  fontSize: 12,
                  color: const Color(0xff9a99ac),
                ),
                children: [
                  lessonTile("An intro to the course and section 1", "15:25"),
                  lessonTile("Blender 4.2 Updates - Ao & Screen Space Reflections", "20:00"),
                  lessonTile("Moving Around the Scene", "25:15"),
                  lessonTile("Adding Objects", "15:00"),
                  lessonTile("Viewport & Rendering", "30:25"),
                  lessonTile("Detailed Steps for the Software workspace setup", "5 min Read"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {
                // Your onPressed logic here
              },
              child: Container(
                width: double.infinity,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.textblue,
                  borderRadius: BorderRadius.circular(48),
                ),
                child: UIHelper.boldText(text:  "See All Chapters", fontSize: 12, color: AppColors.white),
              ),
            ),

            const SizedBox(height: 20),

            /// 🧾 Course Includes
            UIHelper.boldText(text:  "Course Includes:",fontSize: 16, color:AppColors.text),
            const SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                color: Color(0xffE0E2E9),
                borderRadius: BorderRadius.circular(32),
              ),
              padding: EdgeInsets.fromLTRB(24, 24, 12, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  includeTile("Courses.svg", "Total 12 Chapters"),
                  SizedBox(height: 18),
                  includeTile("play-icon-svg.svg", "Total 60 Lesson"),
                  SizedBox(height: 18),
                  includeTile("time-icon-svg.svg", "120Hr Total to complete the course"),
                  SizedBox(height: 18),
                  includeTile("atrical-svg-icon.svg", "6 Articles to Read"),
                ],
              ),
            ),


            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget lessonTile(String title, String duration) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, bottom: 8, top: 8), // increased from 20 to 32
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelper.customSvg(
            svg: "course-play-svg-icon.svg",
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.mediumText(
                  text: title,
                  fontSize: 14,
                  color: AppColors.text,
                ),
                const SizedBox(height: 4),
                UIHelper.mediumText(
                  text: duration,
                  fontSize: 12,
                  color: const Color(0xff9a99ac),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget courseTile(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(Icons.expand_more, size: 20),
          SizedBox(width: 8),
          Text(title),
        ],
      ),
    );
  }

  Widget includeTile(String icon, String text) {
    return Row(
      children: [
        UIHelper.customSvg(svg: icon, height: 20, width: 20),
        SizedBox(width: 10),
        UIHelper.regularText(
          text: text,
          fontSize: 14,
          color: Color(0xff727293),
        ),
      ],
    );
  }


  Widget _buildActionIcon(String svgIcon, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: Color(0xFFE0E2E9),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: UIHelper.customSvg(svg: svgIcon, height: 18, width: 18),
      ),
    );
  }


  void _showDeletAccountBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppConstantsSpacing.paddingLarge),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: AppConstantsSpacing.spacingExtraLarge * 2),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                            height: 150,
                            decoration: const BoxDecoration(
                              color: Color(0xffe2eafb),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                height: 80,
                                width: 80,
                                child:UIHelper.customSvg(svg: "dlt-course-svg.svg"),
                              ),
                            ),
                          ),
                        ),

                        Column(
                          children: [
                            SizedBox(height: 24,),
                            UIHelper.boldText(text:   'Deleting Course?', fontSize: 18, color: AppColors.textblue,  fontWeight: FontWeight.bold,textAlign: TextAlign.center),
                            SizedBox(height: 16,),
                            UIHelper.regularText(text: 'Are you really want to delete your Uploaded Course? that will complete remove all course data.', fontSize: 14, color: AppColors.grey, textAlign: TextAlign.center),
                            SizedBox(height: 40,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
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
                                      child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
                                    ),
                                    onPressed: () => Get.back(),
                                  ),
                                  // const SizedBox(width: 12),
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
                                        // Save language and close
                                        Get.back();
                                      },
                                      child: const Text(
                                        'Yes Delete',
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
                            ),
                            SizedBox(height: MediaQuery.of(context).padding.bottom + AppConstantsSpacing.spacingLarge),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}
