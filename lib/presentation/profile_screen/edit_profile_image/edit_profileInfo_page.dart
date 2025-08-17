import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/profile_screen/profile_page.dart';
import 'package:learning_guru_app/widgets/custome_color_bg.dart';

import '../../../core/services/storage_service.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/constants/constants.dart';
import '../../../utils/ui_helper.dart';
import '../../../utils/validation.dart';
import '../../../widgets/base_button.dart';

class EditProfileinfoPage extends StatefulWidget {
  const EditProfileinfoPage({super.key});

  @override
  State<EditProfileinfoPage> createState() => _EditProfileinfoPageState();
}

class _EditProfileinfoPageState extends State<EditProfileinfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

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


  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
       // backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Align(
            alignment: Alignment.centerRight,
            child: UIHelper.boldText(
              text: 'Edit Profile Info',
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
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingLarge,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppConstants.spacingLarge),
                        _buildInputField(
                          'Full Name',
                          "user-svg-icon.svg",
                          nameController,
                        ),
                        const SizedBox(height: AppConstants.spacingMedium),
                        _buildInputField(
                          'Phone Number',
                          "number-svg-icon.svg",
                          phoneController,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: AppConstants.spacingMedium),
                        _buildInputField(
                          'Email ID',
                          "email-icon-svg.svg",
                          emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: AppConstants.spacingMedium),


                      if (userRole == 'student')...[
                        _buildInputField(
                          'Birth Date',
                          "age-icon-svg.svg",
                          emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: AppConstants.spacingMedium),

                        _buildInputField(
                          'Standard Class',
                          "bag-iocon.svg",
                          emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: AppConstants.spacingMedium),
      ],

                        // const Spacer(), // ❌ REMOVE THIS
                        // const SizedBox(height: 32), // ✅ USE THIS INSTEAD
      
                        // GradientButton(
                        //   text: "Save Changes",
                        //   onTap: () {
                        //     final name = nameController.text.trim();
                        //     final phone = phoneController.text.trim();
                        //     final email = emailController.text.trim();
                        //
                        //     final nameError = Validator.validateName(name);
                        //     final phoneError = Validator.validatePhoneNumber(phone);
                        //     final emailError = Validator.validateEmail(email);
                        //
                        //     if (nameError != null) return _showError(nameError);
                        //     if (phoneError != null) return _showError(phoneError);
                        //     if (emailError != null) return _showError(emailError);
                        //
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => const ProfilePage(),
                        //       ),
                        //     );
                        //   },
                        // ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLarge, vertical: 18),
          child:    GradientButton(
            text: "Save Changes",
            onTap: () {
              final name = nameController.text.trim();
              final phone = phoneController.text.trim();
              final email = emailController.text.trim();

              final nameError = Validator.validateName(name);
              final phoneError = Validator.validatePhoneNumber(phone);
              final emailError = Validator.validateEmail(email);

              // if (nameError != null) return _showError(nameError);
              // if (phoneError != null) return _showError(phoneError);
              // if (emailError != null) return _showError(emailError);

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const ProfilePage(),
              //   ),
              // );

              Get.back();

            },
          ),
        ),
      ),
    );
  }

  void _showError(String message) {
    Get.snackbar(
      "Validation Error",
      message,
      backgroundColor: Colors.red.shade100,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.black,
    );
  }

  Widget _buildInputField(
      String hintText,
      String svg,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
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
          horizontal: AppConstants.paddingMedium,
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
              svg: svg,
              height: 20,
              width: 20,
            ),
          ),
        ),
        // suffixIconConstraints: const BoxConstraints(
        //   minHeight: 36,
        //   minWidth: 36,
        // ),
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
          horizontal: AppConstants.paddingMedium,
          vertical: 18,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 12),
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

}
