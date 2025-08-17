import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/widgets/base_button.dart';
import 'package:learning_guru_app/widgets/custome_color_bg.dart';

import '../../../core/services/storage_service.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/constants/constants.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../utils/ui_helper.dart';
import '../bank_details_page/bank_details_page.dart';
import '../setup_your_profile/profile_setup_page.dart';
import '../setup_your_profile/setup_profile_page.dart';

class MentoringSetupScreen extends StatefulWidget {
  const MentoringSetupScreen({super.key});

  @override
  State<MentoringSetupScreen> createState() => _MentoringSetupScreenState();
}

class _MentoringSetupScreenState extends State<MentoringSetupScreen> {
  bool _isByProfessionSelected = true;

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  void _fetchUserRole() async {
    final role = await StorageService.getUserRole();
    print("User role from StorageService: $role");

    if (role != null && role.isNotEmpty) {
      setState(() {
        userRole = role; // This triggers UI rebuild
      });
    }
  }

  String userRole = ''; // Example: "Mentor", "Teacher", etc.

  // @override
  // Widget build(BuildContext context) {
  //   return GradientBackground(
  //     child: Scaffold(
  //       //backgroundColor: AppColors.white,
  //       backgroundColor: Colors.transparent,
  //       appBar: AppBar(
  //         backgroundColor: AppColors.white,
  //         elevation: 0,
  //         leading: Padding(
  //           padding: const EdgeInsets.only(left: 16),
  //           child: GestureDetector(
  //             onTap: () {
  //               // Navigator.push(
  //               //   context,
  //               //   MaterialPageRoute(builder: (context) => const SetupProfileScreen()),
  //               // );
  //               Get.back();
  //             },
  //             child: Container(
  //               height: 40,
  //               width: 40,
  //               decoration: const BoxDecoration(
  //                 color: Color(0xFFCEDBF1), // #CEDBF1
  //                 shape: BoxShape.circle,
  //               ),
  //               padding: const EdgeInsets.all(8),
  //               child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
  //             ),
  //           ),
  //         ),
  //         toolbarHeight: 80,
  //       ),
  //       body: SingleChildScrollView(
  //         padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLarge),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //
  //             UIHelper.boldText(
  //               text:  'Mentoring Setup',
  //               fontSize: 32,
  //               color: AppColors.textblue,
  //               fontWeight: FontWeight.bold,
  //             ),
  //
  //             const SizedBox(height: AppConstants.spacingSmall),
  //
  //             UIHelper.mediumText(
  //               text:
  //               'Provide us a little more details about you',
  //               fontSize: 14,
  //               color: AppColors.grey,
  //               fontWeight: FontWeight.normal,
  //             ),
  //
  //
  //             const SizedBox(height: AppConstants.spacingExtraLarge),
  //
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       setState(() {
  //                         _isByProfessionSelected = true;
  //                       });
  //                     },
  //                     child: AnimatedContainer(
  //                       duration: const Duration(milliseconds: 250),
  //                       height: 50,
  //                       decoration: BoxDecoration(
  //                         color:  AppColors.lightgreencolor,
  //                         borderRadius: BorderRadius.circular(28),
  //                         border: Border.all(
  //                           color: _isByProfessionSelected
  //                               ? AppColors.primary1
  //                               : Colors.transparent,
  //                           width: 1.5,
  //                         ),
  //                       ),
  //                       alignment: Alignment.center,
  //                       child:
  //                       UIHelper.mediumText(
  //                         text:
  //                         'By Profession',
  //                         fontSize: 14,
  //                         fontWeight:
  //                         _isByProfessionSelected ? FontWeight.bold : FontWeight.normal,
  //                         color: _isByProfessionSelected
  //                             ? AppColors.primary1
  //                             : AppColors.text.withOpacity(0.7),
  //                       ),
  //
  //
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(width: AppConstants.spacingMedium),
  //                 Expanded(
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       setState(() {
  //                         _isByProfessionSelected = false;
  //                       });
  //                     },
  //                     child: AnimatedContainer(
  //                       duration: const Duration(milliseconds: 250),
  //                       height: 50,
  //                       decoration: BoxDecoration(
  //                         color:  AppColors.lightgreencolor,
  //                         borderRadius: BorderRadius.circular(28),
  //                         border: Border.all(
  //                           color: !_isByProfessionSelected
  //                               ? AppColors.primary1
  //                               : Colors.transparent,
  //                           width: 1.5,
  //                         ),
  //                       ),
  //                       alignment: Alignment.center,
  //                       child:
  //
  //                       UIHelper.mediumText(
  //                         text:
  //                         'By Lifecoaching',
  //                         fontSize: 14,
  //                         fontWeight: !_isByProfessionSelected
  //                             ? FontWeight.bold
  //                             : FontWeight.normal,
  //                         color: !_isByProfessionSelected
  //                             ? AppColors.primary1
  //                             : AppColors.text.withOpacity(0.7),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //
  //               ],
  //             ),
  //
  //             const SizedBox(height: AppConstants.spacingMedium),
  //
  //             if (userRole == 'mentor') ...[
  //               _buildDropdownField('Mentorship Category', Icons.keyboard_arrow_down_rounded),
  //               const SizedBox(height: AppConstants.spacingMedium),
  //               _buildDropdownField('Mentorship Sub Category', Icons.keyboard_arrow_down_rounded),
  //             ] else if (userRole == 'tutor') ...[
  //               _buildDropdownField('Teaching Field', Icons.keyboard_arrow_down_rounded),
  //             ],
  //
  //             const SizedBox(height: AppConstants.spacingMedium),
  //             _buildInputField('Hourly Charges', Icons.attach_money_rounded),
  //
  //
  //             if (userRole == 'mentor')
  //               const SizedBox(height: AppConstants.spacingExtraLarge * 4),
  //               const SizedBox(height: AppConstants.spacingExtraLarge * 0.44),
  //
  //
  //             GradientButton(text: "Proceed Further", onTap: () async {
  //               debugPrint('Proceed Further tapped on Mentoring Setup');
  //                   // Navigator.push(
  //                   //   context,
  //                   //   MaterialPageRoute(builder: (context) => const BankDetailsPage()),
  //                   // );
  //
  //               // await StorageService.isMentoringSetup(true);
  //               await StorageService.setMentoringSetup(true);
  //               print("setMentoringSetup true");
  //               Get.to(() => BankDetailsPage());
  //             }),
  //
  //             SizedBox(
  //                 height: MediaQuery.of(context).padding.bottom +
  //                     AppConstants.spacingLarge),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildDropdownField(String hintText, IconData suffixIcon) {
  //   return Container(
  //     height: 56,
  //     padding: const EdgeInsets.only(right: 4, left: 19),
  //     decoration: BoxDecoration(
  //       color: AppColors.lightgreencolor,
  //       borderRadius: BorderRadius.circular(28),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //
  //         UIHelper.mediumText(text:  hintText, fontSize: 14, color: AppColors.black),
  //         Container(
  //           width: 45,
  //           height: 45,
  //           decoration: const BoxDecoration(
  //             color: Colors.white,
  //             shape: BoxShape.circle,
  //           ),
  //           alignment: Alignment.center, // Center the child inside the circle
  //           child: SizedBox(
  //             width: 12,
  //             height: 6,
  //             child: UIHelper.customSvg(
  //               svg: "bottamside-arrow-icon-svg.svg",
  //               fit: BoxFit.contain, // Ensures proper scale within SizedBox
  //             ),
  //           ),
  //         ),
  //
  //
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildInputField(String hintText, IconData suffixIcon) {
  //   return TextField(
  //     keyboardType: TextInputType.number,
  //     style: const TextStyle(fontFamily: 'BeVietnamPro', fontSize: 16, color: AppColors.text),
  //     decoration: InputDecoration(
  //
  //       filled: true,
  //       fillColor: AppColors.lightgreencolor,
  //       hintText: hintText,
  //       hintStyle: AppFontStyles.beVietnamProMedium500.copyWith(
  //         fontSize: 16,
  //         color: AppColors.grey, // hint text color
  //       ),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(28),
  //         borderSide: BorderSide.none,
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(28),
  //         borderSide: BorderSide.none,
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(28),
  //         borderSide: BorderSide.none,
  //       ),
  //       contentPadding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium, vertical: 18),
  //       suffixIcon: Padding(
  //         padding: const EdgeInsets.only(right: 4),
  //         child:Container(
  //           width: 45,
  //           height: 45,
  //           decoration: const BoxDecoration(
  //             color: Colors.white,
  //             shape: BoxShape.circle,
  //           ),
  //           alignment: Alignment.center, // Center the child inside the circle
  //           child: SizedBox(
  //             width: 20,
  //             height: 20,
  //             child: UIHelper.customSvg(
  //               svg: "hourely-rate-icon-svg.svg",
  //               fit: BoxFit.contain, // Ensures proper scale within SizedBox
  //             ),
  //           ),
  //         ),
  //       ),
  //
  //     //  suffixIconConstraints: BoxConstraints.loose(const Size(AppConstants.iconSizeLarge, AppConstants.iconSizeLarge)),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   backgroundColor: AppColors.white,
        //   elevation: 0,
        //   leading: Padding(
        //     padding: const EdgeInsets.only(left: 16),
        //     child: GestureDetector(
        //       onTap: () => Get.back(),
        //       child: Container(
        //         height: 40,
        //         width: 40,
        //         padding: const EdgeInsets.all(8),
        //         decoration: const BoxDecoration(
        //           color: Color(0xFFCEDBF1),
        //           shape: BoxShape.circle,
        //         ),
        //         child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
        //       ),
        //     ),
        //   ),
        //   toolbarHeight: 80,
        // ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                color: AppColors.white,
                height: 80, // same as toolbarHeight
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
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

                  ],
                ),
              ),

              //const SizedBox(height: AppConstants.spacingLarge),
              UIHelper.boldText(
                text: 'Mentoring Setup',
                fontSize: 28,
                color: AppColors.textblue,
              ),
              const SizedBox(height: 8),
              UIHelper.mediumText(
                text: 'Provide us a little more details about you',
                fontSize: 14,
                color: AppColors.grey,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 40),

              // Toggle Tabs
              if (userRole == 'mentor')...[
                Row(
                  children: [
                    Expanded(
                      child: _buildToggleButton(
                        text: 'By Profession',
                        isSelected: _isByProfessionSelected,
                        onTap: () =>
                            setState(() => _isByProfessionSelected = true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildToggleButton(
                        text: 'By Lifecoaching',
                        isSelected: !_isByProfessionSelected,
                        onTap: () =>
                            setState(() => _isByProfessionSelected = false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],


              // Conditional Fields
              if (userRole == 'mentor') ...[
                _buildDropdown('Mentorship Category'),
                const SizedBox(height: 16),
                _buildDropdown('Mentorship Sub Category'),
                const SizedBox(height: 16),
              ] else if (userRole == 'tutor') ...[
                _buildDropdown('Teaching Field'),
                const SizedBox(height: 16),
              ],

              // Hourly Charges Input
              _buildHourlyChargesInput(),

              // const Spacer(),
              // GradientButton(
              //   text: "Proceed Further",
              //   onTap: () async {
              //     await StorageService.setMentoringSetup(true);
              //     Get.to(() => BankDetailsPage());
              //   },
              // ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLarge,
            vertical: 18,
          ),
          child: GradientButton(
            text: "Proceed Further",
            onTap: () async {
              await StorageService.setMentoringSetup(true);
              Get.to(() => BankDetailsPage());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.lightgreencolor,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isSelected ? AppColors.primary1 : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: UIHelper.mediumText(
          text: text,
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? AppColors.primary1
              : AppColors.text.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildDropdown(String title) {
    return Container(
      height: 56,
      padding: const EdgeInsets.only(right: 4, left: 16),
      //padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.lightgreencolor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UIHelper.mediumText(
            text: title,
            fontSize: 14,
            color: AppColors.black,
          ),
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyChargesInput() {
    return TextField(
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 16, color: AppColors.text),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightgreencolor,
        hintText: "Hourly Charges",
        hintStyle: AppFontStyles.beVietnamProMedium500.copyWith(
          fontSize: 16,
          color: AppColors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: UIHelper.customSvg(
              svg: "hourely-rate-icon-svg.svg",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
