// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:learning_guru_app/presentation/authentication/forgot_password/forgot_password_screen.dart';
//
// import '../../../core/services/storage_service.dart';
// import '../../../res/colors/app_color.dart';
// import '../../../res/constants/constants.dart';
// import '../../../routes/app_routes.dart';
// import '../../../utils/ui_helper.dart';
//
// import '../../../utils/validation.dart';
// import '../../../widgets/base_button.dart';
// import '../../../widgets/custome_color_bg.dart';
// import '../otp_verification_page/otp_verification_page.dart';
// import '../register_screen/register_screen.dart';
// import '../user_selection/SelectionScree.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool isPasswordVisible = false;
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   void _loginUser() async {
//     final email = emailController.text.trim();
//     final password = passwordController.text;
//
//     final emailError = Validator.validateEmail(email);
//     final passwordError = Validator.validatePassword(password);
//
//     // if (emailError != null) {
//     //   Get.snackbar("Email Error", emailError, backgroundColor: Colors.red.shade100);
//     //   return;
//     // }
//     //
//     // if (passwordError != null) {
//     //   Get.snackbar("Password Error", passwordError, backgroundColor: Colors.red.shade100);
//     //   return;
//     // }
//
//     // ✅ Simulated successful login
//     await StorageService.setLoginStatus(true);
//     //await StorageService.setRegisterStatus(true);
//
//    // Get.snackbar("Success", "Login successful!", backgroundColor: Colors.green.shade100);
//
//     // ✅ Move to OTP screen (simulate again or direct to home based on flow)
//     Get.to(() => const OTPVerificationPage(source: "login"));
//
//   }
//
//   @override
//   Widget build(BuildContext context) { // // onWillPop: () => _confirmExit(context),
//     return WillPopScope(
//       onWillPop: () async {
//         Get.to(UserSelectionScreen());
//         return false; // Prevent default system pop
//       },
//       child: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: GradientBackground(
//           child: Scaffold(
//             backgroundColor: Colors.transparent,
//            // backgroundColor: AppColors.white,
//             resizeToAvoidBottomInset: false,
//             body: Stack(
//
//               children: [
//                 // Positioned(
//                 //   bottom: 40,
//                 //   left: 5,
//                 //   child: UIHelper.customSvg(svg: "sign-logo-svg.svg"),
//                 // ),
//                 Padding(
//                   padding: const EdgeInsets.all(24.0),
//                   child: SingleChildScrollView(
//                    // physics: const BouncingScrollPhysics(),
//                     child: ConstrainedBox(
//                       constraints: BoxConstraints(
//                         minHeight: MediaQuery.of(context).size.height - 48,
//                       ),
//                       child: IntrinsicHeight(
//                         child: Form(
//                           key: _formKey,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // const SizedBox(height: 40),
//                               // UIHelper.boldText(
//                               //   text: 'Sign In',
//                               //   fontSize: 32,
//                               //   color: AppColors.textblue,
//                               //   fontWeight: FontWeight.bold,
//                               // ),
//
//                               SafeArea(
//                                 bottom: false,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const SizedBox(height: 16), // Extra spacing after SafeArea
//                                     UIHelper.boldText(
//                                       text: 'Sign In',
//                                       fontSize: 32,
//                                       color: AppColors.textblue,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 15),
//                               UIHelper.mediumText(
//                                 text:
//                                     'Please provide us your basic details below\nand get into the system',
//                                 fontSize: 14,
//                                 color: AppColors.grey,
//                               ),
//                               const SizedBox(height: 60),
//
//                               // Email Field
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFFE8F5E9),
//                                   borderRadius: BorderRadius.circular(82),
//                                 ),
//                                 child: TextFormField(
//                                   controller: emailController,
//                                   validator: Validator.validateEmail,
//                                   decoration: InputDecoration(
//                                     hintText: 'Email ID',
//                                     hintStyle: TextStyle(color: Color(0xff8994a0)),
//                                     border: InputBorder.none,
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 20,
//                                       vertical: 18,
//                                     ),
//                                     suffixIcon: Padding(
//                                       padding: const EdgeInsets.only(right: 4),
//                                       child: Container(
//                                         height: 50,
//                                         width: 50,
//                                         decoration: const BoxDecoration(
//                                           color: Colors.white,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         alignment: Alignment.center,
//                                         child: UIHelper.customSvg(
//                                           svg: "email-icon-svg.svg",
//                                           height: 20,
//                                           width: 20,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   keyboardType: TextInputType.emailAddress,
//                                 ),
//                               ),
//
//                               const SizedBox(height: 20),
//
//                               // Password Field
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFFE8F5E9),
//                                   borderRadius: BorderRadius.circular(82),
//                                 ),
//                                 child: TextFormField(
//                                   controller: passwordController,
//                                   obscureText: !isPasswordVisible,
//                                   validator: Validator.validatePassword,
//                                   decoration: InputDecoration(
//                                     hintText: 'Password',
//                                     hintStyle: TextStyle(color:Color(0xff8994a0)),
//                                     border: InputBorder.none,
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 20,
//                                       vertical: 18,
//                                     ),
//                                     // suffixIcon: Padding(
//                                     //   padding: const EdgeInsets.only(right: 12),
//                                     //   child: Container(
//                                     //     height: 50,
//                                     //     width: 50,
//                                     //     decoration: const BoxDecoration(
//                                     //       color: Colors.white,
//                                     //       shape: BoxShape.circle,
//                                     //     ),
//                                     //     // child: IconButton(
//                                     //     //   icon: Icon(
//                                     //     //     isPasswordVisible ? Icons.visibility_off : Icons.visibility,
//                                     //     //     color: AppColors.grey,
//                                     //     //     size: 25,
//                                     //     //   ),
//                                     //     //   onPressed: () {
//                                     //     //     setState(() {
//                                     //     //       isPasswordVisible = !isPasswordVisible;
//                                     //     //     });
//                                     //     //   },
//                                     //     // ),
//                                     //     Padding(
//                                     //       padding: const EdgeInsets.only(right: 12),
//                                     //       child: Container(
//                                     //         height: 50,
//                                     //         width: 50,
//                                     //         decoration: const BoxDecoration(
//                                     //           color: Colors.white,
//                                     //           shape: BoxShape.circle,
//                                     //         ),
//                                     //         alignment: Alignment.center,
//                                     //         child: UIHelper.customSvg(
//                                     //           svg: "email-icon-svg.svg",
//                                     //           height: 25,
//                                     //           width: 25,
//                                     //         ),
//                                     //       ),
//                                     //     ),
//                                     //
//                                     //   ),
//                                     // ),
//                                     suffixIcon: Padding(
//                                       padding: const EdgeInsets.only(right: 4),
//                                       child: Container(
//                                         height: 50,
//                                         width: 50,
//                                         decoration: const BoxDecoration(
//                                           color: Colors.white,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         alignment: Alignment.center,
//                                         child: UIHelper.customSvgOnTap(
//                                           svg: "password-check.svg",
//                                           height: 20,
//                                           width: 20,
//                                           onTap: () {
//                                             setState(() {
//                                               isPasswordVisible =
//                                                   !isPasswordVisible;
//                                             });
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//
//                               const SizedBox(height: 25),
//
//                               // Forgot Password
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: TextButton(
//                                   onPressed: () {
//                                     Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             const ForgotPasswordPage(),
//                                       ),
//                                     );
//                                   },
//                                   child: UIHelper.boldText(
//                                     text: 'Forgot Password?',
//                                     fontSize: 12,
//                                     color: AppColors.textblue,
//                                   ),
//                                 ),
//                               ),
//
//                               // SizedBox(height: 160,),
//                               SizedBox(
//                                 height: MediaQuery.of(context).size.height * 0.22, // 20% of screen height
//                               ),
//                               //const Spacer(),
//
//                               // Sign In Button
//                               GradientButton(text: "Sign In", onTap: _loginUser),
//
//                              // const SizedBox(height: 10),
//                               SizedBox(height: MediaQuery.of(context).size.height * 0.020),// just 1% space
//
//
//                               // Register Redirect
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   UIHelper.mediumText(
//                                     text: 'New to Learning Guru?',
//                                     fontSize: 14,
//                                     color: AppColors.text,
//                                   ),
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.pushReplacement(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                           const RegisterScreen(),
//                                         ),
//                                       );
//                                     },
//                                     child: UIHelper.mediumText(
//                                       text: 'Register',
//                                       fontSize: 14,
//                                       color: AppColors.textblue,
//                                       fontWeight: FontWeight.bold,
//                                       textDecoration: TextDecoration.underline,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: MediaQuery.of(context).size.height * 0.01), // just 1% space
//
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 Positioned(
//                   bottom: 50,
//                   left: -25,
//                   right: 200,
//                   child: Center(
//                     child: SizedBox(
//                       height: 250,
//                       width: 250,
//                       child: UIHelper.customSvg(svg: "sign-logo-svg.svg"),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // bottomNavigationBar: Padding(
//             //   padding: const EdgeInsets.symmetric(
//             //     horizontal: AppConstants.paddingLarge,
//             //     vertical: 18,
//             //   ),              child: Column(
//             //     children: [
//             //       // Sign In Button
//             //       GradientButton(text: "Sign In", onTap: _loginUser),
//             //
//             //       // const SizedBox(height: 10),
//             //       SizedBox(height: MediaQuery.of(context).size.height * 0.020),// just 1% space
//             //
//             //
//             //       // Register Redirect
//             //       Row(
//             //         mainAxisAlignment: MainAxisAlignment.center,
//             //         children: [
//             //           UIHelper.mediumText(
//             //             text: 'New to Learning Guru?',
//             //             fontSize: 14,
//             //             color: AppColors.text,
//             //           ),
//             //           TextButton(
//             //             onPressed: () {
//             //               Navigator.pushReplacement(
//             //                 context,
//             //                 MaterialPageRoute(
//             //                   builder: (context) =>
//             //                   const RegisterScreen(),
//             //                 ),
//             //               );
//             //             },
//             //             child: UIHelper.mediumText(
//             //               text: 'Register',
//             //               fontSize: 14,
//             //               color: AppColors.textblue,
//             //               fontWeight: FontWeight.bold,
//             //               textDecoration: TextDecoration.underline,
//             //             ),
//             //           ),
//             //         ],
//             //       ),
//             //     ],
//             //   ),
//             // ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Future<bool> _confirmExit(BuildContext context) async {
//   final result = await showDialog<bool>(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text('Exit App?'),
//       content: Text('Do you really want to exit the app?'),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(false),
//           child: Text('No'),
//         ),
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(true),
//           child: Text('Yes'),
//         ),
//       ],
//     ),
//   );
//
//   if (result == true) {
//     SystemNavigator.pop(); // Exits the app on Android
//     return true;
//   }
//   return false;
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/routes/app_routes.dart';

import '../../../core/services/storage_service.dart';
import '../../../res/colors/app_color.dart';
import '../../../utils/ui_helper.dart';
import '../../../utils/validation.dart';
import '../../../widgets/base_button.dart';
import '../../../widgets/custome_color_bg.dart';
import '../otp_verification_page/otp_verification_page.dart';
import '../register_screen/register_screen.dart';
import '../user_selection/SelectionScree.dart';
import '../forgot_password/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _loginUser() async {
    await StorageService.setLoginStatus(true);
    Get.to(() => const OTPVerificationPage(source: "login"));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return WillPopScope(
      onWillPop: () async {
        // Get.to(const UserSelectionScreen());
        Get.offAllNamed(RoutesName.userSelection);

        return false;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: GradientBackground(
          child: Scaffold(
            appBar: AppBar(toolbarHeight: 0, backgroundColor: AppColors.white),
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
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
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: PageScrollPhysics(),
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
                                  UIHelper.boldText(
                                    text: 'Sign In',
                                    fontSize: width * 0.08,
                                    color: AppColors.textblue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(height: height * 0.015),
                                  UIHelper.mediumText(
                                    text:
                                        'Please provide us your basic details\nbelow and get into the system',
                                    fontSize: width * 0.038,
                                    color: AppColors.grey,
                                  ),
                                  SizedBox(height: height * 0.08),

                                  /// Email Field
                                  _buildTextField(
                                    controller: emailController,
                                    hint: 'Email ID',
                                    validator: Validator.validateEmail,
                                    svgIcon: "email-icon-svg.svg",
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: height * 0.025),

                                  /// Password Field
                                  _buildTextField(
                                    controller: passwordController,
                                    hint: 'Password',
                                    validator: Validator.validatePassword,
                                    svgIcon: "password-check.svg",
                                    obscure: !isPasswordVisible,
                                    toggleVisibility: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                  ),
                                  SizedBox(height: height * 0.02),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      // onPressed: () => Navigator.pushReplacement(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (_) => const ForgotPasswordPage(),
                                      //   ),
                                      // ),
                                      onPressed: () => Get.offAllNamed(
                                        RoutesName.forgotPassword,
                                      ),
                                      child: UIHelper.boldText(
                                        text: 'Forgot Password?',
                                        fontSize: width * 0.032,
                                        color: AppColors.textblue,
                                      ),
                                    ),
                                  ),

                                  const Spacer(),

                                  GradientButton(
                                    text: "Sign In",
                                    onTap: _loginUser,
                                  ),
                                  SizedBox(height: height * 0.02),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      UIHelper.mediumText(
                                        text: 'New to Learning Guru?',
                                        fontSize: width * 0.036,
                                        color: AppColors.text,
                                      ),
                                      TextButton(
                                        onPressed: () => Get.offAllNamed(
                                          RoutesName.register,
                                        ),

                                        child: UIHelper.mediumText(
                                          text: 'Register',
                                          fontSize: width * 0.036,
                                          color: AppColors.textblue,
                                          fontWeight: FontWeight.bold,
                                          textDecoration:
                                              TextDecoration.underline,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String svgIcon,
    String? Function(String?)? validator,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? toggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(82),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xff8994a0)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: GestureDetector(
              onTap: toggleVisibility,
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: UIHelper.customSvg(svg: svgIcon, height: 20, width: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
