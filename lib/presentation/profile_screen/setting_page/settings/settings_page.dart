import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/core/constants/api_endpoints.dart';
import 'package:learning_guru_app/core/network/dio_client.dart';
import 'package:learning_guru_app/data/repositories/user_repository.dart';
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
    // Show the bottom sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Make the background transparent
      builder: (BuildContext context) {
        return BackdropFilter(
          // Apply a blur effect to the background
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets, // Adjust padding based on screen insets
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppConstantsSpacing.paddingLarge),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Keep the column height to a minimum
                children: [
                  const SizedBox(height: AppConstantsSpacing.spacingExtraLarge * 2),
                  // Container holding the actual content of the bottom sheet
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white, // White background
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
                            height: 150, // Icon's container height
                            decoration: const BoxDecoration(
                              color: Color(0xffe2eafb), // Light blue color for the container
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
                                  svg: "big-logout-icon.svg", // Display the logout icon
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Column for the text and buttons
                        Column(
                          children: [
                            SizedBox(height: 24),
                            // Title Text (confirmation prompt)
                            UIHelper.boldText(
                              text: 'Sure you want to Log Out?',
                              fontSize: 18,
                              color: AppColors.textblue,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            // Subtext (additional explanation)
                            UIHelper.regularText(
                              text: 'Are you sure you want to log out from the Learning-Guru App?',
                              fontSize: 14,
                              color: AppColors.grey,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 40),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  // Back Button
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
                                        svg: "back-arrow-icon-svg.svg", // Back arrow icon
                                      ),
                                    ),
                                    onPressed: () => Get.back(), // Close the bottom sheet
                                  ),
                                  Expanded(
                                    // Log Out Button
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF03002F), // Button color
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(32),
                                        ),
                                      ),
                                      // onPressed: () async {
                                      //   print("Logout account button pressed. Logout user data...");
                                      //   await _logoutUser();
                                      //
                                      //   // Clear login data
                                      //   //await StorageService.clearUserData();
                                      //   // Set the login status to false
                                      //   await StorageService.setIsLoggedIn(false);
                                      //   await StorageService.clearUserRole();
                                      //   //await StorageService.setRegisterStatus(false);
                                      //   // Close bottom sheet and navigate to user selection screen
                                      //   Get.back();
                                      //   Get.offAll(() => const UserSelectionScreen());
                                      // },
                                      onPressed: () async {
                                        print("Logout account button pressed. Logging out...");

                                        // Call the API to log out
                                        await _logoutUser();
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
                              height: MediaQuery.of(context).padding.bottom + AppConstantsSpacing.spacingLarge,
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
                              text: 'Are you sure you want to delete your Student account? No data can be recovered afterwards.',
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
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF03002F),
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(32),
                                        ),
                                      ),
                                      onPressed: () async {
                                        print("Delete account button pressed. Deleting user data...");

                                        // Delete all user data
                                        await StorageService.clearAll();
                                        print("User data deleted.");

                                        // Optionally, navigate to a different screen (e.g., Login screen)
                                        print("Navigating to UserSelectionScreen...");
                                        Get.offAll(() => const UserSelectionScreen());
                                      },
                                      child: const Text(
                                        'Yes, Delete',
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
                              height: MediaQuery.of(context).padding.bottom + AppConstantsSpacing.spacingLarge,
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

  Future<void> _logoutUser() async {
    // Show a loading indicator while logging out
    EasyLoading.show(status: 'Logging out...');

    try {
      // Step 1: Make the API call for logout using UserRepository
      final response = await UserRepository().logout();

      // Step 2: Handle API response
      if (response.isSuccess) {
        // Step 3: Clear user data on successful logout
        await StorageService.clearUserData();
        await StorageService.setIsLoggedIn(false);
        await StorageService.clearUserRole();

        // Step 4: Show success message and navigate to the login screen
        EasyLoading.dismiss();
        Get.snackbar(
          'Success',
          'You have successfully logged out.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade800,
          duration: const Duration(seconds: 3),
        );

        // Navigate to the login screen
        Get.offAll(() => const UserSelectionScreen());
      } else {
        // Step 5: Show error if logout failed
        EasyLoading.dismiss();
        Get.snackbar(
          'Error',
          'Logout failed. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade800,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Handle any network or other errors
      EasyLoading.dismiss();
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        duration: const Duration(seconds: 3),
      );
      print("Error logging out: $e");
    }
  }

}
