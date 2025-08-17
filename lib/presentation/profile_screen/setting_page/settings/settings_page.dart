import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/storage_service.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../res/constants/constants.dart';
import '../../../../utils/ui_helper.dart';

// Import all screen files for navigation
import '../../../authentication/user_selection/SelectionScree.dart';
import '../widgets/SelectLanguagePopUp.dart';
import 'screens/about_app_screen.dart';
import 'screens/change_password_screen.dart';
import 'screens/contact_us_screen.dart';
import 'screens/privacy_policy_screen.dart';
import 'screens/terms_conditions_screen.dart';

class SettingsScreen extends StatelessWidget {
  final RxBool isNotificationOn = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// AppBar
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Align(
          alignment: Alignment.centerRight,
          child: UIHelper.boldText(
            text: 'Settings',
            fontSize: 18,
            color: AppColors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
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
        toolbarHeight: 80,
      ),

      /// Body content
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Notification & Language Card
          _buildSettingsCard([
            Obx(
              () => _buildSwitchTile(
                title: "Notification",
                value: isNotificationOn.value,
                onChanged: (val) => isNotificationOn.value = val,
              ),
            ),
            const Divider(height: 1, color: AppColors.white),
            _buildLanguageTile(context),
          ]),
          const SizedBox(height: 20),

          /// Account Settings Card
          _buildSettingsCard([
            _buildTile(
              title: "Change Password",
              icon: "chnage-pwd-icon-svg.svg",
              onTap: () => Get.to(() => const ChangePasswordScreen()),
            ),
            const Divider(height: 1, color: AppColors.white),
            _buildTile(
              title: "Contact Us",
              icon: "Contactus-icon.svg",
              onTap: () => Get.to(() => const ContactUsScreen()),
            ),
            const Divider(height: 1, color: AppColors.white),
            _buildTile(
              title: "Terms & Conditions",
              icon: "tc-svg-icon.svg",
              onTap: () => Get.to(() => const TermsConditionsScreen()),
            ),
            const Divider(height: 1, color: AppColors.white),
            _buildTile(
              title: "Privacy Policy",
              icon: "privacy-svg-icon.svg",
              onTap: () => Get.to(() => const PrivacyPolicyScreen()),
            ),
            const Divider(height: 1, color: AppColors.white),
            _buildTile(
              title: "About Learning-Guru",
              icon: "about-lgl-svg-icon.svg",
              onTap: () => Get.to(() => const AboutAppScreen()),
            ),
          ]),
          const SizedBox(height: 20),

          /// Logout & Delete Account
          _buildSettingsCard([
            _buildTile(
              title: "Log Out",
              icon: "log-out-svg-icon.svg",
              iconColor: Colors.black,
              onTap: () {
                _showLogoutBottomSheet(context);
              },
            ),
            const Divider(height: 1, color: AppColors.white),
            _buildTile(
              title: "Delete Account",
              icon: "dlt-account-svg-icon.svg",
              textColor: AppColors.textblue,
              onTap: () {
                _showDeletAccountBottomSheet(context);
              },
            ),
          ]),
        ],
      ),
    );
  }

  /// Card wrapper
  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE6E8ED),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(children: children),
    );
  }

  /// Switch Tile (e.g., Notification toggle)
  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      title: UIHelper.boldText(
        text: title,
        fontSize: 16,
        color: AppColors.text,
        fontWeight: FontWeight.bold,
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: AppColors.primary1,
      ),
    );
  }

  /// Language Selector
  Widget _buildLanguageTile(BuildContext context) {
    return ListTile(
      title: UIHelper.boldText(
        text: "Language",
        fontSize: 16,
        color: AppColors.text,
        fontWeight: FontWeight.bold,
      ),
      trailing: Container(
        padding: const EdgeInsets.only(left: 12, top: 2, bottom: 2, right: 2),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF05004E)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Eng", style: TextStyle(color: Color(0xFF05004E))),
            SizedBox(width: 6),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: UIHelper.customSvg(svg: "drop-down-svg.svg", width: 3, height: 8),
            ),

            SizedBox(width: 12),
            CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage('assets/images/uk_flag.png'),
            ),
          ],
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const SelectLanguagePopUp(),
        );
      },
    );
  }

  /// Reusable Tile Widget
  Widget _buildTile({
    required String title,
    required String icon,
    required VoidCallback onTap,
    Color textColor = AppColors.text,
    Color iconColor = AppColors.primary1,
  }) {
    return ListTile(
      title: UIHelper.boldText(
        text: title,
        fontSize: 16,
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      trailing: UIHelper.customSvg(svg: icon),
      onTap: onTap,
    );
  }

  void _showLogoutBottomSheet(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingLarge,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: AppConstants.spacingExtraLarge * 2),
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
                                child: UIHelper.customSvg(
                                  svg: "big-logout-icon.svg",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 24),
                            UIHelper.boldText(
                              text: 'Sure you want to Log Out?',
                              fontSize: 18,
                              color: AppColors.textblue,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            UIHelper.regularText(
                              text:
                                  'Are you sure you want to log out from the Learning-Guru App?',
                              fontSize: 14,
                              color: AppColors.grey,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 40),
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
                                      child: UIHelper.customSvg(
                                        svg: "back-arrow-icon-svg.svg",
                                      ),
                                    ),
                                    onPressed: () => Get.back(),
                                  ),
                                  // const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF03002F),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(32),
                                        ),
                                      ),
                                      onPressed: () async {
                                        final prefs =
                                            await SharedPreferences.getInstance();
                                        await prefs
                                            .clear(); // Clear all stored data

                                        // Clear all saved preferences using StorageService
                                        await StorageService.clearAll();

                                        await StorageService.setIsLoggedIn(false);
                                        await StorageService.setRegisterStatus(
                                          false,
                                        );
                                        await StorageService.setProfileCompleted(
                                          false,
                                        );
                                        await StorageService.setDocumentsUploaded(
                                          false,
                                        );
                                        await StorageService.setBankDetailsUpdated(
                                          false,
                                        );

                                        Get.back(); // Close bottom sheet

                                        // Save language and close
                                        Get.back();
                                        await StorageService.getLoginRegisterStatus();
                                        await StorageService.setLoginRegisterStatus(
                                          true,
                                        ); // Restore registration status
                                        Get.offAll(
                                          () => const UserSelectionScreen(),
                                        );
                                      },
                                      child: const Text(
                                        'Log Out',
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
                            SizedBox(
                              height:
                                  MediaQuery.of(context).padding.bottom +
                                  AppConstants.spacingLarge,
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
      },
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
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingLarge,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: AppConstants.spacingExtraLarge * 2),
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
                                child: UIHelper.customSvg(
                                  svg: "big-dlt-icone.svg",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 24),
                            UIHelper.boldText(
                              text: 'You Deleting your Account?',
                              fontSize: 18,
                              color: AppColors.textblue,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            UIHelper.regularText(
                              text:
                                  'Are you really want to delete your  Student account? No data can be able to recover afterwards.',
                              fontSize: 14,
                              color: AppColors.grey,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 40),
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
                                      child: UIHelper.customSvg(
                                        svg: "back-arrow-icon-svg.svg",
                                      ),
                                    ),
                                    onPressed: () => Get.back(),
                                  ),
                                  // const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF03002F),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
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
                            SizedBox(
                              height:
                                  MediaQuery.of(context).padding.bottom +
                                  AppConstants.spacingLarge,
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
      },
    );
  }
}
