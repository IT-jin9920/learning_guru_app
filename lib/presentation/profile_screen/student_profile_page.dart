
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/profile_screen/setting_page/settings/settings_page.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';
import 'edit_profile_image/edit_mentorship_details_page.dart';
import 'edit_profile_image/edit_profileInfo_page.dart';
import 'edit_profile_image/edit_profile_image.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  File? _imageFile;
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xffEAF2FF),
        body: SingleChildScrollView(
          physics:PageScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 40),

              /// 🔹 Profile Stack (Header & Image)
              Stack(
                alignment: Alignment.center,
                children: [
                  // Background Circular SVG
                  SizedBox(
                    height: 450,
                    width: double.infinity,
                    child: Center(
                      child: SizedBox(
                        width: 450,
                        height: 450,
                        child: ClipOval(
                          child: UIHelper.customSvg(
                            svg: "img-bg.svg",
                            fit: BoxFit.cover,
                            color: const Color(0xffd2e0f6),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Circular Border
                  UIHelper.customSvg(
                    svg: "clip-profile-round-svg-icon.svg",
                    width: 170,
                    height: 170,
                  ),

                  // Profile Image
                  Positioned(
                    top: 155,
                    child: GestureDetector(
                      onTap: () => print("Profile image tapped"),
                      child: CircleAvatar(
                        radius: 71,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : const AssetImage("assets/images/user-3.png")
                          as ImageProvider,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: 102,
                    top: 270,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: SizedBox(
                        height: 16,
                        width: 16,
                        child: UIHelper.customSvgOnTap(
                          svg: "edit-icon-svg.svg",
                          onTap: _redireactToSetupProfile,
                        ),
                      ),
                    ),
                  ),

                  // Header and Settings
                  Positioned(
                    top: -8,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                UIHelper.customImage(
                                  img: "profile-hed-img.png",
                                  height: 45,
                                ),
                               // const SizedBox(width: 4),
                                UIHelper.boldText(
                                  text: 'Profile that ',
                                  fontSize: 22,
                                  color: AppColors.text,
                                ),
                                UIHelper.boldText(
                                  text: 'Praise!',
                                  fontSize: 22,
                                  color: AppColors.textblue,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: UIHelper.customSvgOnTap(
                                svg: "profile-head-setting-svg-icon.svg",
                                onTap: () => Get.to(() => SettingsScreen()),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: UIHelper.boldText(
                            text: "Your Insightful things",
                            fontSize: 16,
                            color: const Color(0xff96b4e5),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /// 🔹 White Info Section
              Transform.translate(
                offset: const Offset(0, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white, // ✅ Changed from red to white or your theme color
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, -3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(
                    20,
                    24,
                    20,
                    MediaQuery.of(context).padding.bottom + 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Name and Grade
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UIHelper.boldText(
                                text: "Alexandra",
                                fontSize: 18,
                                color: AppColors.text,
                                fontWeight: FontWeight.bold,
                              ),
                              UIHelper.boldText(
                                text: "Smith",
                                fontSize: 18,
                                color: AppColors.text,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          Container(
                            height: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF000042),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: UIHelper.customSvgOnTap(
                                    svg: "bag-iocon.svg",
                                    onTap: () {},
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 2,
                                  height: 10,
                                  color: AppColors.primary2,
                                ),
                                const SizedBox(width: 8),
                                UIHelper.boldText(
                                  text: "Standard 5",
                                  fontSize: 12,
                                  color: AppColors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      const Divider(
                        color: Color(0xFFCDDCF4),
                        thickness: 1,
                        height: 24,
                      ),

                      /// Personal Info Section
                      _editSection(
                        onEditTap: () {
                          Get.to(EditProfileinfoPage());
                        },
                        title: "Personal Info",
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 10, left: 10),
                            child: _infoTile(
                              svgPath: "phonenumber-icon-svg.svg",
                              label: "+1 556 656 1343",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, left: 10),
                            child: _infoTile(
                              svgPath: "email-icon-svg.svg",
                              label: "alexandrasmith@school.edu.com",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                            child: _infoTile(
                              svgPath: "age-icon-svg.svg",
                              label: "23rd Sep 2006",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


  Future<void> _redireactToSetupProfile() async {
    Get.to(() => const EditProfileImage());
  }

  Widget _editSection({
    required String title,
    VoidCallback? onEditTap,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            UIHelper.boldText(
              text: title,
              fontSize: 16,
              color: AppColors.text,
              fontWeight: FontWeight.bold,
            ),
            const Spacer(),
            SizedBox(
              height: 16,
              width: 16,
              child: UIHelper.customSvgOnTap(
                svg: "edit-icon-svg.svg",
                onTap: onEditTap ?? () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE6E8ED),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

}

class _infoTile extends StatelessWidget {
  final String svgPath; // SVG icon asset path
  final String label;
  final VoidCallback? onTap;

  const _infoTile({required this.svgPath, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: UIHelper.customSvg(svg: svgPath),
            ),
            const SizedBox(width: 10),
            Container(height: 15, width: 2, color: AppColors.primary1),
            const SizedBox(width: 10),
            Expanded(
              child: UIHelper.mediumText(
                text: label,
                fontSize: 14,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

