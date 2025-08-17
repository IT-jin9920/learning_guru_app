// No changes in imports
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_guru_app/presentation/profile_screen/setting_page/settings/settings_page.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;
import '../../core/services/storage_service.dart';
import '../../res/constants/constants.dart';
import '../../routes/app_routes.dart';
import '../authentication/setup_your_profile/setup_profile_page.dart';
import 'edit_profile_image/edit_about_info_pop_up.dart';
import 'edit_profile_image/edit_bank_details_page.dart';
import 'edit_profile_image/edit_certification_pop_up.dart';
import 'edit_profile_image/edit_certifications.dart';
import 'edit_profile_image/edit_mentorship_details_page.dart';
import 'edit_profile_image/edit_profileInfo_page.dart';
import 'edit_profile_image/edit_profile_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  int selectedTabIndex = 0;
  final RxList<String> Cirtifictaionfiles = <String>[
    'AadharCard.pdf',
    'Resume_2025.docx'
  ].obs;



  final DocumentUploadController docCtrl = Get.put(DocumentUploadController());
  final TextEditingController qualificationDesc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEAF2FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Title Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            /// Profile Image
                            UIHelper.customImage(
                              img: "profile-hed-img.png",
                              height: 45,
                            ),

                            /// Overlapping Text
                            Transform.translate(
                              offset: const Offset(-8, 0),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: UIHelper.boldText(
                                  text: 'Profile that ',
                                  fontSize: 22,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(-8, 0),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: UIHelper.boldText(
                                  text: 'Inform!',
                                  fontSize: 22,
                                  color: AppColors.textblue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: UIHelper.customSvgOnTap(
                            svg: "profile-head-setting-svg-icon.svg",
                            // onTap: () {
                            //   showDialog(
                            //     context: context,
                            //     builder: (context) => AlertDialog(
                            //       title: const Text("Logout"),
                            //       content: const Text(
                            //         "Are you sure you want to logout and clear all saved data?",
                            //       ),
                            //       actions: [
                            //         TextButton(
                            //           onPressed: () => Navigator.pop(context),
                            //           child: const Text("Cancel"),
                            //         ),
                            //         TextButton(
                            //           onPressed: () async {
                            //             Navigator.pop(context); // Close popup
                            //             await StorageService.clearAll(); // ✅ Clears SharedPreferences
                            //
                            //             // ✅ Navigate to splash or login page after clearing data
                            //             Navigator.pushNamedAndRemoveUntil(
                            //               context,
                            //               '/login',
                            //               // Replace with your login or splash route
                            //               (route) => false,
                            //             );
                            //           },
                            //           child: const Text("Logout"),
                            //         ),
                            //       ],
                            //     ),
                            //   );
                            // },
                            onTap: (){
                              Get.to(() => SettingsScreen());
                            },
                          ),
                        ),
                      ],
                    ),
        
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: UIHelper.boldText(
                        text: "Your Personal things",
                        fontSize: 16,
                        color: Color(0xff96b4e5),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 40),

                    /// Profile Picture with SVG border
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              UIHelper.customSvg(
                                svg: "clip-profile-round-svg-icon.svg",
                                width: 150,
                                height: 150,
                              ),

                              /// Profile Image
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: _imageFile != null
                                    ? FileImage(_imageFile!)
                                    : const AssetImage("assets/images/user-1.png")
                                as ImageProvider,
                                backgroundColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 10,
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
                      ],
                    ),

                    const SizedBox(height: 40),
        
                    /// Name & Charges
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UIHelper.boldText(
                              text: "Luke Tailor",
                              fontSize: 18,
                              color: AppColors.text,
                              fontWeight: FontWeight.bold,
                            ),
                            UIHelper.mediumText(
                              text: "Paediatrician",
                              fontSize: 12,
                              color: AppColors.textblue,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () =>  Get.to(() =>  EditMentorshipDetailsPage()),
                          child: Container(
                            height: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF000042),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                UIHelper.boldText(
                                  text: "Charges",
                                  fontSize: 12,
                                  color: AppColors.white,
                                ),
                                const SizedBox(width: 4),
                                Container(width: 2,height: 10,color: AppColors.primary2,),
                                const SizedBox(width: 4),

                                Row(
                                  children: [
                                    UIHelper.boldText(
                                      text: "\$",
                                      fontSize: 14,
                                     color: AppColors.primary2,
                                    ),
                                    UIHelper.boldText(
                                      text: "\10/Hr",
                                      fontSize: 14,
                                      color: AppColors.white,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 6),
                                SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: UIHelper.customSvgOnTap(
                                    svg: "edit-icon-svg.svg",
                                    onTap: () {},
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        
              /// Tabs
              Container(
                child: Row(
                  children: [
                    /// About Info Tab
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTabIndex = 0;
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white, // White background
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UIHelper.boldText(
                                text: "About Info",
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: selectedTabIndex == 0
                                    ? AppColors.textblue
                                    : AppColors.grey,
                              ),
                              const SizedBox(height: 8),
                              // Divider(
                              //   thickness: 1,
                              //   color: selectedTabIndex == 0
                              //       ? AppColors.text
                              //       : Colors.transparent,
                              //   indent: 32,
                              //   endIndent: 32,
                              // ),

                              LayoutBuilder(
                                builder: (context, constraints) {
                                  // You can use TextPainter if you want exact pixel width
                                  double textWidth = 74; // safe approx value or calculated dynamically

                                  return Center(
                                    child: SizedBox(
                                      width: textWidth, // restrict width to match text
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: 24, // fixed divider width
                                          height: 1,
                                          color: selectedTabIndex == 0
                                              ? AppColors.text
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                    /// Certifications Tab
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTabIndex = 1;
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white, // White background
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UIHelper.boldText(
                                text: "Certifications",
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: selectedTabIndex == 1
                                    ? AppColors.textblue
                                    : AppColors.grey,
                              ),
                              const SizedBox(height: 8),
                              // Divider(
                              //   thickness: 2,
                              //   color: selectedTabIndex == 1
                              //       ? Colors.blue
                              //       : Colors.transparent,
                              //   indent: 32,
                              //   endIndent: 32,
                              // ),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  // You can use TextPainter if you want exact pixel width
                                  double textWidth = 99; // safe approx value or calculated dynamically

                                  return Center(
                                    child: SizedBox(
                                      width: textWidth, // restrict width to match text
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: 24, // fixed divider width
                                          height: 1,
                                          color: selectedTabIndex == 1
                                              ? AppColors.text
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        
              /// Info Section Box
              selectedTabIndex == 0
                  ? Container(
                      width: double.infinity,
                      color: Colors.white,
                      // decoration: BoxDecoration(
                      //   color: Colors.white,
                      //   borderRadius: BorderRadius.circular(24),
                      // ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          /// Stats
                          Row(
                            children: [
                              _infoStatBox("130+ Students", "Consulted"),
                              const SizedBox(width: 12),
                              _infoStatBox("100+ Feedbacks", "Reviews"),
                            ],
                          ),
        
                          const SizedBox(height: 30),
        
                          // _editSection(
                          //   onEditTap: () {
                          //     Get.to(
                          //       () => EditProfileinfoPage(),
                          //     ); // ⬅️ Your destination page
                          //   },
                          //   title: "Personal Info",
                          //   children: const [
                          //     Padding(
                          //       padding: EdgeInsets.only(top: 20, left: 15),
                          //       child: _infoTile(
                          //         svgPath: "phonenumber-icon-svg.svg",
                          //         label: "+1 556 656 1343",
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding: EdgeInsets.only(top: 20, left: 15),
                          //       child: _infoTile(
                          //         svgPath: "email-icon-svg.svg",
                          //         label: "alexandrasmith@school.edu.com",
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding: EdgeInsets.only(
                          //         top: 20,
                          //         left: 15,
                          //         bottom: 20,
                          //       ),
                          //       child: _infoTile(
                          //         svgPath: "rating-svg-icon.svg",
                          //         label: "4.5 Rating",
                          //       ),
                          //     ),
                          //   ],
                          // ),

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
                                    padding: EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                      bottom: 10,
                                    ),
                                    child: _infoTile(
                                      svgPath: "rating-svg-icon.svg",
                                      label: "4.5 Rating",
                                    ),
                                  ),
                            ],
                          ),
                          const SizedBox(height: 30),
        
                          _editSection(
                            onEditTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => const EditAboutInfoPopUp(),
                              );
                            },
        
                            title: "About Info",
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: UIHelper.regularText(
                                  text:
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                  fontSize: 14,
                                  color:Color(0xff767696),
                                ),
                              ),
                            ],
                          ),
        
                          const SizedBox(height: 20),
        
                          /// Bank Details Button
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFFCDDCF4),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundColor:AppColors.text,
                                      // child: Icon(
                                      //   Icons.account_balance,
                                      //   color: Colors.white,
                                      //   size: 16,
                                      // ),
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: UIHelper.customSvg(
                                          svg: "bank-icon-svg.svg",
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    UIHelper.boldText(
                                      text: "Bank Details",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: AppColors.text,
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const EditBankDetailsPage());
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: AppColors.primary1),
                                      borderRadius: BorderRadius.circular(82),
                                    ),
                                    child: Row(
                                      //mainAxisSize: MainAxisSize.min,
                                      children:  [
                                        UIHelper.boldText(
                                          text: "See",
                                          fontSize: 12,
                                          color: AppColors.text,
                                        ),
                                        SizedBox(width: 4),
                                        UIHelper.customSvg(svg: "right-arrow-icon-svg.svg"),
                                      ],
                                    ),
                                  ),
                                ),
        
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      color: AppColors.white,
                      // decoration: BoxDecoration(
                      //   color: Colors.white,
                      //   borderRadius: BorderRadius.circular(24),
                      // ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          _buildDocumentSection(
                            'Qualification',
                            Icons.description_outlined,
                            true,
                            Cirtifictaionfiles,
                          ),
        
                          SizedBox(height: 30),
        
                          _qualificationSection(
                            onEditTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => const EditCertificationPopUp(),
                              );
                            },
        
                            title: "Qualifications Info",
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: UIHelper.regularText(
                                  text:
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                  fontSize: 14,
                                  color: AppColors.text,
                                ),
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
    );
  }

  Widget _infoStatBox(String title, String subtitle) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFDCE4F8),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            UIHelper.mediumText(
              text: subtitle,
              fontSize: 12,
              color: AppColors.textblue,
            ),
            const SizedBox(height: 6),
            UIHelper.boldText(
              text: title,
              fontSize: 14,
              color: AppColors.text,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE6E8ED),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _qualificationSection({
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE6E8ED),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Future<void> _redireactToSetupProfile() async {
    Get.to(() => const EditProfileImage());
  }

  Widget _buildDocumentSection(
      String category,
      IconData icon,
      bool isQualification,
      RxList<String> files,
      ) {
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(
        horizontal:18,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: AppColors.roundbg,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          /// Header Row
          GestureDetector(
            onTap: (){
              Get.to(() =>  EditCertifications());
            },
            child: Row(
              children: [
                // Container(
                //   padding: const EdgeInsets.all(8),
                //   decoration: const BoxDecoration(
                //     color: Colors.black,
                //     shape: BoxShape.circle,
                //   ),
                //   child: Icon(
                //     icon,
                //     color: AppColors.white,
                //     size: AppConstants.iconSizeMedium,
                //   ),
                // ),
                //const SizedBox(width: AppConstants.spacingMedium),
                Expanded(
                  // child: Text(
                  //   category,
                  //   style: const TextStyle(
                  //     fontFamily: 'BeVietnamPro',
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w600,
                  //     color: AppColors.text,
                  //   ),
                  // ),
                  child: UIHelper.boldText(text: category, fontSize: 14, color: AppColors.text),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: UIHelper.customSvg(svg: "right-arrow-svg-icon.svg",),
                ),
              ],
            ),
          ),

          /// Document List
          Padding(
            padding: const EdgeInsets.only(top: AppConstants.paddingSmall),
            child: files.isEmpty
                ? const Center(
              child: Text(
                "No documents uploaded",
                style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            )
                : Column(
              children: files.asMap().entries.map((entry) {
                final index = entry.key;
                final fileName = entry.value;

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingMedium,
                    vertical: AppConstants.paddingSmall,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffccdaf2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                     UIHelper.customSvg(svg: "documnts-icon.svg",),
                      const SizedBox(width: AppConstants.spacingSmall),
                      Expanded(
                        child: UIHelper.mediumText(text: fileName, fontSize: 12, color: AppColors.text),

                      ),
                      GestureDetector(
                        onTap: () => _removeFile(index, files),
                        child:UIHelper.customSvg(svg: "documnats-dlt-icon.svg", color: Color(0xffC80101)),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ));
  }



  void _removeFile(int index, RxList<String> files) {
    files.removeAt(index);
  }


}

class DocumentUploadController extends GetxController {
  final RxList<String> qualificationFiles = <String>[].obs;
  final RxList<String> certificateFiles = <String>[].obs;

  // Future<void> pickFile({required bool isQualification}) async {
  //   try {
  //     // Detect Android version
  //     int sdkInt = 0;
  //     if (Platform.isAndroid) {
  //       final androidInfo = await DeviceInfoPlugin().androidInfo;
  //       sdkInt = androidInfo.version.sdkInt;
  //       print("📱 Android SDK Version: $sdkInt");
  //     }
  //
  //     // Request proper permission based on version
  //     PermissionStatus permission;
  //     if (Platform.isAndroid && sdkInt >= 33) {
  //       permission = await Permission.photos.request(); // Android 13+ (Scoped)
  //     } else {
  //       permission = await Permission.storage.request(); // Android < 13
  //     }
  //
  //     if (!permission.isGranted) {
  //       if (permission.isPermanentlyDenied) {
  //         openAppSettings();
  //         showError("Permission permanently denied. Enable from settings.");
  //       } else {
  //         showError("Permission denied.");
  //       }
  //       return;
  //     }
  //
  //     // Open file picker
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
  //     );
  //
  //     if (result == null || result.files.single.path == null) {
  //       showError("No file selected.");
  //       return;
  //     }
  //
  //     final file = File(result.files.single.path!);
  //     final extension = p.extension(file.path).toLowerCase();
  //     final fileSizeInMB = await file.length() / (1024 * 1024);
  //
  //     // Validate extension
  //     if (!['.pdf', '.jpg', '.jpeg', '.png'].contains(extension)) {
  //       showError("Only PDF, PNG, JPG files are allowed.");
  //       return;
  //     }
  //
  //     // Validate file size
  //     if (fileSizeInMB > 5) {
  //       showError("File must be less than 5MB.");
  //       return;
  //     }
  //
  //     // Add file to the correct list
  //     final fileName = p.basename(file.path);
  //     if (isQualification) {
  //       qualificationFiles.add(fileName);
  //     } else {
  //       certificateFiles.add(fileName);
  //     }
  //
  //     showSuccess("File uploaded successfully.");
  //     print("✅ File uploaded: $fileName (${fileSizeInMB.toStringAsFixed(2)} MB)");
  //
  //   } on PlatformException catch (e) {
  //     showError("Platform Error: ${e.message ?? 'Unknown error'}");
  //     print("⚠️ PlatformException: ${e.message}");
  //   } on FileSystemException catch (e) {
  //     showError("File System Error: ${e.message}");
  //     print("⚠️ FileSystemException: ${e.message}");
  //   } catch (e) {
  //     showError("Something went wrong: ${e.toString()}");
  //     print("⚠️ Exception: $e");
  //   }
  // }

  Future<void> pickFile({required bool isQualification}) async {
    try {
      // Detect Android version
      int sdkInt = 0;
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        sdkInt = androidInfo.version.sdkInt;
        print("📱 Android SDK Version: $sdkInt");
      }

      // Request proper permission based on version
      PermissionStatus permission;
      if (Platform.isAndroid && sdkInt >= 33) {
        permission = await Permission.photos.request();
      } else {
        permission = await Permission.storage.request();
      }

      if (!permission.isGranted) {
        if (permission.isPermanentlyDenied) {
          openAppSettings();
          showError("Permission permanently denied. Enable from settings.");
        } else {
          showError("Permission denied.");
        }
        return;
      }

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result == null || result.files.single.path == null) {
        showError("No file selected.");
        return;
      }

      final file = File(result.files.single.path!);
      final extension = p.extension(file.path).toLowerCase();
      final fileSizeInMB = await file.length() / (1024 * 1024);

      if (!['.pdf', '.jpg', '.jpeg', '.png'].contains(extension)) {
        showError("Only PDF, PNG, JPG files are allowed.");
        return;
      }

      if (fileSizeInMB > 5) {
        showError("File must be less than 5MB.");
        return;
      }

      // Assign default name like Document 1, Document 2, ...
      String documentName;
      if (isQualification) {
        documentName = "qualificationFiles ${qualificationFiles.length + 1}";
        qualificationFiles.add(documentName);
      } else {
        documentName = "certificateFiles ${certificateFiles.length + 1}";
        certificateFiles.add(documentName);
      }

      showSuccess("File uploaded successfully.");
      print(
        "✅ File uploaded: $documentName (${fileSizeInMB.toStringAsFixed(2)} MB)",
      );
    } on PlatformException catch (e) {
      showError("Platform Error: ${e.message ?? 'Unknown error'}");
      print("⚠️ PlatformException: ${e.message}");
    } on FileSystemException catch (e) {
      showError("File System Error: ${e.message}");
      print("⚠️ FileSystemException: ${e.message}");
    } catch (e) {
      showError("Something went wrong: ${e.toString()}");
      print("⚠️ Exception: $e");
    }
  }

  void removeFile({required bool isQualification, required int index}) {
    if (isQualification) {
      qualificationFiles.removeAt(index);
    } else {
      certificateFiles.removeAt(index);
    }
  }

  void showError(String message) {
    Get.snackbar(
      "Error",
      message,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.red.shade800,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void showSuccess(String message) {
    Get.snackbar(
      "Success",
      message,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade800,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}


// class DocumentUploadController extends GetxController {
//   final RxList<String> qualificationFiles = <String>[].obs;
//   final RxList<String> certificateFiles = <String>[].obs;
//
//   Future<void> pickFile({required bool isQualification}) async {
//     final permission = Platform.isAndroid
//         ? await Permission.storage.request()
//         : await Permission.photos.request();
//
//     if (permission.isGranted) {
//       try {
//         final result = await FilePicker.platform.pickFiles(
//           type: FileType.custom,
//           allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
//         );
//
//         if (result != null && result.files.single.path != null) {
//           final file = File(result.files.single.path!);
//           final extension = p.extension(file.path).toLowerCase();
//           final fileSizeInMB = await file.length() / (1024 * 1024);
//
//           if (!['.pdf', '.jpg', '.jpeg', '.png'].contains(extension)) {
//             showError("Only PDF, PNG, JPG files are allowed.");
//             return;
//           }
//
//           if (fileSizeInMB > 5) {
//             showError("File must be less than 5MB.");
//             return;
//           }
//
//           if (isQualification) {
//             qualificationFiles.add(p.basename(file.path));
//           } else {
//             certificateFiles.add(p.basename(file.path));
//           }
//           showSuccess("File uploaded successfully.");
//         } else {
//           showError("No file selected.");
//         }
//       } catch (e) {
//         showError("Error: ${e.toString()}");
//       }
//     } else if (permission.isPermanentlyDenied) {
//       openAppSettings();
//       showError("Permission permanently denied. Enable from settings.");
//     } else {
//       showError("Permission denied.");
//     }
//   }
//
//   void removeFile({required bool isQualification, required int index}) {
//     if (isQualification) {
//       qualificationFiles.removeAt(index);
//     } else {
//       certificateFiles.removeAt(index);
//     }
//   }
//
//   void showError(String message) {
//     Get.snackbar(
//       "Error",
//       message,
//       backgroundColor: Colors.red.shade100,
//       colorText: Colors.red.shade800,
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
//
//   void showSuccess(String message) {
//     Get.snackbar(
//       "Success",
//       message,
//       backgroundColor: Colors.green.shade100,
//       colorText: Colors.green.shade800,
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
// }

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
        padding: const EdgeInsets.symmetric(vertical: 6),
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
