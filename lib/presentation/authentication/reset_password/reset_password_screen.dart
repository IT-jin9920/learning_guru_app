import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/routes/app_routes.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/constants/constants.dart';
import '../../../utils/ui_helper.dart';
import '../../../utils/validation.dart';
import '../../../widgets/base_button.dart';
import '../../../widgets/custome_color_bg.dart';
import '../login_screen/login_screen.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isCPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: GestureDetector(
              onTap: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => const LoginScreen()),
                // );

                Get.offAllNamed(RoutesName.login);

              },
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
          ),
          toolbarHeight: 80,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLarge,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.boldText(
                  text: 'Reset Password',
                  fontSize: 32,
                  color: AppColors.textblue,
                ),
                const SizedBox(height: AppConstants.spacingSmall),
                UIHelper.mediumText(
                  text:
                      "Almost there, enter the new password you wish to set for your account",
                  fontSize: 14,
                  color: AppColors.grey,
                ),
                const SizedBox(height: 40),

                // Password field
                _buildPasswordField(
                  controller: passwordController,
                  hintText: 'Password',
                  isVisible: isPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  validator: Validator.validatePassword,
                  iconSvg: "eye-svg-pwd.svg",
                ),
                const SizedBox(height: 20),

                // Confirm Password field
                _buildPasswordField(
                  controller: cpasswordController,
                  hintText: 'Confirm Password',
                  isVisible: isCPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      isCPasswordVisible = !isCPasswordVisible;
                    });
                  },
                  validator: (value) => Validator.validateConfirmPassword(
                    passwordController.text,
                    value,
                  ),
                  iconSvg: "password-check.svg",
                ),

                const Spacer(),

                // GradientButton(
                //   text: "Proceed Further",
                //   onTap: () {
                //     final password = passwordController.text.trim();
                //     final confirmPassword = cpasswordController.text.trim();
                //
                //     final passwordError = Validator.validatePassword(password);
                //     final confirmError = Validator.validateConfirmPassword(password, confirmPassword);
                //
                //     // if (passwordError != null) {
                //     //   Get.snackbar(
                //     //     'Validation Error',
                //     //     passwordError,
                //     //     backgroundColor: Colors.red.shade100,
                //     //     colorText: Colors.black,
                //     //     snackPosition: SnackPosition.TOP,
                //     //     duration: const Duration(seconds: 2),
                //     //   );
                //     //   return;
                //     // }
                //     //
                //     // if (confirmError != null) {
                //     //   Get.snackbar(
                //     //     'Validation Error',
                //     //     confirmError,
                //     //     backgroundColor: Colors.red.shade100,
                //     //     colorText: Colors.black,
                //     //     snackPosition: SnackPosition.TOP,
                //     //     duration: const Duration(seconds: 2),
                //     //   );
                //     //   return;
                //     // }
                //
                //     // If both valid
                //     // Navigator.pushReplacement(
                //     //   context,
                //     //   MaterialPageRoute(builder: (context) => const LoginScreen()),
                //     // );
                //
                //     Get.to(LoginScreen());
                //   },
                //
                // ),
                const SizedBox(height: AppConstants.spacingExtraLarge),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLarge,
            vertical: 18,
          ),
          child: GradientButton(
            text: "Proceed Further",
            onTap: () {
              final password = passwordController.text.trim();
              final confirmPassword = cpasswordController.text.trim();

              final passwordError = Validator.validatePassword(password);
              final confirmError = Validator.validateConfirmPassword(
                password,
                confirmPassword,
              );

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

              Get.offAllNamed(RoutesName.login);
            },
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
    required String iconSvg,
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          // suffixIcon: Padding(
          //   padding: const EdgeInsets.only(right: 12),
          //   child: Container(
          //     height: 50,
          //     width: 50,
          //     decoration: const BoxDecoration(
          //       color: Colors.white,
          //       shape: BoxShape.circle,
          //     ),
          //     child: IconButton(
          //       icon: Icon(
          //         isVisible ? Icons.visibility_off : Icons.visibility,
          //         color: AppColors.grey,
          //         size: 25,
          //       ),
          //       onPressed: onToggleVisibility,
          //     ),
          //   ),
          // ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: UIHelper.customSvgOnTap(
                // svg: "password-check.svg",
                svg: iconSvg,
                height: 20,
                width: 20,
                onTap: onToggleVisibility,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
