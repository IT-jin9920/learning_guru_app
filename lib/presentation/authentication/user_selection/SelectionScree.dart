import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/res/colors/app_color.dart';
import 'package:learning_guru_app/utils/ui_helper.dart';
import 'package:learning_guru_app/core/services/storage_service.dart'; // ✅ import
import '../../../routes/app_routes.dart';
import '../register_screen/register_screen.dart';

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({super.key});

  @override
  State<UserSelectionScreen> createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _loadSelectedRole();
  }

  Future<void> _loadSelectedRole() async {
    final role = await StorageService.getUserRole();
    setState(() {
      _selectedRole = role;
    });
  }

  Future<void> _selectRole(String role) async {

    // if (role == 'student') {
    //   // Show popup for Student
    //   Get.snackbar(
    //     'Coming Soon',
    //     'Student section is under development.',
    //     backgroundColor: Colors.orange.shade100,
    //     colorText: Colors.black,
    //     snackPosition: SnackPosition.TOP,
    //     duration: const Duration(seconds: 3),
    //   );
    //   return;
    // }

    await StorageService.saveUserRole(role);

    await StorageService.setRegistered(false);
    await StorageService.setIsLoggedIn(false);

    setState(() {
      _selectedRole = role;
    });
    print("User role => $role");

  //  Get.toNamed(RoutesName.login);
  //  Get.toNamed(RoutesName.walk);
    Get.offNamed(RoutesName.register);
  }

  // Future<void> _selectRole(String role) async {
  //   await StorageService.saveUserRole(role);
  //   Get.toNamed(RoutesName.walk); // Navigate directly after saving
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Confirm Exit App
        return await _confirmExit(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.primary1,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Welcome Text
              UIHelper.boldText(
                text: "Welcome to Learning Guru",
                fontSize: 22,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              UIHelper.mediumText(
                text: "Please select your role to proceed",
                fontSize: 16,
                color: Colors.white70,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Selection Cards
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      _buildRoleCard(
                        icon: Icons.school_outlined,
                        title: "I am a Student",
                        subtitle: "Explore courses and mentors",
                        roleValue: "student",
                      ),
                      const SizedBox(height: 20),
                      _buildRoleCard(
                        icon: Icons.person_outline,
                        title: "I am a Mentor",
                        subtitle: "Manage students and sessions",
                        roleValue: "mentor",
                      ),
                      const SizedBox(height: 20),
                      _buildRoleCard(
                        icon: Icons.person_outline,
                        title: "I am a Tutor",
                        subtitle: "Manage students and sessions",
                        roleValue: "tutor",
                      ),
                      const Spacer(),

                      // Show selected role at bottom
                      if (_selectedRole != null)
                        Text(
                          "You selected: ${_selectedRole!.capitalizeFirst}",
                          style: TextStyle(
                            color: AppColors.primary1,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
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

  Widget _buildRoleCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String roleValue,
  }) {
    return GestureDetector(
      onTap: () => _selectRole(roleValue),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.lightgreencolor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary1.withOpacity(0.1),
              child: Icon(icon, color: AppColors.primary1),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.semiBoldText(
                  text: title,
                  fontSize: 14,
                  color: AppColors.primary1,
                ),
                const SizedBox(height: 4),
                UIHelper.regularText(
                  text: subtitle,
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> _confirmExit(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Exit App?'),
      content: const Text('Do you really want to exit the app?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Yes'),
        ),
      ],
    ),
  );

  if (result ?? false) {
    _exitApp();
    return true;
  }
  return false;
}

void _exitApp() {
  if (Platform.isAndroid) {
    // Works on all Android versions including Android 16
    SystemNavigator.pop(); // Closes the app but allows it to be resumed
    // OR optionally:
    // exit(0); // Force kill (not recommended by Google)
  } else if (Platform.isIOS) {
    // iOS does not support programmatic exit; Apple discourages it.
    // However, exit(0) works but may lead to App Store rejection
    exit(0); // Force quit (works but NOT recommended for iOS apps)
  }
}
