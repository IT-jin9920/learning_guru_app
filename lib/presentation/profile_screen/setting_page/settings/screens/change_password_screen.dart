import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/widgets/custome_color_bg.dart';

import '../../../../../res/colors/app_color.dart';
import '../../../../../res/constants/constants.dart';
import '../../../../../utils/ui_helper.dart';
import '../../../../../utils/validation.dart';
import '../../../../../widgets/base_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController oldpasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();

  bool isoldPasswordVisible = false;
  bool isPasswordVisible = false;
  bool isCPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor:Colors.transparent,
        //backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Align(
            alignment: Alignment.centerRight,
            child: UIHelper.boldText(
              text: 'Change Password',
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
      
                const SizedBox(height: 40),
      
                // Password field
                _buildPasswordField(
                  controller: oldpasswordController,
                  hintText: 'Old Password',
                  isVisible: isoldPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      isoldPasswordVisible = !isoldPasswordVisible;
                    });
                  },
                  validator: Validator.validatePassword,
                  customSvgPath: 'assets/svg/pwd-eye-svg.svg',
                ),
                const SizedBox(height: 20),
      
                // Password field
                _buildPasswordField(
                  controller: passwordController,
                  hintText: 'New Password',
                  isVisible: isPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  validator: Validator.validatePassword,
                ),
                const SizedBox(height: 20),
      
                // Confirm Password field
                _buildPasswordField(
                  controller: cpasswordController,
                  hintText: 'Confirm New Password',
                  isVisible: isCPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      isCPasswordVisible = !isCPasswordVisible;
                    });
                  },
                  validator: (value) =>
                      Validator.validateConfirmPassword(passwordController.text, value),
                ),
      
                const SizedBox(height: 20),
                Spacer(),
                GradientButton(
                  text: "Save Changes",
                  onTap: () {
                    final oldpassword = oldpasswordController.text.trim();
                    final password = passwordController.text.trim();
                    final confirmPassword = cpasswordController.text.trim();
      
                    final oldpasswordError = Validator.validatePassword(oldpassword);
                    final passwordError = Validator.validatePassword(password);
                    final confirmError = Validator.validateConfirmPassword(password, confirmPassword);
      
                    // if (oldpasswordError != null) {
                    //   Get.snackbar(
                    //     'Validation Error',
                    //     oldpasswordError,
                    //     backgroundColor: Colors.red.shade100,
                    //     colorText: Colors.black,
                    //     snackPosition: SnackPosition.TOP,
                    //     duration: const Duration(seconds: 2),
                    //   );
                    //   return;
                    // }
                    //
                    // if (passwordError != null) {
                    //   Get.snackbar(
                    //     'Validation Error',
                    //     passwordError,
                    //     backgroundColor: Colors.red.shade100,
                    //     colorText: Colors.black,
                    //     snackPosition: SnackPosition.TOP,
                    //     duration: const Duration(seconds: 2),
                    //   );
                    //   return;
                    // }
                    //
                    // if (confirmError != null) {
                    //   Get.snackbar(
                    //     'Validation Error',
                    //     confirmError,
                    //     backgroundColor: Colors.red.shade100,
                    //     colorText: Colors.black,
                    //     snackPosition: SnackPosition.TOP,
                    //     duration: const Duration(seconds: 2),
                    //   );
                    //   return;
                    // }
      
                    // If both valid
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const LoginScreen()),
                    // );
      
                    Get.back();
      
                  },
      
                ),
                const SizedBox(height: AppConstants.spacingExtraLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
    required String? Function(String?) validator,
    String? customSvgPath,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(82),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: !isVisible,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[700]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  customSvgPath ?? 'assets/svg/password-check.svg',
                  width: 25,
                  height: 25,
                ),
                onPressed: onToggleVisibility,
              ),
            ),
          ),
        ),
      ),
    );
  }

}
