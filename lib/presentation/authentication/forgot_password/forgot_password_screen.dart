import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/routes/app_routes.dart';
import 'package:learning_guru_app/widgets/custome_color_bg.dart';

import '../../../res/colors/app_color.dart';
import '../../../res/constants/constants.dart';
import '../../../utils/ui_helper.dart';
import '../../../utils/validation.dart';
import '../../../widgets/base_button.dart';
import '../login_screen/login_screen.dart';
import '../reset_password/reset_password_screen.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_emailFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: WillPopScope(
        onWillPop: () async {
         Get.to(LoginScreen());
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          //backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFCEDBF1), // #CEDBF1
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
                ),
              ),
            ),
        
            toolbarHeight: 80,
          ),
          body: GestureDetector(
           // onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstantsSpacing.paddingLarge,
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UIHelper.boldText(
                        text: 'Forgot Password',
                        fontSize: 32,
                        color: AppColors.textblue,
                      ),
                      const SizedBox(height: AppConstantsSpacing.spacingSmall),
                      UIHelper.mediumText(
                        text:
                            "Don't worry,just enter your number and we’ll send you a password recovery link.",
                        fontSize: 14,
                        color: AppColors.grey,
                      ),
                      const SizedBox(height: 40),
                      // Email ID Text Field
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          // Light green background
                          borderRadius: BorderRadius.circular(82),
                        ),
                        child: TextFormField(
                          autofocus: true,
                          controller: emailController,
                          focusNode: _emailFocusNode,
                          validator: Validator.validateEmail,
                          
                          decoration: InputDecoration(
                            hintText: 'Email ID',
                            hintStyle: TextStyle(color: Colors.grey[700]),
                            border: InputBorder.none,
                            // Remove default border
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.white, // white background
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: UIHelper.customSvg(
                                  svg: "email-icon-svg.svg",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(height: 120),
                      // Spacer(),
                      GradientButton(
                        text: "Submit",
                        onTap: () {
                          final email = emailController.text.trim();
                          final emailError = Validator.validateEmail(email);
                  
                          // if (emailError != null) {
                          //   Get.snackbar(
                          //     'Validation Error',
                          //     emailError,
                          //     backgroundColor: Colors.red.shade100,
                          //     colorText: Colors.black,
                          //     snackPosition: SnackPosition.TOP,
                          //     duration: const Duration(seconds: 2),
                          //   );
                          //   return;
                          // }
                  
                          // If valid, navigate
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
                          // );

                          Get.offAllNamed(RoutesName.resetPassword);

                        },
                      ),
                      const SizedBox(height: AppConstantsSpacing.spacingMedium),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // bottomNavigationBar: Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: AppConstants.paddingLarge,
          //     vertical: 18,
          //   ),
          //   child: GradientButton(
          //     text: "Submit",
          //     onTap: () {
          //       final email = emailController.text.trim();
          //       final emailError = Validator.validateEmail(email);
          //
          //       // if (emailError != null) {
          //       //   Get.snackbar(
          //       //     'Validation Error',
          //       //     emailError,
          //       //     backgroundColor: Colors.red.shade100,
          //       //     colorText: Colors.black,
          //       //     snackPosition: SnackPosition.TOP,
          //       //     duration: const Duration(seconds: 2),
          //       //   );
          //       //   return;
          //       // }
          //
          //       // If valid, navigate
          //       // Navigator.pushReplacement(
          //       //   context,
          //       //   MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
          //       // );
          //
          //       Get.to(ResetPasswordPage());
          //     },
          //   ),
          // ),
        ),
      ),
    );
  }
}
