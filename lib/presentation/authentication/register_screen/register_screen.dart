// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:learning_guru_app_app/routes/routes_name.dart';
//
// import '../../../routes/app_routes.dart';
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool isPasswordVisible = false;
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     phoneController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   void _registerUser() {
//     final name = nameController.text.trim();
//     final phone = phoneController.text.trim();
//     final email = emailController.text.trim();
//     final password = passwordController.text;
//
//     if (name.isEmpty || phone.isEmpty || email.isEmpty || password.isEmpty) {
//       Get.snackbar("Error", "All fields are required");
//       return;
//     }
//
//     // TODO: Connect to RegisterController / API
//     Get.snackbar("Success", "Registered successfully!");
//     Get.toNamed(RoutesName.login);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Register')),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 30),
//             const Text(
//               "Create Account",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 30),
//
//             // Name
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Full Name',
//                 prefixIcon: Icon(Icons.person_outline),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Phone
//             TextField(
//               controller: phoneController,
//               keyboardType: TextInputType.phone,
//               decoration: const InputDecoration(
//                 labelText: 'Phone',
//                 prefixIcon: Icon(Icons.phone_outlined),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Email
//             TextField(
//               controller: emailController,
//               keyboardType: TextInputType.emailAddress,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//                 prefixIcon: Icon(Icons.email_outlined),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Password
//             TextField(
//               controller: passwordController,
//               obscureText: !isPasswordVisible,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 prefixIcon: const Icon(Icons.lock_outline),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     isPasswordVisible ? Icons.visibility_off : Icons.visibility,
//                   ),
//                   onPressed: () =>
//                       setState(() => isPasswordVisible = !isPasswordVisible),
//                 ),
//                 border: const OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 30),
//
//             // Register Button
//             ElevatedButton(
//               onPressed: _registerUser,
//               child: const Text('Register'),
//             ),
//             const SizedBox(height: 12),
//
//             // Navigate to Login
//             TextButton(
//               onPressed: () => Get.toNamed(RoutesName.login),
//               child: const Text("Already have an account? Login"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/routes/app_routes.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/ui_helper.dart';
import '../../../utils/validation.dart';
import '../../../widgets/base_button.dart';
import '../../../widgets/custome_color_bg.dart';
import '../otp_verification_page/otp_verification_page.dart';
import '../user_selection/SelectionScree.dart';
import '../login_screen/login_screen.dart';
import '../../../res/colors/app_color.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController PhoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isCPasswordVisible = false;
  String userRole = '';

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  void _fetchUserRole() async {
    final role = await StorageService.getUserRole();
    if (role != null && role.isNotEmpty) {
      setState(() {
        userRole = role;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final media = MediaQuery.of(context);
    final height = media.size.height;
    final width = media.size.width;
    return WillPopScope(
      onWillPop: () async {
        Get.to(const UserSelectionScreen());
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: GradientBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              toolbarHeight: 0,
              backgroundColor: AppColors.white,
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  /// 🔹 FIXED BACKGROUND SVG
                  Positioned(
                    bottom: height * 0.05,
                    left: -width * 0.15,
                    child: SizedBox(
                      height: height * 0.3,
                      width: height * 0.3,
                      child: UIHelper.customSvg(svg: "sign-logo-svg.svg"),
                    ),
                  ),

                  /// 🔹 SCROLLABLE FORM

                  // Scrollable content
                  LayoutBuilder(
                    builder: (context, constraints){
                      return  SingleChildScrollView(
                        physics:PageScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.06,
                          vertical: height * 0.02,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(height: height * 0.02),

                                  UIHelper.boldText(
                                    text: 'Register',
                                    fontSize: height * 0.04,
                                    color: AppColors.textblue,
                                  ),
                                  SizedBox(height: height * 0.015),

                                  UIHelper.mediumText(
                                    text:
                                    'Please provide us your basic details below and get into the system',
                                    fontSize: height * 0.018,
                                    color: AppColors.grey,
                                  ),
                                  SizedBox(height: height * 0.05),

                                  // Conditional field
                                  userRole == 'student'
                                      ? _buildInputField(
                                    controller: PhoneNumberController,
                                    validator: Validator.validatePhoneNumber,
                                    hint: 'Phone Number',
                                    svgIcon: "phonenumber-icon-svg.svg",
                                    height: height,
                                  )
                                      : _buildInputField(
                                    controller: fullNameController,
                                    validator: Validator.validatePhoneNumber,
                                    hint: 'Full Name',
                                    svgIcon: "bank-user-icon-svg.svg",
                                    height: height,
                                  ),

                                  SizedBox(height: height * 0.025),

                                  _buildInputField(
                                    controller: emailController,
                                    validator: Validator.validateEmail,
                                    hint: 'Email ID',
                                    svgIcon: "email-icon-svg.svg",
                                    height: height,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: height * 0.025),

                                  _buildPasswordField(
                                    controller: passwordController,
                                    hint: 'Password',
                                    isVisible: isPasswordVisible,
                                    onToggle: () {
                                      setState(
                                            () =>
                                        isPasswordVisible = !isPasswordVisible,
                                      );
                                    },
                                    height: height,
                                  ),
                                  SizedBox(height: height * 0.025),

                                  _buildPasswordField(
                                    controller: cpasswordController,
                                    hint: 'Confirm Password',
                                    isVisible: isCPasswordVisible,
                                    onToggle: () {
                                      setState(
                                            () => isCPasswordVisible =
                                        !isCPasswordVisible,
                                      );
                                    },
                                    height: height,
                                  ),

                                  // SizedBox(
                                  //   height: height > 700
                                  //       ? height * 0.23  // Big devices
                                  //       : height * 0.05, // Small devices
                                  // ),
                                  const Spacer(),


                                  GradientButton(
                                    text: "Register",
                                    onTap: () async {
                                      await StorageService.setRegisterStatus(true);
                                      // Get.to(
                                      //       () => const OTPVerificationPage(
                                      //     source: "register",
                                      //   ),
                                      // );
                                     // Get.to(() => OTPVerificationPage(source: "register"));
                                      Get.toNamed(RoutesName.otpVerification, arguments: 'register');
                                    },
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      UIHelper.mediumText(
                                        text: 'Already on Learning Guru?',
                                        fontSize: width * 0.036,
                                        color: AppColors.text,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Navigator.pushReplacement(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) =>
                                          //     const LoginScreen(),
                                          //   ),
                                          // );
                                          Get.offAllNamed(RoutesName.login);

                                        },
                                        child: UIHelper.mediumText(
                                          text: 'Sign In',
                                          fontSize: width * 0.036,
                                          color: AppColors.textblue,
                                          fontWeight: FontWeight.bold,
                                          textDecoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02),
                                ],
                              ),
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
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String? Function(String?) validator,
    required String hint,
    required String svgIcon,
    required double height,
    TextInputType keyboardType = TextInputType.name,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(82),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[700]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: height * 0.025,
            vertical: height * 0.022,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: height * 0.005),
            child: Container(
              height: height * 0.06,
              width: height * 0.06,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: UIHelper.customSvg(
                svg: svgIcon,
                height: height * 0.025,
                width: height * 0.025,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool isVisible,
    required VoidCallback onToggle,
    required double height,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(82),
      ),
      child: TextFormField(
        validator: Validator.validatePassword,
        controller: controller,
        obscureText: !isVisible,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[700]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: height * 0.025,
            vertical: height * 0.022,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: height * 0.005),
            child: Container(
              height: height * 0.06,
              width: height * 0.06,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: UIHelper.customSvgOnTap(
                svg: "password-check.svg",
                height: height * 0.025,
                width: height * 0.025,
                onTap: onToggle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
