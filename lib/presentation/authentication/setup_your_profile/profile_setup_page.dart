import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_guru_app/presentation/app_navigation/bottom_navigation_page.dart';
import 'package:learning_guru_app/routes/app_routes.dart';
import 'package:learning_guru_app/widgets/custome_color_bg.dart';

import '../../../core/services/storage_service.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/constants/constants.dart';
import '../../../utils/ui_helper.dart';
import '../../../utils/validation.dart';
import '../../../widgets/base_button.dart';
import '../mentor_details/mentor_setup_page.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  final TextEditingController ageController = TextEditingController();
  final TextEditingController youreduController = TextEditingController();

  String userRole = '';


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


  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //backgroundColor: AppColors.white,
        // appBar: AppBar(
        //   backgroundColor: AppColors.white,
        //   elevation: 0,
        //   leading: Padding(
        //     padding: const EdgeInsets.only(left: 16),
        //     child: GestureDetector(
        //       onTap: () =>  Get.back(),
        //       child: Container(
        //         height: 40,
        //         width: 40,
        //         decoration: const BoxDecoration(
        //           color: Color(0xFFCEDBF1),
        //           shape: BoxShape.circle,
        //         ),
        //         padding: const EdgeInsets.all(8),
        //         child: UIHelper.customSvg(svg: "back-arrow-icon-svg.svg"),
        //       ),
        //     ),
        //   ),
        //   toolbarHeight: 80,
        // ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLarge,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  color: AppColors.white,
                  height: 80, // same as toolbarHeight
                 padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
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
                      const SizedBox(width: 8),
                      // Add title text if needed
                      // const Text(
                      //   "Page Title",
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.w600,
                      //     color: Colors.black,
                      //   ),
                      // ),
                    ],
                  ),
                ),

                UIHelper.boldText(
                  text: 'Profile Setup',
                  fontSize: 32,
                  color: AppColors.textblue,
                ),
                const SizedBox(height: AppConstants.spacingSmall),
                UIHelper.mediumText(
                  text: 'Provide us a little more details about you',
                  fontSize: 14,
                  color: AppColors.grey,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: AppConstants.spacingExtraLarge),
                _buildInputField(
                  'Full Name',
                  "user-svg-icon.svg",
                  nameController,
                ),
                const SizedBox(height: AppConstants.spacingMedium),

                userRole == 'student' ? Column(
                  children: [

                    _buildInputField(
                      'Age',
                      "age-icon-svg.svg",
                      ageController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    _buildInputField(
                      'Your Education',
                      "bag-iocon.svg",
                      youreduController,
                    ),

                  ],
                ):
                Column(
                  children: [
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
                    _buildMultiLineInputField(
                      'Write About you (Max 300 words)',
                      "about-svg-icon.svg",
                      aboutController,
                    ),
                    const SizedBox(height: AppConstants.spacingExtraLarge * 2.8),
                  ],
                ),


                // GradientButton(
                //   text: "Proceed Further",
                //   onTap: () async {
                //     final name = nameController.text.trim();
                //     final phone = phoneController.text.trim();
                //     final email = emailController.text.trim();
                //     final about = aboutController.text.trim();
                //
                //     final nameError = Validator.validateName(name);
                //     final phoneError = Validator.validatePhoneNumber(phone);
                //     final emailError = Validator.validateEmail(email);
                //     final aboutError = Validator.validateAbout(about);
                //
                //     // if (nameError != null) {
                //     //   return _showError(nameError);
                //     // }
                //     // if (phoneError != null) {
                //     //   return _showError(phoneError);
                //     // }
                //     // if (emailError != null) {
                //     //   return _showError(emailError);
                //     // }
                //     // if (aboutError != null) {
                //     //   return _showError(aboutError);
                //     // }
                //
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //     builder: (context) => const MentoringSetupScreen(),
                //     //   ),
                //     // );
                //
                //     await StorageService.setProfileCompleted(true);
                //     print("setProfileCompleted true");
                //     Get.to(() => MentoringSetupScreen());
                //
                //   },
                // ),
                SizedBox(
                    height: MediaQuery.of(context).padding.bottom +
                        AppConstants.spacingLarge),
              ],
            ),
          ),
        ),
        bottomNavigationBar:   Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLarge,
            vertical: 18,
          ),
          child: userRole == 'student' ?
          GradientButton(
            text: "Submit",
            onTap: () async {
              final name = nameController.text.trim();
              final age = ageController.text.trim();
              final edu = youreduController.text.trim();

              //await StorageService.setProfileCompleted(true);
             // print("setProfileCompleted true");
             //  Get.to(() => BottomNavigationPage());
              Get.toNamed(RoutesName.navigation);


            },
          ):
            GradientButton(
            text: "Proceed Further",
            onTap: () async {
              final name = nameController.text.trim();
              final phone = phoneController.text.trim();
              final email = emailController.text.trim();
              final about = aboutController.text.trim();

              final nameError = Validator.validateName(name);
              final phoneError = Validator.validatePhoneNumber(phone);
              final emailError = Validator.validateEmail(email);
              final aboutError = Validator.validateAbout(about);

              // if (nameError != null) {
              //   return _showError(nameError);
              // }
              // if (phoneError != null) {
              //   return _showError(phoneError);
              // }
              // if (emailError != null) {
              //   return _showError(emailError);
              // }
              // if (aboutError != null) {
              //   return _showError(aboutError);
              // }

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const MentoringSetupScreen(),
              //   ),
              // );

              await StorageService.setProfileCompleted(true);
              print("setProfileCompleted true");
              // Get.to(() => MentoringSetupScreen());
              Get.toNamed(RoutesName.mentoringSetup);


            },
          ),
        ),
      ),
    );
  }

  // void _showError(String message) {
  //   Get.snackbar(
  //     "Validation Error",
  //     message,
  //     backgroundColor: Colors.red.shade100,
  //     snackPosition: SnackPosition.TOP,
  //     colorText: Colors.black,
  //   );
  // }

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
          horizontal: AppConstants.paddingMedium,
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
}
