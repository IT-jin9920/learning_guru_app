import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/widgets/custome_color_bg.dart';
import '../../../../../res/colors/app_color.dart';
import '../../../../../res/constants/constants.dart';
import '../../../../../utils/ui_helper.dart';
import '../../../../../utils/validation.dart';
import '../../../../../widgets/base_button.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          toolbarHeight: 80,
          leading: IconButton(
            icon: Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFCEDBF1),
                shape: BoxShape.circle,
              ),
              child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
            ),
            onPressed: () => Get.back(),
          ),
          title: Align(
            alignment: Alignment.centerRight,
            child: UIHelper.boldText(
              text: 'Contact Us',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
        ),
      
        // body: SingleChildScrollView(
        //   padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLarge),
        //   child: Form(
        //     key: _formKey,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         const SizedBox(height: AppConstants.spacingLarge),
        //
        //         /// Email Field
        //         _buildTextField(
        //           controller: emailController,
        //           hintText: 'Email ID',
        //           svg: 'email-icon-svg.svg',
        //           inputType: TextInputType.emailAddress,
        //         ),
        //         const SizedBox(height: AppConstants.spacingMedium),
        //
        //         /// Subject Field
        //         _buildTextField(
        //           controller: subjectController,
        //           hintText: 'Your Subject',
        //           svg:  "about-svg-icon.svg",
        //         ),
        //         const SizedBox(height: AppConstants.spacingMedium),
        //
        //         /// Message Field
        //         _buildTextField(
        //           controller: messageController,
        //           hintText: 'Write your message...',
        //           svg: "about-svg-icon.svg",
        //           isMultiline: true,
        //         ),
        //         const SizedBox(height: AppConstants.spacingExtraLarge * 2),
        //
        //         /// Submit Button
        //         GradientButton(
        //           text: "Submit",
        //           onTap: _onSubmit,
        //         ),
        //         SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
        //       ],
        //     ),
        //   ),
        // ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstantsSpacing.paddingLarge,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppConstantsSpacing.spacingLarge),
      
                        /// Email Field
                        _buildTextField(
                          controller: emailController,
                          hintText: 'Email ID',
                          svg: 'email-icon-svg.svg',
                          inputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: AppConstantsSpacing.spacingMedium),
      
                        /// Subject Field
                        _buildTextField(
                          controller: subjectController,
                          hintText: 'Your Subject',
                          svg: "about-svg-icon.svg",
                        ),
                        const SizedBox(height: AppConstantsSpacing.spacingMedium),
      
                        /// Message Field
                        _buildMultiLineInputField(
                          'Write your message...',
                          "about-svg-icon.svg",
                          messageController,
                        ),

                        const SizedBox(
                          height: AppConstantsSpacing.spacingExtraLarge * 2,
                        ),
      
                        const Spacer(),
      
                        /// Submit Button
                        GradientButton(text: "Submit", onTap: _onSubmit),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Field builder (supports both single-line and multi-line)
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String svg,
    TextInputType inputType = TextInputType.text,
    bool isMultiline = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isMultiline ? TextInputType.multiline : inputType,
      maxLines: isMultiline ? 5 : 1,
      minLines: isMultiline ? 3 : 1,
      style: const TextStyle(fontSize: 16, color: AppColors.text),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightgreencolor,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 16, color: AppColors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstantsSpacing.paddingMedium,
          vertical: 18,
        ),
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
            child: UIHelper.customSvg(svg: svg, height: 25, width: 25),
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 36,
          minWidth: 36,
        ),
      ),
    );
  }


  Widget _buildMultiLineInputField(
      String hintText,
      String svg,
      TextEditingController controller,
      ) {
    return TextFormField(
      controller: controller,
      maxLines: 5,
      minLines: 3,
      keyboardType: TextInputType.multiline,
      style: const TextStyle(fontSize: 16, color: AppColors.text),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightgreencolor,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 16, color: AppColors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstantsSpacing.paddingMedium,
          vertical: 18,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(bottom: 45, right: 4),
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              color: Colors.white, // white background
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: UIHelper.customSvg(
              svg: svg,
              height: 25,
              width: 25,
            ),
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 36,
          minWidth: 36,
        ),
      ),
    );
  }

  /// Submit logic with validation
  void _onSubmit() {
    final email = emailController.text.trim();
    final subject = subjectController.text.trim();
    final message = messageController.text.trim();

    final emailError = Validator.validateEmail(email);
    final subjectError = subject.isEmpty ? "Subject cannot be empty" : null;
    final messageError = Validator.validateAbout(message);

    // if (emailError != null) {
    //   return _showSnackbar(emailError);
    // }
    // if (subjectError != null) {
    //   return _showSnackbar(subjectError);
    // }
    // if (messageError != null) {
    //   return _showSnackbar(messageError);
    // }

    // Submit Logic (API or DB)
    // Get.snackbar(
    //   "Submitted",
    //   "Thank you for contacting us!",
    //   backgroundColor: Colors.green.shade100,
    //   colorText: Colors.black,
    //   snackPosition: SnackPosition.TOP,
    //   duration: const Duration(seconds: 2),
    // );
    Get.back();

    // Optional: clear fields
    emailController.clear();
    subjectController.clear();
    messageController.clear();
  }

  /// Show snackbar
  void _showSnackbar(String message) {
    Get.snackbar(
      "Validation Error",
      message,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.black,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }


}
